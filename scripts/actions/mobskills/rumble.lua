-----------------------------------
-- Rumble
-- Description: A disorienting vibration lowers evasion of targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, 10, 0, (math.random(60, 240)), 1))

    return xi.effect.EVASION_DOWN
end

return mobskillObject
