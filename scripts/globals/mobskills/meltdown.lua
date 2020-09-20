---------------------------------------------------
-- Meltdown
-- Reactor failure causes self-destruct, dealing magic damage to targets in an area of effect.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:isMobType(MOBTYPE_NOTORIOUS)) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*math.random(10, 18), tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)
    mob:setHP(0)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)
    return dmg
end
