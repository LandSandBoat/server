-----------------------------------
-- Earthen Ward
-- Titan grants Stoneskin to party members within area of effect.
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
    local typeEffect = xi.effect.STONESKIN
    local base = mob:getMainLvl() * 2 + 50

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, base, 0, 180))

    return xi.effect.STONESKIN
end

return mobskillObject
