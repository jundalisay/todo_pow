# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Todo.Repo.insert!(%Todo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Todo.Repo
alias Todo.Users.User
alias Todo.Tasks.Task

User.changeset(%User{}, %{username: "Tom", password: "1234", password_confirmation: "1234"}) |> Repo.insert!()
User.changeset(%User{}, %{username: "Dick", password: "1234", password_confirmation: "1234"}) |> Repo.insert!()
User.changeset(%User{}, %{username: "Harry", password: "1234", password_confirmation: "1234"}) |> Repo.insert!()

Task.changeset(%Task{}, %{user_id: 1, content: "Tom's first task", position: 1}) |> Repo.insert!()
Task.changeset(%Task{}, %{user_id: 2, content: "Dick's first task", position: 1}) |> Repo.insert!()
Task.changeset(%Task{}, %{user_id: 3, content: "Harry's first task", position: 1}) |> Repo.insert!()