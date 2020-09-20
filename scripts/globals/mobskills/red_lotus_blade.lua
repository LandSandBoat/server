---------------------------------------------
-- Red lotus Blade
--
-- Description: Deals fire elemental damage. Damage varies with TP.
-- Type: Physical
-- Utsusemi/Blink absorb: 1 Shadow?
-- Range: Melee
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onMobSkillCheck(target, mob, skill)
    if (mob:getPool() ~= 4006 and mob:getPool() ~= 4249) then
        mob:messageBasic(tpz.msg.basic.READIES_WS, 0, 34)
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if (mob:getPool() == 4006) then -- Trion@QuBia_Arena only
        target:showText(mob, zones[tpz.zone.QUBIA_ARENA].text.RLB_LAND)
    elseif (mob:getPool() == 4249) then -- Volker@Throne_Room only
        target:showText(mob, zones[tpz.zone.THRONE_ROOM].text.FEEL_MY_PAIN)
    end

    local dmgmod = 1.25
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*4, tpz.magic.ele.FIRE, dmgmod, TP_DMG_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_1_SHADOW)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end
