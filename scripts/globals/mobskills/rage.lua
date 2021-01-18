---------------------------------------------
-- Rage
--
-- Description: The Ram goes berserk
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: 25% Attack UP, -25% defense DOWN
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
    local duration = 60

    local typeEffect = tpz.effect.BERSERK
    skill:setMsg(MobBuffMove(mob, typeEffect, 1, 0, duration))
    return typeEffect
end

return mobskill_object
