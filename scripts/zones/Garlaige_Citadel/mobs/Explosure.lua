-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Explosure
-- Note: PH for Hazmat
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
local entity = {}

local hazmatPHTable =
{
    [ID.mob.HAZMAT - 5] = ID.mob.HAZMAT,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 706, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, hazmatPHTable, 10, 3600) -- 1 hour
end

return entity
