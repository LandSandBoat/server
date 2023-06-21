-----------------------------------
-- Petal Pirouette
-- Description: Whirling petals reduce tp to zero.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local tpReduced = 0
    target:setTP(tpReduced)

    skill:setMsg(xi.msg.basic.TP_REDUCED)

    return tpReduced
end

return mobskillObject
