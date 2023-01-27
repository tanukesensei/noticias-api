defmodule NoticiasWeb.PostController do
  use NoticiasWeb, :controller

  alias Noticias.News
  alias Noticias.News.Post

  action_fallback NoticiasWeb.FallbackController

  def index(conn, _params) do
    posts = News.list_posts()
    render(conn, :index, posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- News.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/posts/#{post}")
      |> render(:show, post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = News.get_post!(id)
    render(conn, :show, post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = News.get_post!(id)

    with {:ok, %Post{} = post} <- News.update_post(post, post_params) do
      render(conn, :show, post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = News.get_post!(id)

    with {:ok, %Post{}} <- News.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
