json.session do
    json.username @session.username
    json.token @sessions.token
    json.authenticated @sessions.authenticated

    end