-----------------------------------
-- Frightful Roar
--
-- Description: Weakens defense of enemies within range.
-- Type: Magical (Wind)
-- Player version is 10%.  Mob version is 30% https://www.bg-wiki.com/ffxi/Category:Taurus
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_DOWN
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 30, 0, 180))
    return typeEffect
end

return mobskillObject
