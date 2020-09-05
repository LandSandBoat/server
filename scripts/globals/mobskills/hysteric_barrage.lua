---------------------------------------------
--  Hysteric Barrage
--  Description: Delivers a fivefold attack. Damage varies with TP.
--  Type: Physical only when weapon is broken
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if mob:AnimationSub() == 1 then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = .7
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.H2H, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.H2H)
    return dmg
end
