-----------------------------------
-- Area: Qulun_Dome
--   NM: Diamond Quadav
-- Note: PH for Za Dha Adamantking PH
-- TODO: messages should be zone-wide
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.QULUN_DOME]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  277.930, y =  42.625, z =  96.177 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(75600 + 1800 * math.random(1, 6))
    -- the quest version of this NM doesn't drop gil
    if mob:getID() >= ID.mob.DIAMOND_QUADAV + 2 then
        mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    end
end

entity.onMobEngage = function(mob, target)
    mob:showText(mob, ID.text.DIAMOND_QUADAV_ENGAGE)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:showText(mob, ID.text.DIAMOND_QUADAV_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    local mobId = mob:getID()

 -- The quest version of this NM doesn't respawn or count toward hq nm.
    if mobId ~= ID.mob.DIAMOND_QUADAV then
        return
    end

    -- Respawn logic.
    local hqId        = mobId + 1
    local timeOfDeath = GetServerVariable('[POP]Za_Dha_Adamantking')
    local kills       = GetServerVariable('[PH]Za_Dha_Adamantking') + 1
    local popNow      = kills >= 7 or (kills >= 2 and math.random(1, 100) <= 20)
    local respawnTime = 75600 + 1800 * math.random(1, 6)

    if GetSystemTime() > timeOfDeath and popNow then
        DisallowRespawn(mobId, true)
        DisallowRespawn(hqId, false)
        xi.mob.updateNMSpawnPoint(hqId)
        GetMobByID(hqId):setRespawnTime(respawnTime)
    else
        xi.mob.updateNMSpawnPoint(mobId)
        mob:setRespawnTime(respawnTime)
        SetServerVariable('[PH]Za_Dha_Adamantking', kills)
    end
end

return entity
