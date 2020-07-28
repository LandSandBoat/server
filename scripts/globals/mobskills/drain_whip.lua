---------------------------------------------
-- Drain Whip
--
-- Description: Drains HP, MP, or TP from the target.
-- Type: Magical
-- Utsusemi/Blink absorb: ignores shadows
-- Range: Melee
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local drainEffect = MOBDRAIN_HP
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

    local rnd = math.random(3)
    if rnd == 1 then
        drainEffect = MOBDRAIN_TP
    elseif rnd == 2 then
        drainEffect = MOBDRAIN_MP
    else
        drainEffect = MOBDRAIN_HP
    end

    skill:setMsg(MobPhysicalDrainMove(mob, target, skill, drainEffect, dmg))

    return dmg
end
