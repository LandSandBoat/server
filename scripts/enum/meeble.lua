-----------------------------------
-- Meeble Burrows
-----------------------------------
xi = xi or {}
xi.meeble = xi.meeble or {}

-- Use to set appropriate bit for completion in Grimoire exdata
---@enum xi.meeble.expeditionType
xi.meeble.expeditionType =
{
    ADJUNCT        = 1,
    ASSISTANT      = 2,
    INSTRUCTOR     = 3,
    ASC_RESEARCHER = 4, -- Not available in Batallia
    RESEARCHER     = 5, -- Not available in Batallia
}

-- Zone stored in Meeble Grimoires exdata
-- Grimoires are locked to a single zone
---@enum xi.meeble.zone
xi.meeble.zone =
{
    SAUROMUGUE_CHAMPAIGN = 0,
    BATALLIA_DOWNS       = 1,
}
