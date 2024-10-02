-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Vanguard Ronin
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
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
    xi.mob.phOnDespawn(mob, ID.mob.SHISOX_WIDEBROW_PH, 10, 1200) -- 20 minutes
end

return entity
