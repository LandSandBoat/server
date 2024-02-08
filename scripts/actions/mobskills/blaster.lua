-----------------------------------
-- Blaster
--
-- Description: Paralyzes enemy.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows.
-- Range: Melee?
-- Notes: Very potent paralysis xi.effect. Is NOT a Gaze Attack, unlike Chaotic Eye.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, 60))

    return xi.effect.PARALYSIS
end

return mobskillObject
