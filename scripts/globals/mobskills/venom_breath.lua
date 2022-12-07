-----------------------------------
--
-- Venom Breath
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.POISON
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, math.random(20, 40), 3, 60)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    return typeEffect
end

return mobskillObject
