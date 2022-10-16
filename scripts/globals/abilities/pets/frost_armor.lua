-----------------------------------
-- Frost Armor
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    local bonusTime = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration = 180 + bonusTime

    target:delStatusEffect(xi.effect.ICE_SPIKES)
    target:addStatusEffect(xi.effect.ICE_SPIKES, 15, 0, duration)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.ICE_SPIKES
end

return abilityObject
