# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

pin "popper", to: "popper.js", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js"

pin "@fortawesome/fontawesome-svg-core", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-svg-core@6.4.2/index.mjs"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js", preload: true
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.1.2/app/assets/javascripts/rails-ujs.esm.js"

pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.9/src/index.js"
pin "@nathanvda/cocoon", to: "https://ga.jspm.io/npm:@nathanvda/cocoon@1.2.14/cocoon.js"
pin_all_from "app/javascript/controllers", under: "controllers"
