-----------------------------------
-- Heat Barrier
-- Family: Wamouracampa
-- Description: Applies a thermal barrier, granting fiery spikes and fire damage on melee hits.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: Enfire power, Blaze Spikes reduced power in Salvage zones
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BLAZE_SPIKES, math.random(50, 67), 0, 180))
    -- xi.mobskills.mobBuffMove(mob, xi.effect.ENFIRE, ???, 0, 180)

    return xi.effect.BLAZE_SPIKES
end

return mobskillObject
