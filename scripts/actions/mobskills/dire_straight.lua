-----------------------------------
--  Dire Straight
--  Family: Acrolith
--  Type: Physical
--  Can be dispelled: N/A
--  Utsusemi/Blink absorb: Wipe shadows
--  Range: Single Target TODO Capture
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getLocalVar('lost_r_arm') == 1 then
        -- Lost right arm, filtering out Detonating grip!
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    return dmg
end

return mobskillObject
