-----------------------------------
-- Hastega
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
    -- Garuda's Hastega is a weird exception and uses 153/1024 instead of 150/1024 like Haste spells
    -- That's why it overwrites some things regular haste won't.
    target:addStatusEffect(xi.effect.HASTE, 1494, 0, duration) -- 153/1024 ~14.94%
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.HASTE
end

return abilityObject
