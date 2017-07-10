defmodule Poster.Repo do
  use Ecto.Repo, otp_app: :poster

  use Scrivener, page_size: 10
end
