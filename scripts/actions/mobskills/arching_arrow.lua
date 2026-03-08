-----------------------------------
-- Arching Arrow
-- Trust: Semih Lafihna
-- Delivers a single-hit attack. Chance of critical varies with TP.
-- Modifiers: STR:20%; AGI:50%
-- Darkness/Gravitation skillchain properties, AoE damage
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local numhits = 1
    local accmod  = 1
    local ftp     = 3.5
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)

    return dmg
end

return mobskillObject
