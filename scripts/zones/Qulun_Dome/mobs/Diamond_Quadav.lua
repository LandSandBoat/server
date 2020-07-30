-----------------------------------
-- Area: Qulun_Dome
--   NM: Diamond Quadav
-- Note: PH for Za Dha Adamantking PH
-- TODO: messages should be zone-wide
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Qulun_Dome/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    -- the quest version of this NM doesn't drop gil
    if mob:getID() >= ID.mob.AFFABLE_ADAMANTKING_OFFSET then
        mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    end
end

function onMobEngaged(mob, target)
    mob:showText(mob, ID.text.DIAMOND_QUADAV_ENGAGE)
end

function onMobDeath(mob, player, isKiller)
    if isKiller then
        mob:showText(mob, ID.text.DIAMOND_QUADAV_DEATH)
    end
end

function onMobDespawn(mob)
    local nqId = mob:getID()

    -- the quest version of this NM doesn't respawn or count toward hq nm
    if nqId == ID.mob.DIAMOND_QUADAV then
        local hqId = mob:getID() + 1
        local ToD = GetServerVariable("[POP]Za_Dha_Adamantking")
        local kills = GetServerVariable("[PH]Za_Dha_Adamantking")
        local popNow = (math.random(1, 5) == 3 or kills > 6)

        if os.time() > ToD and popNow then
            DisallowRespawn(nqId, true)
            DisallowRespawn(hqId, false)
            UpdateNMSpawnPoint(hqId)
            GetMobByID(hqId):setRespawnTime(math.random(75600, 86400))
        else
            UpdateNMSpawnPoint(nqId)
            mob:setRespawnTime(math.random(75600, 86400))
            SetServerVariable("[PH]Za_Dha_Adamantking", kills + 1)
        end
    end
end
