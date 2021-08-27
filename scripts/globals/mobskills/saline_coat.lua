-----------------------------------
-- Saline Coat
--
-- Family: Xzomit
-- Type: Enhancing
-- Can be dispelled: Yes
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: ~50% Magic DEF boost.
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
    local typeEffect = xi.effect.MAGIC_DEF_BOOST
    skill:setMsg(MobBuffMove(mob, typeEffect, 50, 0, 60))

    return typeEffect
end

return mobskill_object
