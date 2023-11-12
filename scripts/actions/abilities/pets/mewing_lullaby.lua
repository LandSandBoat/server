-----------------------------------
-- Mewing Lullaby
-- aoe light based sleep and lowers mob TP to zero
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, master, action)
    local typeEffect = xi.effect.SLEEP_I
    local duration = 90
    local dINT = pet:getStat(xi.mod.CHR) - target:getStat(xi.mod.CHR)
    local bonus = xi.summon.getSummoningSkillOverCap(pet)
    local resm = xi.mobskills.applyPlayerResistance(pet, -1, target, dINT, bonus, xi.element.LIGHT)
    target:setTP(0) -- "The TP lowering seems to be a total reset of TP on the mob, and even if the sleep misses, the TP reset cannot miss."
    if resm < 0.5 then
        skill:setMsg(xi.msg.basic.JA_MISS_2) -- resist message
        return typeEffect
    end

    duration = duration * resm
    if
        target:hasImmunity(1) or
        target:hasStatusEffect(xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_II) or
        target:hasStatusEffect(xi.effect.LULLABY)
    then
        --No effect
        skill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    else
        skill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)

        target:addStatusEffect(typeEffect, 1, 0, duration)
    end

    return xi.effect.LULLABY
end

return abilityObject
