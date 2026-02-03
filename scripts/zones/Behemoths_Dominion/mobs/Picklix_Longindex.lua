-----------------------------------
-- Area: Behemoth's Dominion
--   NM: Picklix Longindex
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 11)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 11)
    mob:setMod(xi.mod.STORETP, 200)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.DEFENSE_DOWN, { chance = 5 })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
