-----------------------------------
-- Crimson Howl
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/utils")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    local duration = math.min(30 + xi.summon.getSummoningSkillOverCap(pet), 180)

    target:addStatusEffect(xi.effect.WARCRY, 9, 0, duration)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.WARCRY
end

return abilityObject
