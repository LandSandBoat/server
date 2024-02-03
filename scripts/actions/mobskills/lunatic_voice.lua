-----------------------------------
-- Lunatic Voice
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MUTE, 1, 0, 60))

    return xi.effect.MUTE
end

return mobskillObject
