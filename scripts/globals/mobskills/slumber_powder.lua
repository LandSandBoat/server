---------------------------------------------
-- Slumber Powder
-- 10' AoE sleep
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLEEP_I
    local power = math.random(15, 20) + mob:getMainLvl()/4


    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, power))

    return typeEffect
end
