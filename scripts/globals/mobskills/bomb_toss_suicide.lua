---------------------------------------------------
-- Bomb Toss - Suicide
-- Throws a bomb at an enemy. Sometimes backfires.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- notorious monsters shouldn't explode, nor dynamis
    if mob:isMobType(MOBTYPE_NOTORIOUS) or mob:isInDynamis() then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local BOMB_TOSS_HPP = skill:getMobHPP() / 100

    local job = mob:getMainJob()
    local power = math.random(12, 18)

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*power*BOMB_TOSS_HPP, tpz.magic.ele.FIRE, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end
