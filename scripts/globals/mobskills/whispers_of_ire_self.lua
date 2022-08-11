-----------------------------------
-- Whispers of Ire
-- Targets itself and removes all debuffs
-- Type: Magical
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    local dispel = target:eraseStatusEffect()

    if dispel ~= xi.effect.NONE then
        return 0
    end

    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local effectcount = mob:eraseAllStatusEffect()

    skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)

    return effectcount
end

return mobskill_object
