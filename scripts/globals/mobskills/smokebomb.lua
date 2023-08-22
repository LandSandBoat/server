-----------------------------------
-- Smoke Bomb
-- Range: 10' cone
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 120))

    return xi.effect.BLINDNESS
end

return mobskillObject
