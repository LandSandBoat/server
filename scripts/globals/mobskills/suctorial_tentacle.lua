-----------------------------------
-- Poison Sting
-- Induces poison
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.POISON

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 5, 3, 180))

    return typeEffect
end

return mobskill_object
