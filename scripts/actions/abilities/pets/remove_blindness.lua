-----------------------------------
-- Remove Blindness
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, petskill, owner, action)
    if target:delStatusEffect(xi.effect.BLINDNESS) then
        petskill:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT)
    end

    return xi.effect.BLINDNESS
end

return abilityObject
