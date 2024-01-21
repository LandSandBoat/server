-----------------------------------
-- Shining Ruby
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local bonusTime = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration = 180 + bonusTime

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    target:delStatusEffect(xi.effect.SHINING_RUBY)
    target:addStatusEffect(xi.effect.SHINING_RUBY, 1, 0, duration)

    if target:getID() == action:getPrimaryTargetID() then
        petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
    else
        petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
    end

    return xi.effect.SHINING_RUBY
end

return abilityObject
