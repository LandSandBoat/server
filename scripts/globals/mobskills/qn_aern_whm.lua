-----------------------------------
-- Benediction
-- Meant for Qn'aern (WHM) with Ix'Aern encounter
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:getPool() == 4651 and mob:getHPP() <= 50) then
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local maxHeal = target:getMaxHP() - target:getHP()
    target:eraseAllStatusEffect()
    target:addHP(maxHeal)
    target:wakeUp()
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return maxHeal
end

return mobskill_object
