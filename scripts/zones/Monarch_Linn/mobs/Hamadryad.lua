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

    mob:setLocalVar("phalanxTrigger", math.random(6,13))
    mob:setLocalVar("spikesTrigger",  math.random(6,13))
    mob:setLocalVar("enfireTrigger",  math.random(6,13))

    mob:addListener("TAKE_DAMAGE", "HAMADRYAD_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        if attackType == xi.attackType.MAGICAL then
            if damageType == mob:getLocalVar("phalanxTrigger") then
                mobArg:setLocalVar("phalanxControl", 0)
                mobArg:setLocalVar("phalanxTimer", os.time() + math.random(10, 60))
                mobArg:delStatusEffectSilent(xi.effect.PHALANX)
            end
            if damageType == mob:getLocalVar("spikesTrigger") then
                mobArg:setLocalVar("spikesControl", 0)
                mobArg:setLocalVar("spikesTimer", os.time() + math.random(10, 60))
                mobArg:delStatusEffectSilent(xi.effect.BLAZE_SPIKES)
            end
            if damageType == mob:getLocalVar("enfireTrigger") then
                mobArg:setLocalVar("enfireControl", 0)
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
    if mob:getLocalVar("phalanxControl") == 1 and not mob:hasStatusEffect(xi.effect.PHALANX) then
        mob:addStatusEffect(xi.effect.PHALANX, 25, 0, 100)
    elseif mob:getLocalVar("spikesControl") == 1 and not mob:hasStatusEffect(xi.effect.BLAZE_SPIKES) then
        mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 50, 0, 100)
    elseif mob:getLocalVar("enfireControl") == 1 and not mob:hasStatusEffect(xi.effect.ENFIRE) then
        mob:addStatusEffect(xi.effect.ENFIRE, 30, 0, 100)

    end

    if mob:getLocalVar("phalanxTimer") < os.time() then
        mob:setLocalVar("phalanxControl", 1)
    elseif mob:getLocalVar("spikesTimer") < os.time() then
        mob:setLocalVar("spikesControl", 1)
    elseif mob:getLocalVar("enfireTimer") < os.time() then
        mob:setLocalVar("enfireControl", 1)
    end
end

entity.onMobDeath = function(mob)
end

return entity
