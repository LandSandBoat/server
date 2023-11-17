-----------------------------------
-- Reraise II
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if not target:isAlive() then
        return xi.msg.basic.UNABLE_TO_USE_JA, 0
    end

    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, master, action)
    local typeEffect = xi.effect.RERAISE
    if not target:isPC() or not target:addStatusEffect(typeEffect, 2, 0, 3600) then
        skill:setMsg(xi.msg.basic.NO_EFFECT)
        return 0
    end

    skill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
    return typeEffect
end

return abilityObject
