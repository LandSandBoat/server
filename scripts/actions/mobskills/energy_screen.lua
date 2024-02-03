-----------------------------------
-- Energy_Screen
-- Description: Invincible
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getLocalVar('citadelBuster') == 0 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PHYSICAL_SHIELD, 1, 0, 60))

    return xi.effect.PHYSICAL_SHIELD
end

return mobskillObject
