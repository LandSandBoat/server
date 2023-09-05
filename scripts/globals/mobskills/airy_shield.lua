-----------------------------------
-- Airy Shield
--
-- Description: Ranged shield
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ARROW_SHIELD, 1, 0, 60))

    return xi.effect.ARROW_SHIELD
end

return mobskillObject
