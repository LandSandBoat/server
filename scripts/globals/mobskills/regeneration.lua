-----------------------------------
-- Regeneration
--
-- Description: Adds a Regen xi.effect.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = mob:getMainLvl() / 10 * 4 + 5
    local duration = 60

    local typeEffect = xi.effect.REGEN

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 3, duration))
    return typeEffect
end

return mobskillObject
