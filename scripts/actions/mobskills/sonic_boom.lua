-----------------------------------
-- Sonic Boom
-- Reduces attack of targets in area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 120, 180)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 25, 0, duration))

    return xi.effect.ATTACK_DOWN
end

return mobskillObject
