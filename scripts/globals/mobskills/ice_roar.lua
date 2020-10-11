---------------------------------------------------
-- Ice Roar
-- Emits the roar of an impact event, dealing damage in a fan-shaped area of effect. Ice damage
-- Ignores Shadows
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)

    if (mob:getZoneID() == 135 or mob:getZoneID() == 111) then
        return 0
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, tpz.magic.ele.ICE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ICE)

    return dmg
end
