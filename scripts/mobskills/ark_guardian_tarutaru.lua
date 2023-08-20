-----------------------------------
-- Ark Guardian: Tarutaru
-- Begin Ark Angel TT teleport
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
