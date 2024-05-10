-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Fallen Major
-- Note: Place holder Hovering Hotpot
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
local entity = {}

local hotpotPHTable =
{
    [ID.mob.HOVERING_HOTPOT - 5] = ID.mob.HOVERING_HOTPOT, -- 182.157 -0.012 29.941
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 703, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, hotpotPHTable, 20, math.random(1800, 3600)) -- 30 to 60 minutes
end

return entity
