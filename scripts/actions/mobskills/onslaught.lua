-----------------------------------
--  Onslaught
--
--  Description: Lowers target's accuracy. Guttler/Ogre Killer: Temporarily increases Attack.
--  Type: Physical
--  Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 2.5

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local duration = 60
    local power = 30

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.ACCURACY_DOWN, power, 0, duration)

    -- About 300-400 to a DD.
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
