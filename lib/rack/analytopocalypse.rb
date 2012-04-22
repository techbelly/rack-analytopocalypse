require 'thread'

module Rack #:nodoc:
  class Analytopocalypse < Struct.new :app, :options

    def call(env)
      status, headers, response = app.call(env)
      @queue ||= Queue.new
      if headers["Content-Type"] =~ /text\/html|application\/xhtml\+xml/
        if (@queue.length >= 5)   
          url_to_report = @queue.pop(true)
          body = ""
          response.each { |part| body << part }
          index = body.rindex("</head>")
          if index
            body.insert(index, tracking_code(options[:web_property_id],url_to_report))
            headers["Content-Length"] = body.length.to_s
            response = [body]
          end
        end  
        request = Rack::Request.new(env)
        @queue.push(request.path)
      end

      [status, headers, response]
    end

    protected

      def tracking_code(web_property_id,url_to_report)
        return <<-EOF
<script type="text/javascript">
if (typeof gaJsHost == 'undefined') {
  var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
  document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
}
</script>
<script type="text/javascript">
try {
var gaa_pageTracker = _gat._getTracker("#{web_property_id}");
gaa_pageTracker._trackPageview(#{url_to_report});
} catch(err) {}</script>
EOF
      end
  end
end