-----------------------------------
-- Hexagon Belt
-- Enhances defense by 20%.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Overwrites existing defense boost effect
    if mob:hasStatusEffect(xi.effect.DEFENSE_BOOST) then
        mob:delStatusEffect(xi.effect.DEFENSE_BOOST)
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 21, 0, 180))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
