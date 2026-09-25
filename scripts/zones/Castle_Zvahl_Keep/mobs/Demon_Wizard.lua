-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Wizard
-- Note: PH for Baron Vapula
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BARON_VAPULA, 10, 1) -- No respawn
end

return entity
