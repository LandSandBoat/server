-----------------------------------
-- Trinary Tap
-- Attempts to absorb three buffs from a single target, or otherwise steals HP.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: Melee
-- Notes: Can be any (positive) buff, including food. Will drain about 100HP if it can't take any buffs
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:isMobType(xi.mobType.NOTORIOUS) or
        target:hasStatusEffect(xi.effect.BATTLEFIELD)
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dispel = nil
    local count = 0
    local msg -- to be set later

    for i = 1, 3 do
        dispel = mob:stealStatusEffect(target, bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))

        if dispel ~= 0 then
            count = count + 1
        end
    end

    if count == 0 then
        msg = xi.msg.basic.SKILL_NO_EFFECT -- no effect
    else
        msg = xi.msg.basic.DISAPPEAR_NUM
    end

    skill:setMsg(msg)

    return count
end

return mobskillObject
