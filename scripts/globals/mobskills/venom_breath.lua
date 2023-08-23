-----------------------------------
--
-- Venom Breath
--
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.random(35, 50), 3, 60)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    return xi.effect.POISON
end

return mobskillObject
