-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Torama
-- Note: PH for Flauros
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.FLAUROS, 10, 3600) -- 1 hour
end

return entity
