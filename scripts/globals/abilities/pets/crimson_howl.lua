-----------------------------------
-- Crimson Howl
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    local bonusTime = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration = 60 + bonusTime

    target:addStatusEffect(xi.effect.WARCRY, 9, 0, duration)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.WARCRY
end

return abilityObject
