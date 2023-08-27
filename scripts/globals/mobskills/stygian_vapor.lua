-----------------------------------
-- Stygian Vapor
--
-- Description: AoE Powerful plague
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 0, 120))

    return xi.effect.PLAGUE
end

return mobskillObject
