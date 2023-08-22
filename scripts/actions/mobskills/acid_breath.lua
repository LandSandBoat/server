-----------------------------------
--  Acid Breath
--
--  Description: Deals Water damage to enemies in a fan-shaped area of effect. Additional effect: STR Down
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 20
    local tick     = 3
    local duration = power * tick

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, power, tick, duration)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.element.WATER, 200)
    local dmg    = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)

    return dmg
end

return mobskillObject
