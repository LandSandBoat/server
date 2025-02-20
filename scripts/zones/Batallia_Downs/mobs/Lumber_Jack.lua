-----------------------------------
-- Area: Batallia Downs (105)
--   NM: Lumber Jack
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.UFASTCAST, 85)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 600)
    mob:setMobMod(xi.mobMod.GIL_MIN, 15000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 7500)
end

entity.onAdditionalEffect = function(mob, target, damage)
    if mob:hasStatusEffect(xi.effect.ENSTONE) then
        return 0, 0, 0
    else
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar('death', 1)
end

entity.onMobDespawn = function(mob)
    local lumberDeath = mob:getLocalVar('death')

    if lumberDeath then
        -- Lumber Jack died, Set Weeping Willow's respawn time (21-24 hours)
        GetMobByID(mob:getID() -6):setRespawnTime(math.random(75600, 86400))
    else
        -- Lumber Jack idle despawned, set Weeping Willow to 30 min respawn
        GetMobByID(mob:getID() -6):setRespawnTime(1800)
    end
end

return entity
