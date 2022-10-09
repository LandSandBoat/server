-----------------------------------
-- Warcry
-- Adds attack bonus to party members within range.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local power = math.floor((mob:getMainLvl()/4)+4.75)/256
    local typeEffect = xi.effect.WARCRY
    local duration = 30

    skill:setMsg(xi.mobskills.mobBuffMove(target, typeEffect, power, 3, duration))
    return typeEffect
end

return mobskill_object
