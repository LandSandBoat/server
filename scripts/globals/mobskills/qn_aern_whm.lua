-----------------------------------
-- Benediction
-- Meant for Qn'aern (WHM) with Ix'Aern encounter
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getPool() == 4651 and mob:getHPP() <= 50 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local maxHeal = target:getMaxHP() - target:getHP()
    target:eraseAllStatusEffect()
    target:addHP(maxHeal)
    target:wakeUp()
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return maxHeal
end

return mobskillObject
