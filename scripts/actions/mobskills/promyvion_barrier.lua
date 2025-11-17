-----------------------------------
-- Promyvion Barrier
-- Enhances defense.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.DEFENSE_BOOST) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 20, 0, 180))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
