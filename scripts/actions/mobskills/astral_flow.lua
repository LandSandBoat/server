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
    local avatar       = mobID + (avatarOffset > 0 and avatarOffset or 2)

    if not GetMobByID(avatar):isSpawned() then
        GetMobByID(avatar):setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        local mobTarget = mob:getTarget()
        if mobTarget then
            SpawnMob(avatar):updateEnmity(mobTarget)
        end
    end

    return xi.effect.ASTRAL_FLOW
end

return mobskillObject
