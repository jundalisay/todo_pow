defmodule Todo.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema, 
  user_id_field: :username,
  password_min_length: 4

  import Ecto.Changeset

  schema "users" do
    pow_user_fields()

    timestamps()
  end

  @doc false
  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, [:username, :password, :password_hash])    
    |> pow_changeset(attrs)
    # |> unique_constraint(:username)
    # |> validate_required([:username, :password])
  end
end

