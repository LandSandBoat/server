-----------------------------------
-- Arua Of Persistence
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
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 30, 60)
    local power = 20
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, duration))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
