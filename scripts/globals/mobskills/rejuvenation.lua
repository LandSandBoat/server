---------------------------------------------
-- Rejuvenation
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local hp = target:getMaxHP() - target:getHP()
    target:addHP(hp)
    target:addMP(target:getMaxMP() - target:getMP())
    target:addTP(3000 - target:getTP())

    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    return hp
end
