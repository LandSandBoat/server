-----------------------------------
-- Marionette Dice (3 & 7)
-- Description: Reset abilites for target
-- Type: Magical
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
    target:resetRecasts()

    skill:setMsg(xi.msg.basic.ABILITIES_RECHARGED)

    return 1
end

return mobskill_object