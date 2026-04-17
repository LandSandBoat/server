-----------------------------------
-- Aegis Schism
-- Family: Fomor
-- Description: Lowers Defense of target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 75, 0, 120))

    return xi.effect.DEFENSE_DOWN
end

return mobskillObject
