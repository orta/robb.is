oEmbed = window.oEmbed ?= {}

# A list of oEmbed providers and their respective endpoints
oEmbed.endpoints =
  'soundcloud.com' : 'https://soundcloud.com/oembed.json'
  'vimeo.com'      : 'https://vimeo.com/api/oembed.json'
  'embed.ly'       : 'http://api.embed.ly/1/oembed'

oEmbed.config =
  'embed.ly':
    key: '38d1bccb322844cd99d593cc0741be4d'

  'soundcloud.com':
    'hide_related': yes
    'visual': no

defaults = (obj) ->
  [obj, rest...] = arguments

  for source in rest
    obj[key] ?= val for key, val of source

  obj

oEmbed.embed = (embed, config = {}) ->
  # The host of this URL, including sub domains
  host = embed.dataset.url.match(/https?\:\/\/([^\/]+)(\/.+)?/)[1]

  # The first provider matching this host
  provider = (provider for provider of @endpoints when host.match provider)[0] or 'embed.ly'

  attributes = defaults {}, embed.dataset, config, oEmbed.config[provider]

  parameters = ("#{k}=#{encodeURIComponent v}" for k, v of attributes)

  # Create a request URL from the provider's oEmbed endpoint
  requestURL =  oEmbed.endpoints[provider]
  requestURL += '?' + parameters[0] + '&' + parameters[1..].join('&')

  success = (result) ->
    embed.classList.remove 'loading'

    embed.classList.add 'embed'
    embed.classList.add result?.type
    embed.classList.add result?.provider_name?.toLowerCase().replace /\s+/, '-'

    # Suppress a bug in SoundCloud's oEmbed implementation where the returned
    # iframe always contains 'visual=true' in its argument list.
    if result?.provider_name?.toLowerCase() is 'soundcloud' and not attributes.visual
      result.html = result?.html?.replace /visual\=(true|false)\&?/g, ''

    if result.type is 'photo'
      embed.innerHTML = "<img src='#{result.url}'>"
    else if result?.html
      embed.innerHTML = result.html

      if result.width? and result.height? and not result.width.toString().match '%'
        embed.dataset.aspectRatio = result.height / result.width

      window.dispatchEvent new Event 'resize'

    else if result.thumbnail_url?
      embed.innerHTML = """
        <a href="#{result.url}">
          <img src="#{result.thumbnail_url}">
        </a>
      """

  error = ->
    embed.classList.remove 'loading'
    embed.classList.add 'embed'
    embed.classList.add 'failed'

    message = document.createElement 'p'
    message.classList.add 'message'
    message.innerHTML = """
      <a href="#{attributes.url}>Click here</a>.
    """

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
