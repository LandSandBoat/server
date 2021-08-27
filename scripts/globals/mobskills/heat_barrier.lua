-----------------------------------
-- Heat Barrier
-- Family: Wamouracampa
-- Description: Applies a thermal barrier, granting fiery spikes and fire damage on melee hits.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes:
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: Enfire power, Blaze Spikes reduced power in Salvage zones
    local typeEffectOne = xi.effect.BLAZE_SPIKES
    -- local typeEffectTwo = xi.effect.ENFIRE
    local randy = math.random(50, 67)
    skill:setMsg(MobBuffMove(mob, typeEffectOne, randy, 0, 180))
    -- MobBuffMove(mob, typeEffectTwo, ???, 0, 180)

    return typeEffectOne
end

return mobskill_object
