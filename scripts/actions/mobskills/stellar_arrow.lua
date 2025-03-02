-----------------------------------
-- Stellar Arrow (AOE)
-- Trust: Semih Lafihna
-- Darkness/Gravitation skillchain properties, AoE damage
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
