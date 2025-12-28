-----------------------------------
-- Saline Coat
--
-- Family: Xzomit
-- Type: Enhancing
-- Can be dispelled: Yes
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: ~50% Magic DEF boost.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 100 + (skill:getTP() - 1000) / 100

    -- Decay is 5 per tick
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, power, 0, 60))

    return xi.effect.MAGIC_DEF_BOOST
end

return mobskillObject
