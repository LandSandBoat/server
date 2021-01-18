-----------------------------------
-- Super Buff
-- Raises physical attack, defense, magic attack and magic evasion
-- Used by Nidhogg at will
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    target:addStatusEffectEx(tpz.effect.SUPER_BUFF, 0, 50, 0, 30)
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end

return mobskill_object
