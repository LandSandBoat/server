---------------------------------------------------
-- Sonic Buffet
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()  *2.5, tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_IGNORE_SHADOWS)

    for i = 1, math.random(2,3) do
        target:dispelStatusEffect(tpz.effectFlag.DISPELABLE)
    end

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)

    return dmg
end
