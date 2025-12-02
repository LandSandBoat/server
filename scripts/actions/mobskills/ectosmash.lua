-----------------------------------
--  Ectosmash
--  Description: Teleports to hit a single target.
--  Type: Physical (Blunt)
--  Utsusemi/Blink absorb: 1 Shadow
--  Range: 15.0 yalms (May be further, needs additional testing)
--  Notes: Mob is still set to same spot for attacks and abilities that deal with monster position, such as Sneak Attack and Cover. Monster will always return to this starting position after.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 2.0
    local params  = { canCrit = true }
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.ATK_VARIES, 1.5, 1.5, 1.5, params)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
