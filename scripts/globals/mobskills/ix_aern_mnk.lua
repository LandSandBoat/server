---------------------------------------------
-- Hundred Fists
-- Meant for Ix'Aern (MNK)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getPool() == 4661 and mob:getHPP() <= 50
    and mob:getLocalVar("BracerMode") == 1) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.HUNDRED_FISTS
    MobBuffMove(mob, typeEffect, 1, 0, 45)
    mob:setLocalVar("BracerMode", 2)
    skill:setMsg(tpz.msg.basic.USES)
    return typeEffect
end
