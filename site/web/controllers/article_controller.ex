defmodule Erlangelist.ArticleController do
  use Erlangelist.Web, :controller

  alias Erlangelist.Article
  alias Erlangelist.Metrics

  def most_recent(conn, _params) do
    render_article(conn, Article.most_recent)
  end

  def article(conn, %{"article_id" => article_id}) do
    render_article(conn, Article.article(Article.id_from_string(article_id)))
  end

  def article(conn, _params), do: render_not_found(conn)

  def article_from_old_path(%{private: %{article: article}} = conn, _params) do
    conn
    |> put_layout(:none)
    |> redirect(external: "/article/#{article.id}")
  end


  defp render_article(conn, %{has_content?: true} = article) do
    render(conn, "article.html", %{article: article, cookies: conn.cookies["cookies"]})
  end

  defp render_article(conn, _), do: render_not_found(conn)

  defp render_not_found(conn) do
    Metrics.inc_spiral([:article, :invalid_article, :requests])
    render(put_status(conn, 404), Erlangelist.ErrorView, "404.html")
  end
end
