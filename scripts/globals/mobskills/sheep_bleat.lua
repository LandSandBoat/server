---------------------------------------------
-- Sheep Bleat
-- Emits a unnerving bleat that slows down players in range.
--
-- Only used by Nightmare Sheep from Dynamis-Valkurm
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 1 -- The mob that uses this is not in database yet so returns 1 , when mob is added to game do a check for mob ID and return 0 if it matches nightmare sheep
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLOW
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1250, 0, 120))

    return typeEffect
end
