-----------------------------------
-- Rejuvenation
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local hp = target:getMaxHP() - target:getHP()
    target:addHP(hp)
    target:addMP(target:getMaxMP() - target:getMP())
    target:addTP(3000 - target:getTP())

    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return hp
end

return mobskill_object
