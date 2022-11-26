-----------------------------------
-- Berserk
-- Berserk Ability.
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
    local typeEffect = xi.effect.BERSERK
    local power = (116 / 256) * 100
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, 180))
    return typeEffect
end

return mobskillObject
