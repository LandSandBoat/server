---------------------------------------------------
--  Stun_Cannon
--
--  Description: 20'(?) cone ~300 magic damage and Paralysis, ignores Utsusemi
--  Type: Magical
--
--  Range: 20 yalms
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local currentForm = mob:getLocalVar("form")

    if (mob:AnimationSub() == 2 and currentForm == 1) then -- proto-omega bipedform
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
   local dmgmod = 1.5
   local typeEffect = tpz.effect.PARALYSIS

    MobStatusEffectMove(mob, target, typeEffect, 20, 0, 120)
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.THUNDER, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    return dmg
end
