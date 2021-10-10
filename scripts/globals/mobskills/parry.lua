-----------------------------------
-- Parry
-- Enhances defense.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST
    skill:setMsg(MobBuffMove(mob, typeEffect, 15, 0, 300))
    return typeEffect
end

return mobskill_object
