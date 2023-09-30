-----------------------------------
--  Thunder Breath
--  Description: Deals thunder damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical (Thunder)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isInDynamis() or target:hasStatusEffect(xi.effect.BATTLEFIELD)  then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.5, 1, xi.element.THUNDER, 700)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.THUNDER)
    return dmg
end

return mobskillObject
