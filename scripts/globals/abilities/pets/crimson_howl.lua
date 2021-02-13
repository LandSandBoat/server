-----------------------------------
-- Crimson Howl
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill, summoner)
    local bonusTime = utils.clamp(summoner:getSkillLevel(tpz.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration = 60 + bonusTime

    target:addStatusEffect(tpz.effect.WARCRY, 9, 0, duration)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
    return tpz.effect.WARCRY
end

return ability_object
