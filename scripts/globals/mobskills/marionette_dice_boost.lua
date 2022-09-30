-----------------------------------
-- Marionette Dice (5 & 9)
-- Description: Atk or Def boost for target
-- Notes: Used by Moblin Fantoccini in ENM: "Pulling the strings"
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local power = 15
    local duration = 90
    local typeEffect = xi.effect.ATTACK_BOOST

    if math.random() > 0.5 then
        typeEffect = xi.effect.DEFENSE_BOOST
    end

    if target:isPC() then
        mob:showText(mob, ID.text.DICE_LIKE_YOU)
    else
        mob:showText(mob, ID.text.DICE_LIKE_ME)
    end

    if target:addStatusEffect(typeEffect, power, 0, duration) then
        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end
    --msg 194?

    return typeEffect
end

return mobskill_object
