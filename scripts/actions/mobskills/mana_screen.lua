-----------------------------------
-- Mana_Screen
-- Description: Magic Shield
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getLocalVar('citadelBuster') == 0 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_SHIELD, 1, 0, 60))

    return xi.effect.MAGIC_SHIELD
end

return mobskillObject
