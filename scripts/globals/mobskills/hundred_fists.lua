-----------------------------------
-- Hundred Fists
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.HUNDRED_FISTS, 1, 0, 45)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.HUNDRED_FISTS
end

return mobskillObject
