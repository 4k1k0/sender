defmodule Sender do
  def send_email("wako@animaniacs.com" = email) do
    raise "Oops, couldn't sned email to #{email}!"
  end

  def send_email(email) do
    Process.sleep(2 * 1000)
    IO.puts("Email to #{email} sent")
    {:ok, "email_sent"}
  end


  def notify_all(emails) do
    Sender.EmailTaskSupervisor
    |> Task.Supervisor.async_stream_nolink(emails, &send_email/1)
    |> Enum.to_list()
  end
end
