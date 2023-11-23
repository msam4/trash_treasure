# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "mapbox-gl", to: "https://ga.jspm.io/npm:mapbox-gl@2.15.0/dist/mapbox-gl.js"
pin "process", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/process-production.js"
pin "@mapbox/mapbox-gl-directions", to: "https://ga.jspm.io/npm:@mapbox/mapbox-gl-directions@4.1.1/src/index.js"
pin "@babel/runtime/helpers/esm/objectSpread2", to: "https://ga.jspm.io/npm:@babel/runtime@7.23.4/helpers/esm/objectSpread2.js"
pin "@mapbox/polyline", to: "https://ga.jspm.io/npm:@mapbox/polyline@1.2.1/src/polyline.js"
pin "deep-assign", to: "https://ga.jspm.io/npm:deep-assign@3.0.0/index.js"
pin "events", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/events.js"
pin "fuzzy", to: "https://ga.jspm.io/npm:fuzzy@0.1.3/lib/fuzzy.js"
pin "is-obj", to: "https://ga.jspm.io/npm:is-obj@1.0.1/index.js"
pin "lodash._reinterpolate", to: "https://ga.jspm.io/npm:lodash._reinterpolate@3.0.0/index.js"
pin "lodash.debounce", to: "https://ga.jspm.io/npm:lodash.debounce@4.0.8/index.js"
pin "lodash.isequal", to: "https://ga.jspm.io/npm:lodash.isequal@4.5.0/index.js"
pin "lodash.template", to: "https://ga.jspm.io/npm:lodash.template@4.5.0/index.js"
pin "lodash.templatesettings", to: "https://ga.jspm.io/npm:lodash.templatesettings@4.2.0/index.js"
pin "redux", to: "https://ga.jspm.io/npm:redux@4.2.1/es/redux.js"
pin "redux-thunk", to: "https://ga.jspm.io/npm:redux-thunk@2.4.2/es/index.js"
pin "suggestions", to: "https://ga.jspm.io/npm:suggestions@1.7.1/index.js"
pin "turf-extent", to: "https://ga.jspm.io/npm:turf-extent@1.0.4/index.js"
pin "turf-meta", to: "https://ga.jspm.io/npm:turf-meta@1.0.2/index.js"
pin "xtend", to: "https://ga.jspm.io/npm:xtend@4.0.2/immutable.js"
