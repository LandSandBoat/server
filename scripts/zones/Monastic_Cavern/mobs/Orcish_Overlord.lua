-----------------------------------
-- Area: Monastic Cavern
--   NM: Orcish Overlord
-- Note: PH for Overlord Bakgodek
-- TODO: messages should be zone-wide
-----------------------------------
local ID = zones[xi.zone.MONASTIC_CAVERN]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  219.000, y = -2.000, z = -99.000 }
}

entity.onMobInitialize = function(mob)
    -- Update spawn point and set respawn time
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(75600 + 1800 * math.random(1, 6))

    -- the quest version of this NM doesn't drop gil
    if mob:getID() >= ID.mob.UNDERSTANDING_OVERLORD_OFFSET then
        mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    end

    if mob:getID() == ID.mob.ORCISH_OVERLORD then
        mob:addMod(xi.mod.DOUBLE_ATTACK, 20)
    end
end

entity.onMobEngage = function(mob, target)
    mob:showText(mob, ID.text.ORCISH_OVERLORD_ENGAGE)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:showText(mob, ID.text.ORCISH_OVERLORD_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    local mobId = mob:getID()

    -- The quest version of this NM doesn't respawn or count toward hq nm.
    if mobId ~= ID.mob.ORCISH_OVERLORD then
        return
    end

    -- Respawn logic.
    local hqId        = mobId + 1
    local timeOfDeath = GetServerVariable('[POP]Overlord_Bakgodek')
    local kills       = GetServerVariable('[PH]Overlord_Bakgodek') + 1
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
        SetServerVariable('[PH]Overlord_Bakgodek', kills)
    end
end

return entity
