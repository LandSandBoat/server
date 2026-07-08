-----------------------------------
-- Feeble Bleat
-- Emits a unnerving bleat that paralyzes down players in range.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 90))

    return xi.effect.PARALYSIS
end

return mobskillObject
