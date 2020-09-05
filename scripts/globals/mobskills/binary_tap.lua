---------------------------------------------
-- Binary Tap
-- Attempts to absorb two buffs from a single target, or otherwise steals HP.
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
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    -- try to drain buff
    local effectFirst = mob:stealStatusEffect(target, tpz.effectFlag.DISPELABLE)
    local effectSecond = mob:stealStatusEffect(target, tpz.effectFlag.DISPELABLE)
    local dmg = 0

    if (effectFirst ~= 0) then
        local count = 1

        if (effectSecond ~= 0) then
            count = count + 1
        end

        skill:setMsg(tpz.msg.basic.EFFECT_DRAINED)

        return count
    else
        -- time to drain HP. 100-200
        local power = math.random(0, 101) + 100
        dmg = MobFinalAdjustments(power, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

        skill:setMsg(MobPhysicalDrainMove(mob, target, skill, MOBDRAIN_HP, dmg))
        return dmg
    end

end
