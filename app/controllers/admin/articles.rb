class Admin::ArticlesController < AdminController

	before_action :set_article, only: [:show, :edit, :update, :destroy]
	before_action :define_categories

	def index
		@articles = Article.all
		set_sidebar_collections
		@related_questions = Question.limit(4)
		@page_title = Block.find(7)
	end


	def show
		@articles = Article.published.limit(5)
		protect_unpublished @article
	end


	def new
		@article = Article.new
	end


	def edit

	end


	def create
		@article = Article.new(article_params)

		if @article.save
			redirect_to @article, notice: 'Статья успешно сотворена.'
		else
			render :new
		end
	end


	def update
		if @article.update(article_params)
			redirect_to @article, notice: 'Статья успешно обновлена.'
		else
			render :edit
		end
	end


	def destroy
		@article.destroy
		redirect_to articles_url, notice: 'Шива позаботился об этой статье.'
	end

	private

		include ProtectUnpublished

		def set_article
			@article = Article.find(params[:id])
		end

		def define_categories
			@categories = Category.all
		end


		def article_params
			params.require(:article).permit(
				:title,
				:text,
				:published,
				:commentable,
				:source_url,
				:author,
				:category_id,
				:published_at,
				:banner
			)
		end
end
