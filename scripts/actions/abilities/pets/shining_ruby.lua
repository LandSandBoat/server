-----------------------------------
-- Shining Ruby
-- Family: Avatar (Carbuncle)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    -- TODO: BGWiki says this shares a buff slot with Rampart, Winds Blessing and One For All.
    -- Need to capture tier priority.
    -- https://www.bg-wiki.com/ffxi/Shining_Ruby
    if target:hasStatusEffect(xi.effect.SHINING_RUBY) then
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT)

        return xi.effect.SHINING_RUBY
    end

    local baseDuration = 180
    local bonusTime    = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration     = baseDuration + bonusTime

    target:addStatusEffect(xi.effect.SHINING_RUBY, { power = 10, subPower = 390, duration = duration, origin = pet })

    if target:getID() == action:getPrimaryTargetID() then
        petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
    else
        petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
    end

    return xi.effect.SHINING_RUBY
end

return abilityObject
