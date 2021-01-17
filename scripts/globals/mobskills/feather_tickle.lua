---------------------------------------------
-- Feather Tickle
--
-- Description: Reduces tp to zero.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local tpReduced = 0
    target:setTP(tpReduced)

    skill:setMsg(tpz.msg.basic.TP_REDUCED)

    return tpReduced
end

return mobskill_object
