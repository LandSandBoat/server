---------------------------------------------
-- Thornsong
--
-- Description: Covers the user in fiery spikes. Enemies that hit it take fire damage.
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
    -- can only use if not silenced
    if (mob:getMainJob() == tpz.job.BRD and mob:hasStatusEffect(tpz.effect.SILENCE) == false) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local power = mob:getMainLvl() * 2
    local duration = 180
    local typeEffect = tpz.effect.BLAZE_SPIKES
    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end
