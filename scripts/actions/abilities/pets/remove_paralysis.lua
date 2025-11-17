-----------------------------------
-- Remove Paralysis
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, petskill, owner, action)
    if target:delStatusEffect(xi.effect.PARALYSIS) then
        petskill:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT)
    end

    return xi.effect.PARALYSIS
end

return abilityObject
