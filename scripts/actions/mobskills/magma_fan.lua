-----------------------------------
--  Magma Fan
--  Description: Deals Fire damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical Fire (Element)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Breath damage is HP * 1/12
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, skill, 0.0833, 1, xi.element.FIRE, 600)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
