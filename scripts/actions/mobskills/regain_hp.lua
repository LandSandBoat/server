-----------------------------------
-- Dynamis Statue (Regain HP)
--
-- Description: Regain HP for party members within area of effect.
--
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local hp = target:getMaxHP() - target:getHP()

    skill:setMsg(xi.msg.basic.AOE_REGAIN_HP)

    target:addHP(hp)
    target:wakeUp()

    return hp
end

return mobskillObject
