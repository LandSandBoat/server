-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Torama
-- Note: PH for Flauros
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.FLAUROS, 10, 3600) -- 1 hour
end

return entity
