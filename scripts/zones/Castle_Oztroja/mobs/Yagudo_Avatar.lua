-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Yagudo Avatar
-- Note: PH for Tzee Xicu the Manifest
-- TODO: messages should be zone-wide
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(900, 10800))
end

entity.onMobEngage = function(mob, target)
    mob:showText(mob, ID.text.YAGUDO_AVATAR_ENGAGE)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:showText(mob, ID.text.YAGUDO_AVATAR_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    local mobId = mob:getID()

    -- The quest version of this NM doesn't respawn or count toward hq nm.
    if mobId ~= ID.mob.YAGUDO_AVATAR then
        return
    end

     -- Respawn logic.
    local hqId        = mobId + 3
    local timeOfDeath = GetServerVariable('[POP]Tzee_Xicu_the_Manifest')
    local kills       = GetServerVariable('[PH]Tzee_Xicu_the_Manifest') + 1
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
        SetServerVariable('[PH]Tzee_Xicu_the_Manifest', kills)
    end
end

return entity
