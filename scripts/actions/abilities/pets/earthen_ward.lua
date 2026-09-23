-----------------------------------
-- Earthen Ward
-- Family: Avatar (Titan)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local amount = pet:getMainLvl() * 2 + 50

    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    if target:addStatusEffect(xi.effect.STONESKIN, { power = amount, duration = 900, origin = pet, tier = 3 }) then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return
    end

    return xi.effect.STONESKIN
end

return abilityObject
