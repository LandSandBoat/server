---------------------------------------------
-- Heat Barrier
-- Family: Wamouracampa
-- Description: Applies a thermal barrier, granting fiery spikes and fire damage on melee hits.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- TODO: Enfire power, Blaze Spikes reduced power in Salvage zones
    local typeEffectOne = tpz.effect.BLAZE_SPIKES
    -- local typeEffectTwo = tpz.effect.ENFIRE
    local randy = math.random(50, 67)
    skill:setMsg(MobBuffMove(mob, typeEffectOne, randy, 0, 180))
    -- MobBuffMove(mob, typeEffectTwo, ???, 0, 180)

    return typeEffectOne
end
