-----------------------------------
-- Whispers of Ire
-- Targets itself and removes all debuffs
-- Type: Magical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local dispel = target:eraseStatusEffect()

    if dispel ~= xi.effect.NONE then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local effectcount = mob:eraseAllStatusEffect()
    skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)

    return effectcount
end

return mobskillObject
