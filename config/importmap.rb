pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "vendor-bundle", to: "vendor.bundle.base.js", preload: false
pin "template", to: "template.js", preload: false
pin "off-canvas", to: "off-canvas.js", preload: false  
pin "hoverable-collapse", to: "hoverable-collapse.js", preload: false