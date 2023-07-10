-----------------------------------
-- Area: Ru'Aun 2.0
--   NM: Suzaku pet
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

-- Return the selected spell ID.
entity.onMobMagicPrepare = function(mob, target, spellId)
    -- Suzaku uses     Burn, Fire IV, Firaga III, Flare
    -- Let's give -ga3 a higher distribution than the others.
    local rnd = math.random()

    if rnd < 0.5 then
        return 176 -- firaga 3
    elseif rnd < 0.7 then
        return 147 -- fire 4
    elseif rnd < 0.9 then
        return 204 -- flare
    else
        return 235 -- burn
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
