---------------------------------------------
-- Spirit Tap
-- Attempts to absorb one buff from a single target, or otherwise steals HP.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: Melee
-- Notes: Can be any (positive) buff, including food. Will drain about 100HP if it can't take any buffs
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:isMobType(MOBTYPE_NOTORIOUS)) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    -- try to drain buff
    local effect = mob:stealStatusEffect(target, tpz.effectFlag.DISPELABLE)
    local dmg = 0

    if (effect ~= 0) then
        skill:setMsg(tpz.msg.basic.EFFECT_DRAINED)
        return 1
    else
        -- time to drain HP. 50-100
        local power = math.random(0, 51) + 50
        dmg = MobFinalAdjustments(power, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

        skill:setMsg(MobPhysicalDrainMove(mob, target, skill, MOBDRAIN_HP, dmg))
    end

    return dmg
end
