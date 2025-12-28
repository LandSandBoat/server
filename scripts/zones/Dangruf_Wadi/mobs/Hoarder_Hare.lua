-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Hoarder Hare
-- Note: PH for Teporingo
-----------------------------------
local ID = zones[xi.zone.DANGRUF_WADI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TEPORINGO, 20, 3600) -- 1 hour
end

return entity
