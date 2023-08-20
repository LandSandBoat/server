-----------------------------------
-- Asthenic Fog
--
-- Description: A mist drowns all nearby targets.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DROWN, 25, 3, 120))

    return xi.effect.DROWN
end

return mobskillObject
