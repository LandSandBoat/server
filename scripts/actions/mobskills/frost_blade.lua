-----------------------------------
-- Frost Blade
-- Description: Applies Enblizzard and absorbs Ice damage.
-- Type: Enhancing
-- Used only by Kam'lanaut. Enblizzard aspect adds 70+ to his melee attacks.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ENBLIZZARD, 65, 0, 60))

    return xi.effect.ENBLIZZARD
end

return mobskillObject
