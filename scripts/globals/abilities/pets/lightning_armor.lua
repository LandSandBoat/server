-----------------------------------
-- Lightning Armor
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
    local bonusTime = utils.clamp(xi.summon.getSummoningSkillOverCap(pet) * 3, 0, 90)-- 3 seconds / skill | Duration is capped at 180 total
    local duration = 90 + bonusTime

    target:delStatusEffect(xi.effect.SHOCK_SPIKES)
    target:addStatusEffect(xi.effect.SHOCK_SPIKES, 15, 0, duration)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.SHOCK_SPIKES
end

return abilityObject
