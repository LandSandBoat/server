-----------------------------------
-- Escutcheons
-----------------------------------
xi = xi or {}
xi.escutcheon = xi.escutcheon or {}

--- Upgrade stage of Escutcheon
--- Determines the number of craftsmanship points required for 100%
--- Stored in shields exdata for client rendering of the Craftsmanship value
---@enum xi.escutcheon.stage
xi.escutcheon.stage =
{
    ASPIS  = 1, -- 3000
    ECU    = 2, -- 5000
    SCUTUM = 3, -- 10000
    SHIELD = 4, -- 30000
}

-- Bonus objectives sometimes shown on unfinished Escutcheons.
-- Source: ROM/220/58.DAT
---@enum xi.escutcheon.bonusObjective
xi.escutcheon.bonusObjective =
{
    PERFORM_A_SYNTHESIS        = 1,  -- Perform a synthesis
    CRAFT_DAYTIME              = 2,  -- Craft between 6:00 and 17:59
    CRAFT_NIGHTTIME            = 3,  -- Craft between 18:00 and 5:59
    CRAFT_RECRUIT_INITIATE     = 4,  -- Craft Recruit/Initiate recipes
    CRAFT_NOVICE_APPRENTICE    = 5,  -- Craft Novice/Apprentice recipes
    CRAFT_JOURNEYMAN_CRAFTSMAN = 6,  -- Craft Journeyman/Craftsman recipes
    CRAFT_ARTISAN_ADEPT        = 7,  -- Craft Artisan/Adept recipes
    CRAFT_VETERAN              = 8,  -- Craft Veteran recipes
    CRAFT_EXPERT_AND_HIGHER    = 9,  -- Craft Expert and higher recipes
    CRAFT_FIRE_CRYSTALS        = 10, -- Craft w/fire crystals
    CRAFT_ICE_CRYSTALS         = 11, -- Craft w/ice crystals
    CRAFT_WIND_CRYSTALS        = 12, -- Craft w/wind crystals
    CRAFT_EARTH_CRYSTALS       = 13, -- Craft w/earth crystals
    CRAFT_LIGHTNING_CRYSTALS   = 14, -- Craft w/lightning crystals
    CRAFT_WATER_CRYSTALS       = 15, -- Craft w/water crystals
    CRAFT_LIGHT_CRYSTALS       = 16, -- Craft w/light crystals
    CRAFT_DARK_CRYSTALS        = 17, -- Craft w/dark crystals
    CRAFT_ON_FIRESDAY          = 18, -- Craft on Firesday
    CRAFT_ON_ICEDAY            = 19, -- Craft on Iceday
    CRAFT_ON_WINDSDAY          = 20, -- Craft on Windsday
    CRAFT_ON_EARTHDAY          = 21, -- Craft on Earthday
    CRAFT_ON_LIGHTNINGDAY      = 22, -- Craft on Lightningday
    CRAFT_ON_WATERSDAY         = 23, -- Craft on Watersday
    CRAFT_ON_LIGHTSDAY         = 24, -- Craft on Lightsday
    CRAFT_ON_DARKSDAY          = 25, -- Craft on Darksday
    USE_3_MATERIALS            = 26, -- Use 3+ materials
    USE_5_MATERIALS            = 27, -- Use 5+ materials
    USE_7_MATERIALS            = 28, -- Use 7+ materials
}
