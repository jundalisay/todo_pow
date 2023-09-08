defmodule TodoWeb.API.TaskController do
  use TodoWeb, :controller

  alias Todo.Repo
  alias Todo.Tasks
  alias Todo.Tasks.Task

  action_fallback TodoWeb.FallbackController

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, :index, tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
  #   with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", ~p"/api/tasks/#{task}")
  #     |> render(:show, task: task)
  #   end
  # end
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/tasks/#{task}")
        |> render(:show, task: task)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        # |> render("error.json", TodoWeb.Helpers.format_errors(changeset))
        |> render("error.json", changeset: changeset)        
    end
  end


  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, :show, task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{} = task} <- Tasks.update_task(task, task_params) do
      render(conn, :show, task: task)
    end
  end



 # def update(conn, %{"id" => id, "event" => event_params}) do
 #    event = Services.get_event!(id)

 #    case Services.update_event(event, event_params) do
 #      {:ok, event} ->
 #        conn
 #        |> put_flash(:info, "Event updated successfully.")
 #        |> redirect(to: ~p"/events/#{event}")

 #      {:error, %Ecto.Changeset{} = changeset} ->
 #        render(conn, :edit, event: event, changeset: changeset)
 #    end
 #  end

  def updatepos(conn, %{"id" => id, "position" => new_position}) do
    IO.puts "id: #{id}, position #{new_position}"
    task = Tasks.get_task!(id)
    Ecto.Changeset.change(task, %{position: new_position}) |> Repo.update!
    conn
    |> put_status(:created)
    |> html("")
  end



  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{}} <- Tasks.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
