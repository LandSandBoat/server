-----------------------------------
-- Astral Flow
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.USES)

    local mobID        = mob:getID()
    local avatarOffset = mob:getMobMod(xi.mobMod.ASTRAL_PET_OFFSET)
    local avatarId     = mobID + (avatarOffset > 0 and avatarOffset or 2)

    xi.mob.callPets(mob, avatarId, { noAnimation = true })

    return xi.effect.ASTRAL_FLOW
end

return mobskillObject
