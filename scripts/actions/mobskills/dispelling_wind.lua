-----------------------------------
-- Dispelling Wind
-- Description: Dispels up to 3 effects from targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dispelCount = math.random(1, 3)
    local successfulDispels = 0

    for i = 1, dispelCount do
        local dispelled = target:dispelStatusEffect()
        if dispelled ~= xi.effect.NONE then
            successfulDispels = successfulDispels + 1
        end
    end

    if successfulDispels > 0 then
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        return successfulDispels
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
        return 0
    end
end

return mobskillObject
