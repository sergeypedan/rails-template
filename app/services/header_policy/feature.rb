# frozen_string_literal: true

module HeaderPolicy
  class Feature < HeaderPolicy::Base

    def call
      feature_strings.join(PARTS_SEPARATOR)
    end

    private

    def feature_strings
      [
                  "accelerometer 'none'",
           "ambient-light-sensor 'none'",
                   # "animations 'none'",
                       "autoplay https://youtube.com",
                         "camera 'none'",
              # "document-domain 'none'",
               # "document-write 'none'",
                "encrypted-media 'none'",
                   # "fullscreen 'none'",
                    "geolocation 'none'",
                      "gyroscope 'none'",
            # "image-compression 'none'",
         # "legacy-image-formats 'none'",
                   "magnetometer 'none'",
        # "max-downscaling-image 'none'",
                     "microphone 'none'",
                           "midi 'none'",
                        "payment 'none'",
           # "picture-in-picture 'self' ",
                        "speaker 'none'",
                     # "sync-xhr 'none'",
                # "unsized-media 'none'",
                            "usb 'none'",
              # "vertical-scroll 'none'",
                             "vr 'none'"
      ]
    end

  end
end
