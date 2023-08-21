-----------------------------------
-- Aerial Armor
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    target:delStatusEffect(xi.effect.BLINK)
    target:addStatusEffect(xi.effect.BLINK, 3, 0, 900)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.BLINK
end

return abilityObject
