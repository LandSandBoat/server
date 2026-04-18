-----------------------------------
-- Warp in (Eald'Narche)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    mob:useMobAbility(mob:getMobMod(xi.mobMod.TELEPORT_END))
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
