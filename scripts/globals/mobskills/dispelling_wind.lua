-----------------------------------
-- Dispelling Wind
--
-- Description: Dispels two effects from targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial
-- Notes:
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
    local dis1 = target:dispelStatusEffect()
    local dis2 = target:dispelStatusEffect()

    if dis1 ~= xi.effect.NONE and dis2 ~= xi.effect.NONE then
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        return 2
    elseif dis1 ~= xi.effect.NONE or dis2 ~= xi.effect.NONE then
        -- dispeled only one
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        return 1
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    return 0
end

return mobskillObject
