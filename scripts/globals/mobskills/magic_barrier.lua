-----------------------------------
-- Magic Barrier
--
-- Description: Ranged shield
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.MAGIC_SHIELD

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1, 0, 60))

    return typeEffect
end

return mobskill_object
