module HeadshotHelper
  def headshot_default_config(session_key, capture_path, options = {})
    #options.reverse_merge!(headshot_default_options)
    session_value = u(cookies[session_key])
    raw(%{
    <script language="JavaScript">
        var params = {
            session_key_name: encodeURIComponent('#{session_value}'),
            csrf_token: encodeURI(encodeURI(headshotUtils.getPageMetaValue('csrf-token')))
        };
        var headshotHandlers = {
            onComplete: function(msg) {
                headshot.reset();
            },
            snap: function() {
                headshot.snap();
            }
        }
        headshot.set_swf_url('#{options[:swf_url]}');
        headshot.set_api_url('#{capture_path}');
        headshot.set_quality(#{options[:quality]});
        headshot.set_shutter_sound(#{options[:shutter_sound]}, '#{options[:shutter_sound_url]}');
        headshot.set_hook('onComplete', '#{options[:on_complete]}');
    </script>
    })
  end
end
