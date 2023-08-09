defmodule Sender do
  def send_email(email) do
    Process.sleep(7 * 1000)
    IO.puts("Email to #{email} sent")
    {:ok, "email_sent"}
  end


  def notify_all(emails) do
    emails
    |> Task.async_stream(&send_email/1, max_concurrency: 2, on_timeout: :kill_task)
    |> Enum.to_list()
  end
end
