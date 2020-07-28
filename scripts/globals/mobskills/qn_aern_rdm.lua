---------------------------------------------
-- Chainspell
-- Meant for Qn'aern (RDM) with Ix'Aern encounter
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getPool() == 3269 and mob:getHPP() <= 70) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.CHAINSPELL
    MobBuffMove(mob, typeEffect, 1, 0, 60)

    skill:setMsg(tpz.msg.basic.USES)
    return typeEffect
end
