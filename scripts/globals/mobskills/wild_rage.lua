---------------------------------------------
--  Wild Rage
--
--  Description: Deals physical damage to enemies within area of effect.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: 15' radial
--  Notes: Has additional effect of Poison when used by King Vinegarroon.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

local PLATOON_SCORP_POOL_ID = 3157
local WILD_RAGE_DMG_INCREASE = 0.10

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.1


    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    if mob:getPool() == PLATOON_SCORP_POOL_ID then
        -- should not have to verify because platoon scorps only in battlefield
        local num_scorps_dead= mob:getBattlefield():getLocalVar("[ODS]NumScorpsDead")

        -- Increase the strength of Wild Rage as scorps in the BC die
        -- https://ffxiclopedia.fandom.com/wiki/Operation_Desert_Swarm
        info.dmg = info.dmg * (1 + WILD_RAGE_DMG_INCREASE * num_scorps_dead)
    end

    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_3_SHADOW)

    -- king vinegrroon
    if (mob:getPool() == 2262) then
        local typeEffect = tpz.effect.POISON
        local power = 25
        MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 3, 60)
    end

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    return dmg
end
