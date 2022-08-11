# aos_flutter

AoS Playmat Builder in Flutter

  Background:
  
      Age of Sigmar (AoS) is a popular tabletop miniatures game.
      Players build and paint models to represent them and their faction on the gameboard. 
      There are many rules and players must follow step by step turns and remember all of their specfic rules.
      The sheer amount and numerous sources of information make the game daunting to most, and inaccessible so some.
  
  In order to tackle one of the game's most awkward elements, the current project proposes an assistive tool for new players.
  
  The proposed tool will have two main goals:
  
    1. To gather all player-specific rules in one place.
          - To avoid having to carry and flip through multiple large reference books.
    
    2. To organize the rules by order of when they are used during the game (by game "phase").
          - To avoid players forgetting rules or forgetting to use abilities at the right time.
          
          
  To achieve the goals of the tool, the following features are proposed:
      
    Buttons which display options based on previous choices and which follow a logical order.
   
    Buttons can be toggled: when "on" these buttons add to a running list of rules, when "off" they remove from the list.
   
    A display of the final list of rules, ordered by game "phase".
   
    The ability to save a completed rules list.
   
    The ability to retrieve and display a saved rules list.
  
  Feature Organization:
  
    1. A database (Firebase?).
      - For storing and retrieving player-specific rules.
      - For storing and retrieving user's saved rule lists.
      
    2. An API to connect the database to the business logic.
   
    3. Business logic:
      - Generate initial factions.
      - Based on user choices (via toggle buttons), generate the next group of choices.
          - The order of choices is based on the hierarchy of the game. 
              - Faction -> Subfaction -> Command Trait -> Artifacts -> Warscrolls -> Battalions
          - Certain choices will populate based on constraints of previous choices.
     - Based on user choices, store the rules associated with those choices in a list.
     - When the user finishes choosing and submits the final input, generate a rules list.
        - Based on all choicees made and ordered by game phase sequence.
            - Sequence based on the game:
                - Start of Game/ Out of Sqeuence -> Hero -> Movement -> Shooting -> Combat -> Battleshock
     - Save the rules list to the database.
     - Retrieve saved rules list from database.
     
     4. Presentation:
        - Display choices of each category via toggle buttons.
            - Toggle tells business logic to add/remove rules to list.
        - Upon navigation, display next page of choice buttons.
        - Upon completion of choices, display page of ordered rules list.
        - Upon activation of save retrieval, display saved list.
