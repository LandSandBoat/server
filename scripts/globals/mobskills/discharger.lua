---------------------------------------------
-- Discharger
--
-- Description: Places a magic barrier and shock spikes.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Used only by Omega
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobhp = mob:getHPP()

    if (mobhp < 26) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffectOne = tpz.effect.MAGIC_SHIELD
    local typeEffectTwo = tpz.effect.SHOCK_SPIKES

    skill:setMsg(MobBuffMove(mob, typeEffectOne, 1, 0, 60))
    MobBuffMove(mob, typeEffectTwo, 25, 0, 60)
    return typeEffectOne
end
