-----------------------------------
-- Lightning Armor
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/utils")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    local duration = math.min(90 + xi.summon.getSummoningSkillOverCap(pet) * 3, 180)
    target:delStatusEffect(xi.effect.SHOCK_SPIKES)
    target:addStatusEffect(xi.effect.SHOCK_SPIKES, 15, 0, duration)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.SHOCK_SPIKES
end

return abilityObject
