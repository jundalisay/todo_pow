defmodule Todo.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todo.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        password: "some password",
        password_confirmation: "some password",
        username: "some username",
      })
      |> Todo.Users.create_user()

    user
  end
end
