-----------------------------------
-- Occultation
--
-- Description: Creates 25 shadows
-- Type: Magical (Wind)
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
    local base = math.random(10, 25)
    local typeEffect = xi.effect.BLINK

    skill:setMsg(MobBuffMove(mob, typeEffect, base, 0, 120))
    return typeEffect
end

return mobskill_object
