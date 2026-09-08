-----------------------------------
-- Predatory Glare
-- Description: Stuns targets in conal.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, math.randomInt(3, 8)))

    return xi.effect.STUN
end

return mobskillObject
