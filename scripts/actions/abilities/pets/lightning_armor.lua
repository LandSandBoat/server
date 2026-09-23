-----------------------------------
-- Lightning Armor
-- Family: Avatar (Ramuh)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local baseDuration = 180
    local bonusTime    = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration     = baseDuration + bonusTime

    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    target:delStatusEffect(xi.effect.SHOCK_SPIKES)

    -- TODO: Does power scale?
    if target:addStatusEffect(xi.effect.SHOCK_SPIKES, { power = 15, duration = duration, origin = pet }) then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return
    end

    return xi.effect.SHOCK_SPIKES
end

return abilityObject
