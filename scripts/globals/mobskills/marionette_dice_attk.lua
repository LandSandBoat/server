-----------------------------------
-- Marionette Dice Attack Boost
-- Description: Boosts target's Attack
-- Notes: Used by Moblin Fantoccini in ENM: "Pulling the strings"
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local power = 15
    local duration = 25
    local typeEffect = xi.effect.ATTACK_BOOST

    mob:timer(5000, function(mobArg)
        target:addStatusEffect(typeEffect, power, 0, duration)
    end)

    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return typeEffect
end

return mobskill_object
