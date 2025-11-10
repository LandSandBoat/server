-----------------------------------
--  Pit Ambush
--  Description: Only used by black antlions when they emerge to attack a player overhead.
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
    local ftp  = 3.3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 1, 1, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg  = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    return dmg
end

return mobskillObject
