-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Gespenst
-- Note: PH for Manes
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MANES, 5, 3600) -- 1 hour
end

return entity
