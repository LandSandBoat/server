-----------------------------------
-- Benediction
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    target:eraseAllStatusEffect()

    local maxHeal = target:getMaxHP() - target:getHP()

    target:addHP(maxHeal)
    target:wakeUp()

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return maxHeal
end

return mobskill_object
