-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Vanguard Persecutor
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BUBURIMU]
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
    xi.mob.phOnDespawn(mob, ID.mob.KOO_RAHI_THE_LEVINBLADE_PH, 10, 1200) -- 20 minutes
end

return entity
