defmodule TodoWeb.API.TaskJSON do
  alias Todo.Tasks.Task

  @doc """
  Renders a list of tasks.
  """
  def index(%{tasks: tasks}) do
    %{data: for(task <- tasks, do: data(task))}
  end


  def error(changeset) do
    # %{data: changeset}
  end



  @doc """
  Renders a single task.
  """
  def show(%{task: task}) do
    %{data: data(task)}
  end

  def update(%{task: task}) do
    %{data: data(task)}
  end

  defp data(%Task{} = task) do
    %{
      id: task.id,
      position: task.position,
      status: task.status,
      content: task.content
    }
  end
end
