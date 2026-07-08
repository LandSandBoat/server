-----------------------------------
-- Chocobo Raising
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

---@enum xi.chocoboRaising.color
xi.chocoboRaising.color =
{
    YELLOW = 0,
    BLACK  = 1,
    BLUE   = 2,
    RED    = 3,
    GREEN  = 4,
}

---@enum xi.chocoboRaising.honeymoonPlan
xi.chocoboRaising.honeymoonPlan =
{
    GOURMET    = 1, -- Plan A
    SPORTS     = 2, -- Plan B
    HIKING     = 3, -- Plan C
    JEUNO_TOUR = 4, -- Plan D
}

---@enum xi.chocoboRaising.statRank
xi.chocoboRaising.statRank =
{
    POOR            = 0, -- F
    SUBSTANDARD     = 1, -- E
    A_BIT_DEFICIENT = 2, -- D
    AVERAGE         = 3, -- C
    BETTER_THAN_AVG = 4, -- B
    IMPRESSIVE      = 5, -- A
    OUTSTANDING     = 6, -- S
    FIRST_CLASS     = 7, -- SS
}

---@enum xi.chocoboRaising.ability
xi.chocoboRaising.ability =
{
    NONE            = 0,
    GALLOP          = 1,
    CANTER          = 2,
    BURROW          = 3,
    BORE            = 4,
    AUTO_REGEN      = 5,
    TREASURE_FINDER = 6,
}

---@enum xi.chocoboRaising.temperament
xi.chocoboRaising.temperament =
{
    VERY_EASYGOING  = 0,
    ILL_TEMPERED    = 1,
    VERY_PATIENT    = 2,
    QUITE_SENSITIVE = 3,
    ENIGMATIC       = 4,
}

---@enum xi.chocoboRaising.gender
xi.chocoboRaising.gender =
{
    MALE   = 0,
    FEMALE = 1,
}

---@enum xi.chocoboRaising.weather
xi.chocoboRaising.weather =
{
    CLEAR        = 0,  -- Prefers clear, dislikes none
    HOT_SUNNY    = 1,  -- Prefers hot sunny, dislikes rainy
    RAINY        = 2,  -- Prefers rainy, dislikes thunderstorms
    SANDSTORMS   = 3,  -- Prefers sandstorms, dislikes windy
    WINDY        = 4,  -- Prefers windy, dislikes snowy
    SNOWY        = 5,  -- Prefers snowy, dislikes hot sunny
    THUNDERSTORM = 6,  -- Prefers thunderstorms, dislikes sandstorms
    AURORAS      = 7,  -- Prefers auroras, dislikes dark
    DARK         = 8,  -- Prefers dark, dislikes auroras
    NONE         = 9,  -- Prefers none, dislikes none
    CLOUDY       = 10, -- Prefers cloudy, dislikes none
}
