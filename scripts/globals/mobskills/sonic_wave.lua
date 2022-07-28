-----------------------------------
-- Sonic Wave
-- Reduces defense of enemies in an area of effect.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_DOWN
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 30, 0, 120))

    return typeEffect
end

return mobskill_object
