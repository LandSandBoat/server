---------------------------------------------
-- Regeneration
--
-- Description: Adds a Regen tpz.effect.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
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
    local power = mob:getMainLvl()/10 * 4 + 5
    local duration = 60

    local typeEffect = tpz.effect.REGEN

    skill:setMsg(MobBuffMove(mob, typeEffect, power, 3, duration))
    return typeEffect
end

return mobskill_object
