---------------------------------------------
-- Spirits Within
--
-- Description: Delivers an unavoidable attack. Damage varies with HP and TP.
-- Type: Magical/Breath
-- Utsusemi/Blink absorb: Ignores shadows and most damage reduction.
-- Range: Melee
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")

function onMobSkillCheck(target, mob, skill)
    if (mob:getPool() ~= 4249) then
        mob:messageBasic(tpz.msg.basic.READIES_WS, 0, 39)
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if (mob:getPool() == 4249) then -- Volker@Throne_Room only
        target:showText(mob, zones[tpz.zone.THRONE_ROOM].text.RETURN_TO_THE_DARKNESS)
    end

    local tp = skill:getTP()
    local hp = mob:getHP()
    local dmg = 0

    -- Should produce 1000 - 3750 @ full HP using the player formula, assuming 8k HP for AA EV.
    -- dmg * 2.5, as wiki claims ~2500 at 100% HP, until a better formula comes along.
    if (tp <= 2000) then -- 1000 - 2000
        dmg = math.floor(hp * (math.floor(0.016 * tp) + 16) / 256)
    else -- 2001 - 3000
        dmg = math.floor(hp * (math.floor(0.072 * tp) - 96) / 256)
    end

    dmg = dmg * 2.5

    -- Believe it or not, it's been proven to be breath damage.
    dmg = target:breathDmgTaken(dmg)

    -- Handling phalanx
    dmg = dmg - target:getMod(tpz.mod.PHALANX)

    if (dmg < 0) then
        return 0
    end

    dmg = utils.stoneskin(target, dmg)

    if (dmg > 0) then
        target:wakeUp()
        target:updateEnmityFromDamage(mob, dmg)
    end

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.ELEMENTAL)
    return dmg
end
