-----------------------------------
-- Fire Blade
-- Description: Applies Enfire and absorbs Fire damage.
-- Type: Enhancing
-- Used only by Kam'lanaut. Enfire aspect adds 70+ to his melee attacks.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.ENFIRE
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end

return mobskillObject
