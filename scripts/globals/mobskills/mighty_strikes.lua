-----------------------------------
-- Mighty Strikes
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
    xi.mobskills.mobBuffMove(mob, xi.effect.MIGHTY_STRIKES, 1, 0, 45)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.MIGHTY_STRIKES
end

return mobskillObject
