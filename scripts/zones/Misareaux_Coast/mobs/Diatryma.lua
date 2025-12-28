-----------------------------------
-- Area: Misareaux_Coast
--  Mob: Diatryma
-- Note: PH for Okyupete
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.OKYUPETE, 10, 3600) -- 1 hour
end

return entity
