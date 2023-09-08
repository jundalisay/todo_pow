defmodule TodoWeb.Router do
  use TodoWeb, :router
  use Pow.Phoenix.Router
  use Plug.ErrorHandler


  # @callback handle_errors(Plug.Conn.t(), %{
  #   kind: :error | :throw | :exit,
  #   reason: Exception.t() | term(),
  #   stack: Exception.stacktrace()
  # }) :: no_return()

  # defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
  #   conn |> json(%{error: message}) |> halt()
  # end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    conn |> json(%{error: conn.status}) |> halt()
    # send_resp(conn, conn.status, %{error: conn.status, message:  "Something went wrong"})
  end



  pipeline :api do
    plug :accepts, ["json"]
    plug TodoWeb.APIAuthPlug, otp_app: :todo
  end


  # scope "/" do
  #   pipe_through :browser

  #   pow_routes()
  # end

  scope "/api", TodoWeb do
    pipe_through :api
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: TodoWeb.APIAuthErrorHandler
  end

  # scope "/api/v1", TodoWeb.API.V1, as: :api_v1 do
  scope "/api", TodoWeb.API do    
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew

    put "/tasks/:id/updatepos", TaskController, :updatepos
    resources "/tasks", TaskController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
  end

  scope "/api", TodoWeb.API do
    pipe_through [:api, :api_protected]


  end

end



