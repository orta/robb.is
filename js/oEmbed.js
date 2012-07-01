(function() {
  var oEmbed, _ref;

  oEmbed = (_ref = window.oEmbed) != null ? _ref : window.oEmbed = {};

  oEmbed.endpoints = {
    'soundcloud.com': 'https://soundcloud.com/oembed.json',
    'vimeo.com': 'https://vimeo.com/api/oembed.json',
    'youtube.com': 'http://api.embed.ly/1/oembed'
  };

  oEmbed.errorMessage = 'Failed to embed';

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
      var container;
      container = document.createElement('div');
      container.classList.add('embed');
      container.classList.add(result != null ? result.type : void 0);
      container.classList.add(result != null ? result.provider_name.toLowerCase() : void 0);
      container.innerHTML = result.html;
      return embed.parentNode.replaceChild(container, embed);
    };
    error = function() {
      var container;
      container = document.createElement('div');
      container.classList.add('embed');
      container.classList.add('failed');
      container.innerHTML = oEmbed.errorMessage;
      return embed.parentNode.replaceChild(container, embed);
    };
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
      json = JSON.parse(xmlHTTP.responseText);
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
