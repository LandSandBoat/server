---------------------------------------------
-- Dukkeripen
-- adds 10 shadows
-- Type: Magical
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getMainJob() == tpz.job.COR then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)

    skill:setMsg(MobBuffMove(mob, tpz.effect.BLINK, 10, 0, 120))

    return tpz.effect.BLINK
end
