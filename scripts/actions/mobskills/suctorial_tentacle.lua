-----------------------------------
-- Suctorial Tentacle
-- Binds target for 30-90 seconds
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, math.random(30, 90)))
    return xi.effect.BIND
end

return mobskillObject
