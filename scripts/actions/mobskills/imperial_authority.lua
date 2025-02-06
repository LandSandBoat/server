-----------------------------------
-- Imperial Authority (Nashmeira, Nashmeira II)
-- Deals damage to a single target. Additional effect: Stun
-- Type: Physical (Hand-to-Hand)
-- Skillchain Properties: Fragmentation/Distortion
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local ftp    = 0.3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, mob:getWeaponDmg() * ftp, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 10)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)

    return dmg
end

return mobskillObject
