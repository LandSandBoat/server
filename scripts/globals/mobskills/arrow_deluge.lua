-----------------------------------
--  Arrow Deluge
--  Description: Delivers a threefold ranged attack to targets in an area of effect.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Unknown
-----------------------------------
local mobskill_object = {}

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")

-----------------------------------
mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if mob:getMainJob() == xi.job.RNG then
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    return dmg
end

return mobskill_object
