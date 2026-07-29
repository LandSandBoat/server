-----------------------------------
-- Lightning Blade
-- Description: Applies Enthunder and absorbs Lightning damage.
-- Type: Enhancing
-- Used only by Kam'lanaut. Enthunder aspect adds 70+ to his melee attacks.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ENTHUNDER, 65, 0, 1800)) -- Lasts until replaced or dispelled.

    return xi.effect.ENTHUNDER
end

return mobskillObject
