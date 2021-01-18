---------------------------------------------
-- Familiar
-- pet powers increase.
---------------------------------------------
require("scripts/globals/msg")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    mob:familiar()

    skill:setMsg(tpz.msg.basic.FAMILIAR_MOB)

    return 0
end

return mobskill_object
