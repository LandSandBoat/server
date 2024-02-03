-----------------------------------
-- Plasma Charge
-- Covers the user in Shock spikes and absorbs damage. Enemies that hit it take fire damage.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.SHOCK_SPIKES, math.random(15, 30), 0, 180))

    return xi.effect.SHOCK_SPIKES
end

return mobskillObject
