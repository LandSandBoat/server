-----------------------------------
-- Ultrasonics
-- Family: Big Bat (Single Bat)
-- Description: Reduces evasion of targets in area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, 25, 0, 180))

    return xi.effect.EVASION_DOWN
end

return mobskillObject
