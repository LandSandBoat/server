-----------------------------------
-- Area: Sacrarium
--   NM: Balor
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 30)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 11)
    mob:setRangedAttackEnabled(true) -- mixes melee + ranged attacks; no standback.
end

return entity
