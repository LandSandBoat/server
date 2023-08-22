-----------------------------------
-- Grim Halo
-- Deals damage to a all targets. Additional effect: Knockback
-- Only used by Fomors that wield a two-handed weapon (principally WAR, BLM, DRK, SAM, DRG, and SMN fomors).
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local job = mob:getMainJob()
    if
        job == xi.job.WAR or
        job == xi.job.BLM or
        job == xi.job.DRK or
        job == xi.job.SAM or
        job == xi.job.DRG or
        job == xi.job.SMN
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2.5, 3, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end

return mobskillObject
