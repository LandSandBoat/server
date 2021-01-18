-----------------------------------
-- Ark Guardian: Tarutaru
-- Begin Ark Angel TT teleport
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
    mob:useMobAbility(mob:getMobMod(tpz.mobMod.TELEPORT_END))
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end

return mobskill_object
