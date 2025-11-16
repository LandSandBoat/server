-----------------------------------
-- Sound Vacuum
-- Description: Silences a single target
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 7.0 or 15.0 (Needs Verification) Area of Effect if used by Nightmare Worm
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 90))

    return xi.effect.SILENCE
end

return mobskillObject
