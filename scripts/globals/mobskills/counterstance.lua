-----------------------------------
-- Mobskill: Counterstance
-- Increases chance to counter but lowers defense.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(mob, target, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(mob, target, skill)
    local typeEffect = xi.effect.COUNTERSTANCE
    local power = 20

    skill:setMsg(xi.mobskills.mobBuffMove(target, typeEffect, power, 3, 420))
    return typeEffect
end

return mobskill_object
