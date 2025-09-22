-----------------------------------
-- Area: Throne Room
--  Mob: Duke Dantalian
-- BCNM: Kindred Spirits
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, 3)
end

entity.onMobSpawn = function(mob)
    local mobID = mob:getID()
    local avatarID = mobID + mob:getMobMod(xi.mobMod.ASTRAL_PET_OFFSET)
    local avatarMob = GetMobByID(avatarID)
    if avatarMob then
        -- Remove the original listener set from mixins/families/avatar
        avatarMob:removeListener('AVATAR_SPAWN')

        -- Replace with a similar listener which is hardcoded to use Shiva
        avatarMob:addListener('SPAWN', 'AVATAR_SPAWN', function(mobArg)
            local modelId = 797 -- Shiva
            mobArg:setModelId(modelId)
            mobArg:hideName(false)
            mobArg:setUntargetable(true)
            mobArg:setUnkillable(true)
            mobArg:setAutoAttackEnabled(false)
            mobArg:setMagicCastingEnabled(false)

            -- If something goes wrong, the avatar will clean itself up in 5s
            mobArg:timer(5000, function(mobTimerArg)
                if mobTimerArg:isAlive() then
                    mobTimerArg:setUnkillable(false)
                    mobTimerArg:setHP(0)
                end
            end)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local elementalId = mob:getID() + 2
    if GetMobByID(elementalId):isSpawned() then
        DespawnMob(elementalId)
    end
end

return entity
