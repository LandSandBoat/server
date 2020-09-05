---------------------------------------------
-- Dynamis Statue (Regain MP)
--
-- Description: Regain MP for party members within area of effect.
--
---------------------------------------------
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local mp = target:getMaxMP() - target:getMP()

    skill:setMsg(tpz.msg.basic.AOE_REGAIN_MP)

    target:addMP(mp)

    return mp
end
