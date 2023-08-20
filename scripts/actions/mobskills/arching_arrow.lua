-----------------------------------
-- Arching Arrow
-- Trust: Semih Lafihna
-- Delivers a single-hit attack. Chance of critical varies with TP.
-- Modifiers: STR:20%; AGI:50%
-- Darkness/Gravitation skillchain properties, AoE damage
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local dmgmod  = 3.5
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)

    return dmg
end

return mobskillObject
