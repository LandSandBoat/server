-----------------------------------
--  Chomp Rush
--
--  Description: Deals damage in a threefold attack to a single target. Additional effect: slow (25%)
--  Type: Physical
--  Utsusemi/Blink absorb: 3 shadows
--  Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local ftp    = 1.1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLOW, 1250, 0, 60)

    return dmg
end

return mobskillObject
