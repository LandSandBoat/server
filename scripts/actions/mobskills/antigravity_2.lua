-----------------------------------
-- Antigravity w / 2 Gears
-- Knockback and damage, knockback varies with gear count
-----------------------------------
-- TODO: The potency of the knockback effect varies with
-- the number of gears in the enemy formation. A single gear produces only a
-- slight knockback, whereas triple gears produce a very strong knockback.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 2
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:delHP(dmg)

    return dmg
end

return mobskillObject
