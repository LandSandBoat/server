---------------------------------------------
-- Nepenthean Hum
-- Description: Inflicts amnesia 10' AOE
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if VanadielHour() >= 6 and VanadielHour() <= 18 then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.AMNESIA

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 60))
    return typeEffect
end
