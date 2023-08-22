---------------------------------------------
--  Cacodemonia
--
--  Description: AoE Curse
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown Radial (Using 15' as an estimate)
--  Notes: Used by some versions of Diabolos, but not all.
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.CURSE_I) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CURSE_I

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 40, 0, 360))

    return typeEffect
end

return mobskillObject
