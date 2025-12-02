-----------------------------------
-- Area: Alzadaal Undersea Ruins (72)
--  Mob: Qiqirn Goldsmith
-- Note: PH for Cookieduster Lipiroon
-----------------------------------
local ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.COOKIEDUSTER_LIPIROON, 5, 3600) -- 1 hour
end

return entity
