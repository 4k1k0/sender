defmodule Sender do
  def send_email("wako@animaniacs.com") do
    Process.sleep(10 * 1000)
    IO.puts("Email to wako was not sent")
    {:error, "email_junk"}
  end

  def send_email(email) do
    Process.sleep(2 * 1000)
    IO.puts("Email to #{email} sent")
    {:ok, "email_sent"}
  end


  def notify_all(emails) do
    emails
    |> Task.async_stream(&send_email/1, max_concurrency: 2, on_timeout: :kill_task)
    |> Enum.to_list()
  end
end
