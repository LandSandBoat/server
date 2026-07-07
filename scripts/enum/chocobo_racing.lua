-----------------------------------
-- Chocobo Racing
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

-- Chocobo Racing Jockey Orders
---@enum xi.chocoboRacing.order
xi.chocoboRacing.order =
{
    SPRINT      = 0, -- Top speed from the start until 75% stamina, then eases off
    KEEP_PACE   = 1, -- Steady pace, even stamina drain, holds position
    FINAL_SPURT = 2, -- Holds back >=25% stamina for a top-speed finish
}

-- Stored in Chocobet and Completion Certificates exdata
---@enum xi.chocoboRacing.raceGrade
xi.chocoboRacing.raceGrade =
{
    ALTANA_CUP_II = 11,
    C1            = 12,
    C2            = 13,
    C3            = 14,
    C4            = 15,
}

-- Stored in Egg and Chococards exdata
---@enum xi.chocoboRacing.jockeySize
xi.chocoboRacing.jockeySize =
{
    GALKA      = 0,
    HUME_M     = 1,
    HUME_F     = 2,
    ELVAAN_M   = 3,
    ELVAAN_F   = 4,
    TARUTARU_M = 5,
    TARUTARU_F = 6,
    MITHRA     = 7,
}

-- Per-section race events.
---@enum xi.chocoboRacing.sectionEvent
xi.chocoboRacing.sectionEvent =
{
    STRAINING          = 0x00, -- Low-stamina state
    SPEED_APPLE        = 0x01,
    STAMINA_APPLE      = 0x02,
    SHADOW_APPLE       = 0x03,
    PEPPER_BISCUIT     = 0x04, -- Target in Param
    FIRE_BISCUIT       = 0x05, -- Target in Targets
    GYSAHL_BOMB        = 0x06,
    SPORE_BOMB         = 0x07,
    FAIRWEATHER_FETISH = 0x08,
    FOULWEATHER_FROG   = 0x09,
    RACE_START         = 0x20,
    ACCIDENT           = 0x21, -- "feet caught in mud". Rainy races only.
}
