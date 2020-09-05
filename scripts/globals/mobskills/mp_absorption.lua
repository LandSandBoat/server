---------------------------------------------
-- MP Absorption
-- Single target MP Drain. (Ignores shadows.)
-- Type: Magical
-- Range: Melee
-- Notes: If used against undead, it will simply do damage and not drain HP.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*1.5, tpz.magic.ele.DARK, dmgmod, TP_MAB_BONUS, 1)

    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

    skill:setMsg(MobPhysicalDrainMove(mob, target, skill, MOBDRAIN_MP, dmg))

    return dmg
end
