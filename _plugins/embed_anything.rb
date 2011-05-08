require 'net/https'
require 'uri'
require 'json'

module Jekyll
  class EmbedAnything < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      @config = context.registers[:site].config['embed_anything']

      generate_player @text
    end

    def resolve(uri)
      response = Net::HTTP.get_response(uri)

      unless response['location'].nil? and response['Location'].nil?
        resolve URI.parse(response['location']) or URI.parse(response['location'])
      else
        response.body
      end
    end

    def generate_player(url)
      if /https?:\/\/(www.)?soundcloud.com/ =~ @text
        soundcloud_player_for @text
      elsif /https?:\/\/(www.)?vimeo.com/ =~ @text
        vimeo_player_for @text
      elsif /https?:\/\/(www.)?youtube.com/ =~ @text
        youtube_player_for @text
      else
        raise Error.new "Count not embed #{url}"
      end
    end

    def get_soundcloud_resolve_url_for(url)
      soundcloud_api_key = @config['soundcloud']['api_key']

      if soundcloud_api_key.nil?
        raise Error.new "Cannot resolve SoundCloud URLs without a SoundCloud API Key"
      end

      url = CGI::escape(url)
      "http://api.soundcloud.com/resolve.json?url=#{url}&client_id=#{soundcloud_api_key}"
    end

    def soundcloud_player_for(url)
      sc_url   = get_soundcloud_resolve_url_for url
      raw_uri  = URI.parse sc_url
      json_rep = JSON.parse resolve raw_uri

      uri = json_rep["uri"]

      player = create_soundcloud_player uri
      "<div class='soundcloud embed'>
        #{player}
       </div>"
    end

    def create_soundcloud_player(uri)
      uri = CGI::escape(uri)

      parameters = ""
      @config['soundcloud']['parameters'].each {|key, value|
        parameters << "&amp;#{key}=#{value}"
      }

      height = @config['soundcloud']['height'] || '81px'
      width  = @config['soundcloud']['width']  || '100%'

      "<object height='#{height}' width='#{width}'>
         <param name='movie' value='http://player.soundcloud.com/player.swf?url=#{uri}#{parameters}'></param>
         <param name='allowscriptaccess' value='always'></param>
         <embed allowscriptaccess='always'
                width='#{width}'
                height='#{height}'
                src='http://player.soundcloud.com/player.swf?url=#{uri}#{parameters}'
                type='application/x-shockwave-flash'>
          </embed>
       </object>"
    end

    def get_vimeo_oembed_url_for(url)
      url = CGI::escape(url)
      
      parameters = ""
      @config['vimeo']['parameters'] ||= {}
      @config['vimeo']['parameters'].each {|key, value|
        parameters << "&#{key}=#{value}"
      }

      "http://vimeo.com/api/oembed.json?url=#{url}#{parameters}"
    end

    def vimeo_player_for(url)
      vimeo_url = get_vimeo_oembed_url_for url
      raw_uri   = URI.parse vimeo_url
      json_rep  = JSON.parse resolve raw_uri

      player     = json_rep['html']

      player.gsub!("><", ">\n<")

      "<div class='vimeo embed'>
       #{player}
      </div>"
    end

    def get_youtube_oembed_url_for(url)
       url = CGI::escape(url)

        parameters = ""
        @config['youtube']['parameters'] ||= {}
        @config['youtube']['parameters'].each {|key, value|
          parameters << "&#{key}=#{value}"
        }

      "http://www.youtube.com/oembed?url=#{url}&format=json#{parameters}"
    end

    def youtube_player_for(url)
      youtube_url = get_youtube_oembed_url_for url
      raw_uri     = URI.parse youtube_url
      json_rep    = JSON.parse resolve raw_uri

      player     = json_rep['html']

      player.gsub!("><", ">\n<")

      "<div class='youtube embed'>
         #{player}
       </div>"
    end
  end
end

Liquid::Template.register_tag('embed', Jekyll::EmbedAnything)