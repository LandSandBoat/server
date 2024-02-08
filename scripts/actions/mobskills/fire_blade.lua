-----------------------------------
-- Fire Blade
-- Description: Applies Enfire and absorbs Fire damage.
-- Type: Enhancing
-- Used only by Kam'lanaut. Enfire aspect adds 70+ to his melee attacks.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ENFIRE, 65, 0, 60))

    return xi.effect.ENFIRE
end

return mobskillObject
