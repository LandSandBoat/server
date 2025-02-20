-----------------------------------
-- Area: Fei'Yin
--   NM: Altedour I Tavnazia
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMod(xi.mod.REGAIN, 20)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN, { power = math.random(80, 90) })
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.ITS_FINALLY_OVER)
end

return entity
