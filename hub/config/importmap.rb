# Pin npm packages by running ./bin/importmap
pin "@rails/actioncable", to: "actioncable.esm.js"
# pin "@rails/activestorage", to: "activestorage.esm.js"
# pin "@rails/actiontext", to: "actiontext.esm.js"
# pin "trix"

pin "application"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
