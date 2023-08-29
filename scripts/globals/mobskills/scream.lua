-----------------------------------
-- Scream
-- 15' Reduces MND of players in area of effect.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = target:getStat(xi.mod.MND) * 0.25
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, power, 10, 180))

    return xi.effect.MND_DOWN
end

return mobskillObject
