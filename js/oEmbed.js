(function() {
  var oEmbed, _ref;

  oEmbed = (_ref = window.oEmbed) != null ? _ref : window.oEmbed = {};

  oEmbed.endpoints = {
    'soundcloud.com': 'https://soundcloud.com/oembed.json',
    'vimeo.com': 'https://vimeo.com/api/oembed.json',
    'youtube.com': 'http://api.embed.ly/1/oembed'
  };

  oEmbed.errorMessage = 'Encountered error :-/';

  oEmbed.config = {};

  oEmbed.parametersForNode = function(node) {
    var attributes, match, name, value, _i, _len, _ref2, _ref3;
    attributes = {};
    _ref2 = node.attributes;
    for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
      _ref3 = _ref2[_i], name = _ref3.name, value = _ref3.value;
      if (match = name.match(/^data-(.+)/)) attributes[match[1]] = value;
    }
    return attributes;
  };

  oEmbed.embed = function(embed, config) {
    var attributes, error, host, k, parameters, provider, requestURL, success, v, _ref2;
    if (config == null) config = {};
    attributes = this.parametersForNode(embed);
    host = attributes.url.match(/https?\:\/\/([^\/]+)(\/.+)?/)[1];
    provider = ((function() {
      var _results;
      _results = [];
      for (provider in this.endpoints) {
        if (host.match(provider)) _results.push(provider);
      }
      return _results;
    }).call(this))[0];
    parameters = [];
    _ref2 = oEmbed.config[provider];
    for (k in _ref2) {
      v = _ref2[k];
      parameters.push("" + k + "=" + (encodeURIComponent(v)));
    }
    for (k in attributes) {
      v = attributes[k];
      parameters.push("" + k + "=" + (encodeURIComponent(v)));
    }
    for (k in config) {
      v = config[k];
      parameters.push("" + k + "=" + (encodeURIComponent(v)));
    }
    requestURL = oEmbed.endpoints[provider];
    requestURL += '?' + parameters[0] + '&' + parameters.slice(1).join('&');
    success = function(result) {
      embed.classList.remove('loading');
      embed.classList.add('embed');
      embed.classList.add(result != null ? result.type : void 0);
      embed.classList.add(result != null ? result.provider_name.toLowerCase() : void 0);
      return embed.innerHTML = result != null ? result.html : void 0;
    };
    error = function() {
      var message;
      embed.classList.remove('loading');
      embed.classList.add('embed');
      embed.classList.add('failed');
      message = document.createElement('div');
      message.classList.add('message');
      message.innerText = oEmbed.errorMessage;
      return embed.appendChild(message);
    };
    embed.classList.add('loading');
    return oEmbed.fetchJSON(requestURL, {
      success: success,
      error: error
    });
  };

  oEmbed.fetchJSON = function(url, _arg) {
    var error, success, xmlHTTP;
    success = _arg.success, error = _arg.error;
    xmlHTTP = XMLHttpRequest && new XMLHttpRequest() || new ActiveXObject('Microsoft.XMLHTTP');
    xmlHTTP.onload = function() {
      var json;
      try {
        json = JSON.parse(xmlHTTP.responseText);
      } catch (e) {
        if (typeof error === "function") error();
        return;
      }
      return typeof success === "function" ? success(json) : void 0;
    };
    xmlHTTP.onerror = function() {
      return typeof error === "function" ? error() : void 0;
    };
    xmlHTTP.addEventListener('error', error, false);
    xmlHTTP.open('GET', url, true);
    return xmlHTTP.send();
  };

}).call(this);
