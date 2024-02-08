-----------------------------------
-- Water Blade
-- Description: Applies Enwater and absorbs Water damage.
-- Type: Enhancing
-- Used only by Kam'lanaut. Enwater aspect adds 70+ to his melee attacks.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ENWATER, 65, 0, 60))

    return xi.effect.ENWATER
end

return mobskillObject
