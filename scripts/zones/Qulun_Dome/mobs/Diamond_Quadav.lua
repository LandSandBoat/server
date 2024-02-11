-----------------------------------
-- Area: Qulun_Dome
--   NM: Diamond Quadav
-- Note: PH for Za Dha Adamantking PH
-- TODO: messages should be zone-wide
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.QULUN_DOME]
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- the quest version of this NM doesn't drop gil
    if mob:getID() >= ID.mob.AFFABLE_ADAMANTKING_OFFSET then
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
    local nqId = mob:getID()

    -- the quest version of this NM doesn't respawn or count toward hq nm
    if nqId == ID.mob.DIAMOND_QUADAV then
        local hqId = mob:getID() + 1
        local timeOfDeath = GetServerVariable('[POP]Za_Dha_Adamantking')
        local kills = GetServerVariable('[PH]Za_Dha_Adamantking')
        local popNow = (math.random(1, 5) == 3 or kills > 6)

        if os.time() > timeOfDeath and popNow then
            DisallowRespawn(nqId, true)
            DisallowRespawn(hqId, false)
            UpdateNMSpawnPoint(hqId)
            GetMobByID(hqId):setRespawnTime(math.random(75600, 86400))
        else
            UpdateNMSpawnPoint(nqId)
            mob:setRespawnTime(math.random(75600, 86400))
            SetServerVariable('[PH]Za_Dha_Adamantking', kills + 1)
        end
    end
end

return entity
