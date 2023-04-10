-----------------------------------
-- Rejuvenation
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local hp = target:getMaxHP() - target:getHP()
    target:addHP(hp)
    target:addMP(target:getMaxMP() - target:getMP())
    target:addTP(3000 - target:getTP())

    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return hp
end

return mobskillObject
