-----------------------------------
-- Lightning Blade
-- Description: Applies Enthunder and absorbs Lightning damage.
-- Type: Enhancing
-- Used only by Kam'lanaut. Enthunder aspect adds 70+ to his melee attacks.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.ENTHUNDER
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end

return mobskillObject
