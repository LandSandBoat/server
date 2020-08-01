---------------------------------------------
-- Void of Repentance
--
-- Description: Fills a single target with regret, inflicting Terror.
-- Type: Enfeebling
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: Ignores shadows?
-- Range: Unknown
-- Notes: Accompanied by text
-- "Repent thy irreverence...
-- The gate to salvation...lies before thee...
-- Revelation...is within thy reach..."
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.TERROR, 1, 0, 30))

    return tpz.effect.TERROR
end
