-----------------------------------
-- Remove Curse
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, petskill, owner, action)
    local effect
    if target:delStatusEffect(xi.effect.CURSE_I) then
        petskill:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
        effect = xi.effect.CURSE_I
    elseif target:delStatusEffect(xi.effect.DOOM) then
        petskill:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
        effect = xi.effect.DOOM
    elseif target:delStatusEffect(xi.effect.BANE) then
        petskill:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
        effect = xi.effect.BANE
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT)
    end

    return effect
end

return abilityObject
