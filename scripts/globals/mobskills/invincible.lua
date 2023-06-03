-----------------------------------
-- Invincible
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.INVINCIBLE, 1, 0, 30)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.INVINCIBLE
end

return mobskillObject
