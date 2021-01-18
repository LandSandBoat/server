-----------------------------------
-- Dynamis Statue (Regain MP)
--
-- Description: Regain MP for party members within area of effect.
--
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local mp = target:getMaxMP() - target:getMP()

    skill:setMsg(tpz.msg.basic.AOE_REGAIN_MP)

    target:addMP(mp)

    return mp
end

return mobskill_object
