-----------------------------------
-- Mind Drain
-- Steals mnd from target
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 14, 3, 300))

    return xi.effect.MND_DOWN
end

return mobskillObject
