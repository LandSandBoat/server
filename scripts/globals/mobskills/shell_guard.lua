-----------------------------------
-- Shell Guard
-- Increases defense of user.
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
    local base = 100
    local typeEffect = xi.effect.DEFENSE_BOOST
    skill:setMsg(MobBuffMove(mob, typeEffect, base, 0, 180))
    return typeEffect
end

return mobskill_object
