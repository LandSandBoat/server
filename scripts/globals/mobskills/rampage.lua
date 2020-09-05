---------------------------------------------
--  Rampage
--
--  Description: Delivers a five-hit attack. Chance of critical varies with TP.
--  Type: Physical
--  Number of hits
--  Range: Melee
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onMobSkillCheck(target, mob, skill)
    mob:messageBasic(tpz.msg.basic.READIES_WS, 0, 684+256)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_CRIT_VARIES, 1, 1.5, 2)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    -- Witnessed 1100 to a DD.  Going with it :D
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    return dmg
end
