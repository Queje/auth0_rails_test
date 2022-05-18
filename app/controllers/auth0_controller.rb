class Auth0Controller < ApplicationController
  def callback
    auth_info = request.env['omniauth.auth']
    session[:userinfo] = auth_info['extra']['raw_info']

    # Redirect to the URL you want after successful auth
    redirect_to '/posts'
  end

  def failure
    @error_msg = request.params['message']
  end

  def logout
    reset_session
    redirect_to logout_url
  end

  private

  def logout_url
    request_params = {
      returnTo: 'http://localhost:3000/posts',
      client_id: AUTH0_CONFIG['auth0_client_id']
    }

    URI::HTTPS.build(host: 'quejeweb.eu.auth0.com', path: '/v2/logout', query: request_params.to_query).to_s
  end
end
