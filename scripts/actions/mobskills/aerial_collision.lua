-----------------------------------
-- Aerial Collision
-- Description: Cone Attack damage and Defense Down, strips Utsusemi (xi.mobskills.shadowBehavior.WIPE_SHADOWS)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 1
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 10, 0, 30)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)

    return dmg
end

return mobskillObject
