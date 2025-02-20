-----------------------------------
--  Stone Throw
--  Description: Damages a single target. Additional effect: Paralysis
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 0.8
    local ftp    = 2.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 20, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
