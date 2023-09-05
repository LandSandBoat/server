-----------------------------------
-- Remove Blindness
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(pet, target, skill, action)
    if target:delStatusEffect(xi.effect.BLINDNESS) then
        skill:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
    else
        skill:setMsg(xi.msg.basic.JA_NO_EFFECT)
    end

    return xi.effect.BLINDNESS
end

return abilityObject
