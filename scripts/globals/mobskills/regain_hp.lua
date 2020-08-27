---------------------------------------------
-- Dynamis Statue (Regain HP)
--
-- Description: Regain HP for party members within area of effect.
--
---------------------------------------------
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local hp = target:getMaxHP() - target:getHP()

    skill:setMsg(tpz.msg.basic.AOE_REGAIN_HP)

    target:addHP(hp)
    target:wakeUp()

    return hp
end
