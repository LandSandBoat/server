-----------------------------------
-- Crimson Howl
-- Family: Avatar (Ifrit)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local baseDuration = 60
    local bonusTime    = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration     = baseDuration + bonusTime
    local power        = (math.floor((pet:getMainLvl() / 4) + 4.75) / 256) * 100

    if target:addStatusEffect(xi.effect.WARCRY, { power = power, duration = duration, origin = pet }) then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return
    end

    return xi.effect.WARCRY
end

return abilityObject
