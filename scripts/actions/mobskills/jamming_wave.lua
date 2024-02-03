-----------------------------------
-- Jamming Wave
-- Description: Silence Area of Effect (16.0')
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 45))

    return xi.effect.SILENCE
end

return mobskillObject
