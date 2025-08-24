-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Sewer Syrup
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.SEWER_SYRUP - 2] = ID.mob.SEWER_SYRUP, -- -19.000 1.000 -173.000
    [ID.mob.SEWER_SYRUP - 1] = ID.mob.SEWER_SYRUP, -- -20.000 1.000 -148.000
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
