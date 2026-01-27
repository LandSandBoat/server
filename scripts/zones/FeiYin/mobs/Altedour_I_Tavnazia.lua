-----------------------------------
-- Area: Fei'Yin
--   NM: Altedour I Tavnazia
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- Altedour I Tavnazia seems to have a juiced version of Dimensional Death that needs to be tuned later

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 11)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 11)
    mob:setMod(xi.mod.STORETP, 140)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN, { chance = 5, power = math.random(50, 200) })
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.ITS_FINALLY_OVER)
end

return entity
