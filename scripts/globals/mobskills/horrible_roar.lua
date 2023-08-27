---------------------------------------------
-- Horrible Roar
--
-- Description: Dispels four effects from targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Wipes Shadows
-- Range: 25' radial
-- Notes: Used by Bahamut in Wyrmking Descends
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getID() == 16896156 then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local count = 0

    for i = 1, 4 do
        local dispel = target:dispelStatusEffect()
        if dispel ~= xi.effect.NONE then
            count = count + 1
        end
    end

    if count > 0 then
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    return count
end

return mobskillObject
