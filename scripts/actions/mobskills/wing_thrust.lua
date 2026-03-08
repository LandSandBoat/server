-----------------------------------
--  Wing Thrust
--  Family: Aern
--  Type: Physical
--  Can be dispelled: N/A
--  Utsusemi/Blink absorb: 4 Shadows
--  Range: Single Target 7.0'
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local numhits = 4
    local accmod = 1
    local ftp    = 0.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.ACC_VARIES, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLOW, 1250, 0, math.random(30, 60))

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    return dmg
end

return mobskillObject
