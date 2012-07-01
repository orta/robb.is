oEmbed = window.oEmbed ?= {}

# A list of oEmbed providers and their respective endpoints
oEmbed.endpoints =
  'soundcloud.com' : 'https://soundcloud.com/oembed.json'
  'vimeo.com'      : 'https://vimeo.com/api/oembed.json'
  'youtube.com'    : 'http://api.embed.ly/1/oembed'

oEmbed.errorMessage = 'Failed to embed'

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
  parameters.push "#{k}=#{encodeURIComponent v}" for k, v of attributes
  parameters.push "#{k}=#{encodeURIComponent v}" for k, v of config

  # Create a request URL from the provider's oEmbed endpoint
  requestURL =  oEmbed.endpoints[provider]
  requestURL += '?' + parameters[0] + '&' + parameters[1..].join('&')

  success = (result) ->
    container = document.createElement 'div'
    container.classList.add 'embed'
    container.classList.add result?.type
    container.classList.add result?.provider_name.toLowerCase()

    container.innerHTML = result.html

    embed.parentNode.replaceChild container, embed

  error = ->
    container = document.createElement 'div'
    container.classList.add 'embed'
    container.classList.add 'failed'

    container.innerHTML = oEmbed.errorMessage

    embed.parentNode.replaceChild container, embed

  oEmbed.fetchJSON requestURL, {success, error}

oEmbed.fetchJSON = (url, {success, error}) ->
  xmlHTTP = XMLHttpRequest and new XMLHttpRequest() or
            new ActiveXObject 'Microsoft.XMLHTTP'

  xmlHTTP.onload = ->
    json = JSON.parse xmlHTTP.responseText
    success? json

  xmlHTTP.onerror = ->
    error?()

  xmlHTTP.addEventListener 'error', error, no

  xmlHTTP.open 'GET', url, yes
  xmlHTTP.send()
