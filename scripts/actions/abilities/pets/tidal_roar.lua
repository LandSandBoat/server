-----------------------------------
-- Tidal Roar
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local typeEffect = xi.effect.ATTACK_DOWN
    if not target:getStatusEffect(typeEffect) then
        target:addStatusEffect(typeEffect, 25, 0, 60)

        -- The status effect requires the NO_LOSS_MESSAGE flag to be set
        local statusEffect = target:getStatusEffect(typeEffect)
        statusEffect:addEffectFlag(xi.effectFlag.NO_LOSS_MESSAGE)

        -- TODO: Verify enmity gain total
        target:addEnmity(pet, 1, 60)

        -- TODO: Refactor this logic globally for pet abilities
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.JA_RECEIVES_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_RECEIVES_EFFECT)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return
    end

    return typeEffect
end

return abilityObject
