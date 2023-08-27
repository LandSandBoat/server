-----------------------------------
-- Slowga
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    local bonusTime = utils.clamp(xi.summon.getSummoningSkillOverCap(pet) * 3, 0, 90)-- 3 seconds / skill | Duration is capped at 180 total
    local duration = 90 + bonusTime

    if target:addStatusEffect(xi.effect.SLOW, 3000, 0, duration) then
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.SLOW
end

return abilityObject
