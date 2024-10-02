-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Kindred Red Mage
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.dynamis_beastmen)
    xi.applyMixins(mob, xi.mixins.job_special)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DUKE_BERITH_PH, 10, 1200) -- 20 minutes
end

return entity
