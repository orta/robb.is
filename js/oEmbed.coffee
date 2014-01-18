oEmbed = window.oEmbed ?= {}

# A list of oEmbed providers and their respective endpoints
oEmbed.endpoints =
  'soundcloud.com' : 'https://soundcloud.com/oembed.json'
  'vimeo.com'      : 'https://vimeo.com/api/oembed.json'
  'speakerdeck.com': 'http://api.embed.ly/1/oembed'
  'youtube.com'    : 'http://api.embed.ly/1/oembed'
  'wikipedia.org'  : 'http://api.embed.ly/1/oembed'
  'flickr.com'     : 'http://api.embed.ly/1/oembed'
  'xkcd.com'       : 'http://api.embed.ly/1/oembed'

oEmbed.errorMessage = 'Encountered error :-/'

oEmbed.config = {}

oEmbed.parametersForNode = (node) ->
  attributes = {}

  for {name, value} in node.attributes
    if match = name.match /^data-(.+)/
      attributes[match[1]] = value

  attributes

oEmbed.embed = (embed, config = {}) ->
  attributes = @parametersForNode embed

  # The host of this URL, including subdomains
  host = attributes.url.match(/https?\:\/\/([^\/]+)(\/.+)?/)[1]

  # The first provider matching this host
  provider = (provider for provider of @endpoints when host.match provider)[0]

  parameters = []
  parameters.push "#{k}=#{encodeURIComponent v}" for k, v of oEmbed.config[provider]
  parameters.push "#{k}=#{encodeURIComponent v}" for k, v of config
  parameters.push "#{k}=#{encodeURIComponent v}" for k, v of attributes

  # Create a request URL from the provider's oEmbed endpoint
  requestURL =  oEmbed.endpoints[provider]
  requestURL += '?' + parameters[0] + '&' + parameters[1..].join('&')

  success = (result) ->
    # Work around what appears to be a cache collision that sometimes mixes up
    # dynamically inserted iframes
    setTimeout ->
      embed.classList.remove 'loading'

      embed.classList.add 'embed'
      embed.classList.add result?.type
      embed.classList.add result?.provider_name.toLowerCase().replace /\s+/, '-'

      if result.type is 'photo'
        embed.innerHTML = "<img src='#{result.url}'>"
      else if result?.html
        embed.innerHTML = result.html

        if result.width? and result.height? and not result.width.toString().match '%'
          embed.dataset.aspectRatio = result.height / result.width

        window.dispatchEvent new Event 'resize'

      else
        embed.innerHTML = """
          <a href="#{result.url}">
            <img src="#{result.thumbnail_url}">
          </a>
        """
    , Math.random() * 10

  error = ->
    embed.classList.remove 'loading'
    embed.classList.add 'embed'
    embed.classList.add 'failed'

    message = document.createElement 'div'
    message.classList.add 'message'
    message.innerText = oEmbed.errorMessage

    embed.appendChild message

  embed.classList.add 'loading'

  oEmbed.fetchJSON requestURL, {success, error}

oEmbed.fetchJSON = (url, {success, error}) ->
  xmlHTTP = XMLHttpRequest and new XMLHttpRequest() or
            new ActiveXObject 'Microsoft.XMLHTTP'

  xmlHTTP.onload = ->
    try
      json = JSON.parse xmlHTTP.responseText
    catch e
      error?()
      return

    success? json

  xmlHTTP.onerror = ->
    error?()

  xmlHTTP.addEventListener 'error', error, no

  xmlHTTP.open 'GET', url, yes
  xmlHTTP.send()
