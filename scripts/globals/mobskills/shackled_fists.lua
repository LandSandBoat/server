require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getMainJob() == tpz.job.MNK) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1.4
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.H2H, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.H2H)
    return dmg
end
