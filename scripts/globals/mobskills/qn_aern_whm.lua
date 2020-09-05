---------------------------------------------
-- Benediction
-- Meant for Qn'aern (WHM) with Ix'Aern encounter
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getPool() == 4651 and mob:getHPP() <= 50) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local maxHeal = target:getMaxHP() - target:getHP()
    target:eraseAllStatusEffect()
    target:addHP(maxHeal)
    target:wakeUp()
    skill:setMsg(tpz.msg.basic.SELF_HEAL)

    return maxHeal
end
