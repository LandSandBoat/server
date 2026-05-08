-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Hecteyes
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 606, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HYAKUME, 20, 1) -- Seems to be pure lottery
end

return entity
