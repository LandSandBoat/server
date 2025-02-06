-----------------------------------
--  Trample
--  Family: Bahamut
--  Description: Deals physical damage to enemies in an area of effect. Additional effect: Knockback + Bind
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 30
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, duration)

    local numhits = 1
    local accmod = 1
    local ftp    = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
