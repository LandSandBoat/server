-----------------------------------
-- Memento Mori
-- Enhances Magic Attack.
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
    local typeEffect = xi.effect.MAGIC_ATK_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 20, 0, 300))
    return typeEffect
end

return mobskillObject
