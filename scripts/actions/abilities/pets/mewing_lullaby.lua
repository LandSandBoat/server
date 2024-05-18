-----------------------------------
-- Mewing Lullaby
-- aoe light based sleep and lowers mob TP to zero
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)
    local duration = 90
    local dINT = pet:getStat(xi.mod.CHR) - target:getStat(xi.mod.CHR)
    local bonus = xi.summon.getSummoningSkillOverCap(pet)
    local resm = xi.mobskills.applyPlayerResistance(pet, -1, target, dINT, bonus, xi.element.LIGHT)
    target:setTP(0) -- "The TP lowering seems to be a total reset of TP on the mob, and even if the sleep misses, the TP reset cannot miss."
    if resm < 0.5 then
        petskill:setMsg(xi.msg.basic.JA_MISS_2) -- resist message
        return xi.effect.SLEEP_I
    end

    duration = duration * resm
    if
        target:hasImmunity(xi.immunity.LIGHT_SLEEP) or
        target:hasStatusEffect(xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_II) or
        target:hasStatusEffect(xi.effect.LULLABY)
    then
        --No effect
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    else
        petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)

        target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration)
    end

    return xi.effect.LULLABY
end

return abilityObject
