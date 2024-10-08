-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Fallen Mage
-- Note: Place holder Hovering Hotpot
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local hotpotPHTable =
{
    [ID.mob.HOVERING_HOTPOT - 3] = ID.mob.HOVERING_HOTPOT, -- 188.229 -0.018 20.151
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 703, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, hotpotPHTable, 20, math.random(1800, 3600)) -- 30 to 60 minutes
end

return entity
