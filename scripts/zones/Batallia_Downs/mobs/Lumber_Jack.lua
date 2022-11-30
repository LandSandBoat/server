-----------------------------------
-- Area: Batallia Downs (105)
--   NM: Lumber Jack
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
local ID = require('scripts/zones/Batallia_Downs/IDs')
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.UFASTCAST, 85)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 600)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
end

entity.onAdditionalEffect = function(mob, target, damage)
    if mob:hasStatusEffect(xi.effect.ENSTONE) then
        return 0, 0, 0
    else
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar("death", 1)
end

entity.onMobDespawn = function(mob)
    local lumberDeath = mob:getLocalVar("death")

    if lumberDeath then
        -- Lumber Jack died, Set Weeping Willow's proper respawn
        xi.mob.nmTODPersist(ID.mob.WEEPING_WILLOW, math.random(75600, 86400)) -- 21 to 24 hours
    else
        -- Lumber Jack idle despawned, set Weeping Willow quicker respawn
        xi.mob.nmTODPersist(ID.mob.WEEPING_WILLOW, 1800) -- 30 minutes
    end
end

return entity
