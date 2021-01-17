---------------------------------------------
-- Goblin Dice
--
-- Description: Reset recasts on abilities
-- Type: Physical (Blunt)
--
--
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

    target:resetRecasts()

    skill:setMsg(tpz.msg.basic.ABILITIES_RECHARGED)

    return 1
end

return mobskill_object
