-----------------------------------
-- Sandstorm
-- Kicks up a blinding dust cloud on targets in an area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 0, 120))

    return xi.effect.BLINDNESS
end

return mobskillObject
