-----------------------------------
-- Plasma Charge
-- Covers the user in Shock spikes and absorbs damage. Enemies that hit it take fire damage.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SHOCK_SPIKES
    local randy = math.random(15, 30)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, randy, 0, 180))

    return typeEffect
end

return mobskillObject
