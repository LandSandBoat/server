---------------------------------------------
--  Tail Slap
--
--  Description: Delivers an area attack. Additional effect: "Stun." Damage varies with TP.
--  Type: Physical (Blunt)
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
  if(mob:getFamily() == 91) then
    local mobSkin = mob:getModelId()

    if (mobSkin == 1643) then
        return 0
    else
        return 1
    end
  end
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.2
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_ATK_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)

    local typeEffect = tpz.effect.STUN

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    return dmg
end
