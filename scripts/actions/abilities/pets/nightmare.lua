-----------------------------------
-- Nightmare - Player's Avatar
-- AoE Sleep
-- Sleep that is not broken from DoT effects (any dmg source that doesn't break bind).
-- This version of it is from a player's avatar. The sleep is broken by most damage sources except other DoTs
--
-- see mobskills/nightmare.lua for full explanation
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    -- Check nullification.
    if
        xi.data.statusEffect.isTargetImmune(target, xi.effect.SLEEP_I, xi.element.DARK) or
        xi.data.statusEffect.isTargetResistant(pet, target, xi.effect.SLEEP_I) or
        xi.data.statusEffect.isEffectNullified(target, xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_I)
    then
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return xi.effect.SLEEP_I
    end

    -- Check resistance.
    local bonusMacc  = xi.summon.getSummoningSkillOverCap(pet)
    local resistRate = xi.combat.magicHitRate.calculateResistRate(pet, target, 0, 0, 0, xi.element.DARK, xi.mod.INT, xi.effect.SLEEP_I, bonusMacc)
    if resistRate < 0.5 then
        petskill:setMsg(xi.msg.basic.JA_MISS_2) -- resist message
        return xi.effect.SLEEP_I
    end

    local duration = math.floor(90 * resistRate)

    -- Apply sleep and bio
    if target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration, 0, 2, 4) then
        petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        target:delStatusEffectSilent(xi.effect.BIO)
        target:addStatusEffect(xi.effect.BIO, 2, 3, duration, 0, 10, 5)

    -- Miss
    else
        petskill:setMsg(xi.msg.basic.JA_MISS_2)
    end

    return xi.effect.SLEEP_I
end

return abilityObject
