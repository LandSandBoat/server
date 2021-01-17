---------------------------------------------
-- Frog Cheer
-- Increases magical attack and grants Elemental Seal tpz.effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.MAGIC_ATK_BOOST

    skill:setMsg(MobBuffMove(mob, typeEffect, 25, 0, 300))
    return typeEffect
end

return mobskill_object
