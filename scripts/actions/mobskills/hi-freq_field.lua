-----------------------------------
-- Hi-Freq Field
-- Description: Lowers the evasion of enemies in a fan-shaped area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, 40, 0, 180))

    return xi.effect.EVASION_DOWN
end

return mobskillObject
