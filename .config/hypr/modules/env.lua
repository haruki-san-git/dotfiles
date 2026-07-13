-- modules/env.lua
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- SSH AUTHENTICATION
hl.env("SSH_AUTH_SOCK", (os.getenv("XDG_RUNTIME_DIR") or "") .. "/gcr/ssh")