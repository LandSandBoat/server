-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Adamantoise
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobSpawn(mob)
    if LandKingSystem_NQ > 0 or LandKingSystem_HQ > 0 then
        GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(tpz.status.DISAPPEAR)
    end
    if LandKingSystem_HQ == 0 then
        SetDropRate(24, 3344, 0) -- do not drop clump_of_red_pondweed
    end

    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.TORTOISE_TORTURER)
end

function onMobDespawn(mob)
    local ToD = GetServerVariable("[POP]Aspidochelone")
    local kills = GetServerVariable("[PH]Aspidochelone")
    local popNow = (math.random(1, 5) == 3 or kills > 6)

    if LandKingSystem_HQ ~= 1 and ToD <= os.time() and popNow then
        -- 0 = timed spawn, 1 = force pop only, 2 = BOTH
        if LandKingSystem_NQ == 0 then
            DisallowRespawn(ID.mob.ADAMANTOISE, true)
        end

        DisallowRespawn(ID.mob.ASPIDOCHELONE, false)
        UpdateNMSpawnPoint(ID.mob.ASPIDOCHELONE)
        GetMobByID(ID.mob.ASPIDOCHELONE):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    else
        if LandKingSystem_NQ ~= 1 then
            UpdateNMSpawnPoint(ID.mob.ADAMANTOISE)
            GetMobByID(ID.mob.ADAMANTOISE):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
            SetServerVariable("[PH]Aspidochelone", kills + 1)
        end
    end
end
