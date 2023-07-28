
# RecipeAppViper
## Modules
  1.RecipeList
  
  2.RecipeDetail

  2.RecipeMap

  
## View 
— Responsibility of view is to send user actions to the presenter and show whatever the presenter asks it to. In our case we next the classes:
 1.RecipeList
 
    - RecipesSearchViewController,RecipeCell
    
 2.RecipeDetail
    - RecipeDetailViewController
    
    - IngredientsCell
    


## Interactor 
— It has the business logic for the app specified by a use case.

 1.RecipeList
 
    - RecipeDetailInteractor
    
 2.RecipeDetail
 
    - RecipeListInteractor
    
## Presenter 
— Contains the view logic for preparing content for display and for reacting to user interactions.
 1.RecipeList
 
    - RecipesListPresenter
    
 2.RecipeDetail
 
    - RecipeDetailPresenter

## Entity 
— The Basic model for objects used by interaction.
 1.RecipeList
 
    - RecipeEntity
    
 2.RecipeDetail
 
    - RecipeDetailEntity
    - ExtendedIngredientEntity
    
    

## ViewModel
— Mapper for transformate the entity to the view model.
 1.RecipeList
 
    - RecipeListViewModel
    - RecipeListMapper
    
 2.RecipeDetail
 
    - RecipeDetailViewModel
    - ExtendIngredientViewModel
    - ExtendIngredientViewModel
    - ExtendedIngredientMapper


RecipeEntity
## Router 
— Contains logic for routing of screens.
 1.RecipeList
 
    - RecipeListRouter
    
 2.RecipeDetail
 
    - RecipeDetailRouter

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)

