-----------------------------------
-- Earthen Ward
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    target:delStatusEffect(xi.effect.STONESKIN)
    local amount = pet:getMainLvl() * 2 + 50

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local typeEffect = xi.effect.STONESKIN
    if target:addStatusEffect(typeEffect, amount, 0, 900, 0, 0, 3) then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return
    end

    return typeEffect
end

return abilityObject
