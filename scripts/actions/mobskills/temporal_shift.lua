-----------------------------------
-- Temporal Shift
-- Family: Hpemde
-- Description: Enemies within range are temporarily prevented from acting.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 15 yalms
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 5))

    return xi.effect.STUN
end

return mobskillObject
