defmodule Noticias.NewsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Noticias.News` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        description: "some description",
        title: "some title"
      })
      |> Noticias.News.create_post()

    post
  end
end
