-----------------------------------
-- Perfect Dodge
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.PERFECT_DODGE, 1, 0, 30)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.PERFECT_DODGE
end

return mobskillObject
