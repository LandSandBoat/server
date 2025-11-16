-----------------------------------
-- Remove Disease
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, petskill, owner, action)
    local effect
    if target:delStatusEffect(xi.effect.DISEASE) then
        petskill:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
        effect = xi.effect.DISEASE
    elseif target:delStatusEffect(xi.effect.PLAGUE) then
        petskill:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
        effect = xi.effect.PLAGUE
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT)
    end

    return effect
end

return abilityObject
