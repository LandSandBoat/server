-----------------------------------
-- Goblin Dice
-- Description: Reset recasts on abilities
-- Type: Physical (Blunt)
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    target:resetRecasts()

    skill:setMsg(xi.msg.basic.ABILITIES_RECHARGED)

    return 1
end

return mobskillObject
