-----------------------------------
-- Fossilizaing Breath
--
-- Description: Petrifies targets within a fan-shaped area.
-- Type: Breath
-- Ignores Shadows
-- Range: Unknown cone
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 1805 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION
    local power = 1
    local duration = 30

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end

return mobskillObject
