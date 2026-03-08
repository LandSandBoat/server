-----------------------------------
-- Frost Armor
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ICE_SPIKES, 10, 0, 180))

    return xi.effect.ICE_SPIKES
end

return mobskillObject
