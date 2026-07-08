-----------------------------------
-- Lightning Armor
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.SHOCK_SPIKES, 10, 0, 180))

    return xi.effect.SHOCK_SPIKES
end

return mobskillObject
