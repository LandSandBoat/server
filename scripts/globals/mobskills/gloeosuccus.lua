-----------------------------------
-- Gloeosuccus
-- Enfeebling
-- Description: Slows down a single target.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 180))

    return xi.effect.SLOW
end

return mobskillObject
