-----------------------------------
-- Area: Monarch Linn
-- Mob: Hamadryad
-- ENM: Bad Seed
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 20)
    mob:setLocalVar("phalanxControl", 1)

    mob:setLocalVar("phalanxTrigger", math.random(xi.damageType.FIRE, xi.damageType.DARK))
    mob:setLocalVar("spikesTrigger",  math.random(xi.damageType.FIRE, xi.damageType.DARK))
    mob:setLocalVar("enfireTrigger",  math.random(xi.damageType.FIRE, xi.damageType.DARK))

    mob:addListener("TAKE_DAMAGE", "HAMADRYAD_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        if attackType == xi.attackType.MAGICAL then

            if damageType == mobArg:getLocalVar("phalanxTrigger") then
                mobArg:setLocalVar("phalanxTimer", os.time() + math.random(10, 60))
                mobArg:delStatusEffectSilent(xi.effect.PHALANX)
            end

            if damageType == mobArg:getLocalVar("spikesTrigger") then
                mobArg:setLocalVar("spikesTimer", os.time() + math.random(10, 60))
                mobArg:delStatusEffectSilent(xi.effect.BLAZE_SPIKES)
            end

            if damageType == mobArg:getLocalVar("enfireTrigger") then
                mobArg:setLocalVar("enfireTimer", os.time() + math.random(10, 60))
                mobArg:delStatusEffectSilent(xi.effect.ENFIRE)
            end
        end
    end)
end

entity.onMobEngaged = function(mob)
    mob:setLocalVar("spikesTimer", os.time() + math.random(10, 60))
    mob:setLocalVar("enfireTimer", os.time() + math.random(10, 60))
end

entity.onMobFight = function(mob)
    -- Timer set to reapply the effects throughout the fight
    -- Effects will never wear off until their elected element damages Hamadryad
    if mob:getLocalVar("phalanxTimer") < os.time() then
        mob:addStatusEffect(xi.effect.PHALANX, 25, 0, 100)

    elseif mob:getLocalVar("spikesTimer") < os.time() then
        mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 50, 0, 100)

    elseif mob:getLocalVar("enfireTimer") < os.time() then
        mob:addStatusEffect(xi.effect.ENFIRE, 30, 0, 100)
    end
end

entity.onMobDeath = function(mob)
end

return entity
