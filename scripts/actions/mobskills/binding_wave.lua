-----------------------------------
-- Binding Wave
-- Additional effect: bind
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = xi.mobskills.calculateDuration(mob:getTP(), 30, 60)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, duration))

    return xi.effect.BIND
end

return mobskillObject
