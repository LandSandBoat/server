-----------------------------------
-- Binary Tap
-- Attempts to absorb two buffs from a single target.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: Melee
-- Notes: Can be any (positive) buff, including food.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dispel = nil
    local count = 0
    local msg -- to be set later

    for i = 1, 2 do
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
