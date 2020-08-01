---------------------------------------------
-- Deep Kiss
-- Steal one effect
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    skill:setMsg(MobDrainStatusEffectMove(mob, target))

    return 1
end
