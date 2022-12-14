-----------------------------------
-- Viscid Secretion
-- Inflicts slow and Gravity in a conal area
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local slow = xi.effect.SLOW
    local gravity = xi.effect.WEIGHT
    local duration = math.random(120, 180)

    xi.mobskills.mobStatusEffectMove(mob, target, gravity, 50, 0, duration)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, slow, 5000, 0, duration))

    return slow
end

return mobskillObject
