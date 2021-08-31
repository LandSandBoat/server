-----------------------------------
--  Hyper_Pulse
--
--  Description:  300 magic damage, Gravity and short Bind, wipes Utsusemi
--  Type: Physical
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target,mob,skill)
    local currentForm = mob:getLocalVar("form")
    local skillList = mob:getMobMod(xi.mobMod.SKILL_LIST)

    if (mob:getAnimationSub() == 2 and currentForm == 1) or skillList == 54 then -- proto-omega bipedform
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1.5
    local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg()*3, xi.magic.ele.DARK,dmgmod,TP_MAB_BONUS,1)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target, xi.attackType.MAGICAL, xi.damageType.DARK,MOBPARAM_WIPE_SHADOWS)

    MobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 4)
    MobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 30)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end
return mobskill_object
