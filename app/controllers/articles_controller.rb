class ArticlesController < ApplicationController
	
	http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
	end
# this defintion creates an instance of a new Article that is set to the instance var
	def new
		@article = Article.new
	end
#this definition finds an existing article from the DB
	def edit
		@article = Article.find(params[:id])
	end
#this defintion uses the Create (CRUD) method and creates an instance of a new Article 
#that takes a defined private definition as an argument: (article_params) 
	def create
		@article = Article.new(article_params)
		
		if @article.save
			redirect_to @article
		else 
			render 'new' #here we explicitly tell rails to render the view new.html.erb 
		end
	end
#this definition uses the Update (CRUD) method to patch an existing article
	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end
	
	private
		def article_params
			params.require(:article).permit(:title, :text)
		end
end
