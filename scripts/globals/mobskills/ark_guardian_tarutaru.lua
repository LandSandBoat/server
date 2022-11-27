-----------------------------------
-- Ark Guardian: Tarutaru
-- Begin Ark Angel TT teleport
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:useMobAbility(mob:getMobMod(xi.mobMod.TELEPORT_END))
    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
