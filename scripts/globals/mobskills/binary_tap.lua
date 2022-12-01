-----------------------------------
-- Binary Tap
-- Attempts to absorb two buffs from a single target, or otherwise steals HP.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: Melee
-- Notes: Can be any (positive) buff, including food. Will drain about 100HP if it can't take any buffs
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- try to drain buff
    local effectFirst = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local effectSecond = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local dmg = 0

    if effectFirst ~= 0 then
        local count = 1

        if effectSecond ~= 0 then
            count = count + 1
        end

        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)

        return count
    else
        -- time to drain HP. 100-200
        local power = math.random(0, 101) + 100
        dmg = xi.mobskills.mobFinalAdjustments(power, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
        return dmg
    end
end

return mobskillObject
