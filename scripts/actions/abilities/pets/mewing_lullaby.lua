-----------------------------------
-- Mewing Lullaby
-- aoe light based sleep and lowers mob TP to zero
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    -- Apply TP reset on target. (Secondary effect. Cannot miss.)
    target:setTP(0)

    -- Check nullification.
    if
        xi.data.statusEffect.isTargetImmune(target, xi.effect.SLEEP_I, xi.element.LIGHT) or
        xi.data.statusEffect.isTargetResistant(pet, target, xi.effect.SLEEP_I) or
        xi.data.statusEffect.isEffectNullified(target, xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_I)
    then
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return xi.effect.SLEEP_I
    end

    -- Check resistance.
    local bonusMacc  = xi.summon.getSummoningSkillOverCap(pet)
    local resistRate = xi.combat.magicHitRate.calculateResistRate(pet, target, 0, 0, 0, xi.element.LIGHT, xi.mod.CHR, xi.effect.SLEEP_I, bonusMacc)
    if resistRate < 0.5 then
        petskill:setMsg(xi.msg.basic.JA_MISS_2) -- resist message
        return xi.effect.SLEEP_I
    end

    local duration = math.floor(90 * resistRate)

    petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
    target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration)

    return xi.effect.SLEEP_I
end

return abilityObject
