-----------------------------------
-- Area: Monastic Cavern
--   NM: Orcish Overlord
-- Note: PH for Overlord Bakgodek
-- TODO: messages should be zone-wide
-----------------------------------
local ID = require("scripts/zones/Monastic_Cavern/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- the quest version of this NM doesn't drop gil
    if mob:getID() >= ID.mob.UNDERSTANDING_OVERLORD_OFFSET then
        mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    end
end

entity.onMobEngaged = function(mob, target)
    mob:showText(mob, ID.text.ORCISH_OVERLORD_ENGAGE)
end

entity.onMobDeath = function(mob, player, isKiller)
    if isKiller then
        mob:showText(mob, ID.text.ORCISH_OVERLORD_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    local nqId = mob:getID()

    -- the quest version of this NM doesn't respawn or count toward hq nm
    if nqId == ID.mob.ORCISH_OVERLORD then
        local hqId = mob:getID() + 1
        local ToD = GetServerVariable("[POP]Overlord_Bakgodek")
        local kills = GetServerVariable("[PH]Overlord_Bakgodek")
        local popNow = (math.random(1, 5) == 3 or kills > 6)

        if os.time() > ToD and popNow then
            DisallowRespawn(nqId, true)
            DisallowRespawn(hqId, false)
            UpdateNMSpawnPoint(hqId)
            if RESPAWN_SAVE_TIME then
                GetMobByID(hqId):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
            else
                GetMobByID(hqId):setRespawnTime(math.random(75600, 86400))
            end
        else
            UpdateNMSpawnPoint(nqId)
            if RESPAWN_SAVE_TIME then
                mob:setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
            else
                mob:setRespawnTime(math.random(75600, 86400))
            end
            SetServerVariable("[PH]Overlord_Bakgodek", kills + 1)
        end
    end
end

return entity
