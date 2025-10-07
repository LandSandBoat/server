-----------------------------------
-- Choke Breath
-- Family: Hippogryph
-- Description : Deals sonic damage to enemies within a fan-shaped area originating from caster. Additional effects: Paralysis, Silence.
-- Type: Physical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local chokeBreath = 100
    local dmg = xi.mobskills.mobFinalAdjustments(chokeBreath, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 25, 0, 30)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SILENCE, 1, 0, 30)

    return dmg
end

return mobskillObject
