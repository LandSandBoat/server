-----------------------------------
-- Molluscous Mutation
--
-- Family: Xzomit
-- Type: Enhancing
-- Can be dispelled: Yes
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: ~75% Defense boost.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 50 + 10 * math.floor((skill:getTP() - 1000) / 1000)

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, 60))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
