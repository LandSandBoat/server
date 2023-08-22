-----------------------------------
--  Overthrow
--
--  Description: Throws a target backward.
--  Type: Physical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Melee
--  Notes: Moving to the side will avoid attack. Requires No Weapon or Broken Weapon.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getAnimationSub() == 1 or
        mob:getMainJob() == xi.job.MNK or
        mob:getMainJob() == xi.job.PUP
    then
        return 0
    else
        return 1
    end
end

-- TODO: ToAU mobskill | Massive knockback (distance is double sheep charge) currntly has no sql
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    return dmg
end

return mobskillObject
