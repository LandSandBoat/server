-----------------------------------
-- Sand Blast
-- Blinds targets in a radius around the user. No damage.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 40, 0, 90))

    return xi.effect.BLINDNESS
end

return mobskillObject
