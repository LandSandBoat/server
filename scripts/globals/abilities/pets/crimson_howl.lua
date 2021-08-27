-----------------------------------
-- Crimson Howl
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill, summoner)
    local bonusTime = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration = 60 + bonusTime

    target:addStatusEffect(xi.effect.WARCRY, 9, 0, duration)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.WARCRY
end

return ability_object
