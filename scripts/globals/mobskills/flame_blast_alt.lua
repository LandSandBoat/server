---------------------------------------------
--  Flame Blast Regular Attack
--
--  Description: Deals single target fire damage to target.
--  Type: Magical
--  Utsusemi/Blink absorb: N/A
--  Range: 18'
--  Notes: Used only by KS99 Wyrm in while flying as regular attack. Only use in a dedicated flying attack skill set.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    skill:setMsg(tpz.msg.basic.HIT_DMG)
    return dmg
end
