defmodule Erlangelist.Repo.Migrations.CreateLogArchive do
  use Ecto.Migration

  def change do
    create table(:request_log_archive) do
      add :path, :text
      add :ip, :text
      add :country, :text
      add :referer, :text
      add :user_agent, :text
      add :created_at, :datetime,
        null: false,
        default: fragment("(now() at time zone 'utc')")
    end
  end
end
