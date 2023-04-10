-----------------------------------
-- Familiar
-- pet powers increase.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:familiar()

    skill:setMsg(xi.msg.basic.FAMILIAR_MOB)

    return 0
end

return mobskillObject
