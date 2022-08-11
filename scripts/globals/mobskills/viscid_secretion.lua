-----------------------------------
-- Viscid Secretion
-- Inflicts slow and Gravity in a conal area
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
    local slow = xi.effect.SLOW
    local gravity = xi.effect.WEIGHT
    local duration = math.random(110, 130)

    xi.mobskills.mobStatusEffectMove(mob, target, gravity, 25, 0, duration)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, slow, 2500, 0, duration))

    return slow
end

return mobskill_object
