-----------------------------------
-- Area: Aydeewa Subterrane
--  Mob: Qiqirn Archaeologist
-- Note: PH for Bluestreak Gyugyuroon
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BLUESTREAK_GYUGYUROON, 10, 7200) -- 2 hours
end

return entity
