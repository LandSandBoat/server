---------------------------------------------
--  Arrow Deluge
--  Description: Delivers a threefold ranged attack to targets in an area of effect.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Unknown
---------------------------------------------
local mobskill_object = {}

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if mob:getMainJob() == tpz.job.RNG then
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.PIERCING, MOBPARAM_3_SHADOW)
    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.PIERCING)
    return dmg
end

return mobskill_object
