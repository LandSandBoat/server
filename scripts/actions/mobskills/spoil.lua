-----------------------------------
-- Spoil
--
-- Description: Lowers the strength of target.
-- Type: Enhancing
-- Utsusemi/Blink absorb: Ignore
-- Range: Self
-- Notes: Very sharp evasion increase.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 10, 3, 120))

    return xi.effect.STR_DOWN
end

return mobskillObject
