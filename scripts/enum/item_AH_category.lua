-----------------------------------
-- Item Auction House Category
-----------------------------------
xi = xi or {}

---@enum xi.itemAHCategory
xi.itemAHCategory =
{
    NONE         =  0, -- Zero means does not appear in AH at all
    H2H          =  1, -- Weapons->H2h
    DAGGER       =  2, -- Weapons->Dagger
    SWORD        =  3, -- Weapons->Sword
    GREATSWORD   =  4, -- Weapons->Greatsword
    AXE          =  5, -- Weapons->Axe
    GREATAXE     =  6, -- Weapons->Greataxe
    SCYTHE       =  7, -- Weapons->Scythe
    POLEARM      =  8, -- Weapons->Polearm
    KATANA       =  9, -- Weapons->Katana
    GREATKATANA  = 10, -- Weapons->Greatkatana
    CLUB         = 11, -- Weapons->Club
    STAFF        = 12, -- Weapons->Staff
    BOW          = 13, -- Weapons->Bow
    INSTRUMENTS  = 14, -- Weapons->Instruments
    AMMUNITION   = 15, -- Weapons->Ammo&Misc->Ammunition
    SHIELD       = 16, -- Armor->Shield
    HEAD         = 17, -- Armor->Head
    BODY         = 18, -- Armor->Body
    HANDS        = 19, -- Armor->Hands
    LEGS         = 20, -- Armor->Legs
    FEET         = 21, -- Armor->Feet
    NECK         = 22, -- Armor->Neck
    WAIST        = 23, -- Armor->Waist
    EARRINGS     = 24, -- Armor->Earrings
    RINGS        = 25, -- Armor->Rings
    BACK         = 26, -- Armor->Back
    UNUSED       = 27,
    WHITE_MAGIC  = 28, -- Scrolls->White Magic
    BLACK_MAGIC  = 29, -- Scrolls->Black Magic
    SUMMONING    = 30, -- Scrolls->Summoning
    NINJUTSU     = 31, -- Scrolls->Ninjutsu
    SONGS        = 32, -- Scrolls->Songs
    MEDICINES    = 33,
    FURNISHINGS  = 34,
    CRYSTALS     = 35,
    CARDS        = 36, -- Others->Cards
    CURSED_ITEMS = 37, -- Others->Cursed Items
    SMITHING     = 38, -- Materials->Smithing
    GOLDSMITHING = 39, -- Materials->Goldsmithing
    CLOTHCRAFT   = 40, -- Materials->Clothcraft
    LEATHERCRAFT = 41, -- Materials->Leathercraft
    BONECRAFT    = 42, -- Materials->Bonecraft
    WOODWORKING  = 43, -- Materials->Woodworking
    ALCHEMY      = 44, -- Materials->Alchemy
    GEOMANCER    = 45, -- Scrolls->Geomancy
    MISC         = 46, -- Others->Misc.
    FISHING_GEAR = 47, -- Weapons->Ammo&Misc->Fishing Gear
    PET_ITEMS    = 48, -- Weapons->Ammo&Misc->Pet Items
    NINJA_TOOLS  = 49, -- Others->Ninja Tools
    BEAST_MADE   = 50, -- Others->Beast-made
    FISH         = 51, -- Food->Fish
    MEAT_EGGS    = 52, -- Food->Meals->Meat&Eggs
    SEAFOOD      = 53, -- Food->Meals->Seafood
    VEGETABLES   = 54, -- Food->Meals->Vegetables
    SOUPS        = 55, -- Food->Meals->Soups
    BREADS_RICE  = 56, -- Food->Meals->Breads&Rice
    SWEETS       = 57, -- Food->Meals->Sweets
    DRINKS       = 58, -- Food->Meals->Drinks
    INGREDIENTS  = 59, -- Food->Ingredients
    DICE         = 60, -- Scrolls->Dice
    AUTOMATON    = 61, -- Others->Automaton
    GRIPS        = 62, -- Weapons->Ammo&Misc->Grips
    ALCHEMY_2    = 63, -- Materials->Alchemy 2
    MISC_2       = 64, -- Others->Misc.2
    MISC_3       = 65, -- Others->Misc.3
}
