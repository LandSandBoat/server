-----------------------------------
-- Raise II
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if target:isAlive() or not target:isPC() then
        return xi.msg.basic.UNABLE_TO_USE_JA, 0
    end

    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, master, action)
    if not target:isPC() or target:isAlive() then
        skill:setMsg(xi.msg.basic.NO_EFFECT)
        return 0
    end

    skill:setMsg(xi.msg.basic.NONE)
    target:sendRaise(2)
    return 0
end

return abilityObject
