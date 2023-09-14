-----------------------------------
-- Area: Ru'Aun 2.0
--   NM: Seiryu Pet
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob, target)
    mob:setMod(xi.mod.DEF, 200)
    mob:setMod(xi.mod.EVA, 100)
    mob:setMod(xi.mod.MDEF, 100)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.PETRIFYRES, 10000)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setDropID(0)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    if not mob:hasStatusEffect(xi.effect.HUNDRED_FISTS, 0) then
        local rnd = math.random()
        if rnd < 0.5 then
            return 186 -- aeroga 3
        elseif rnd < 0.7 then
            return 157 -- aero 4
        elseif rnd < 0.9 then
            return 208 -- tornado
        else
            return 237 -- choke
        end
    end
    return 0 -- Still need a return, so use 0 when not casting
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
