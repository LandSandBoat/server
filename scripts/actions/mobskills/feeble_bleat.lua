-----------------------------------
-- Feeble Bleat
-- Emits a unnerving bleat that paralyzes down players in range.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 120))

    return xi.effect.PARALYSIS
end

return mobskillObject
