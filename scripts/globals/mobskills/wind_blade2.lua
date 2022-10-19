-----------------------------------
--  Wind Blade
--  Description: Applies Enaero and absorbs Wind damage.
--  Type: Enhancing
--  Used only by Kam'lanaut. Enaero aspect adds 70+ to his melee attacks.
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
    local typeEffect = xi.effect.ENAERO
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end

return mobskillObject
