-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Adamantoise
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    if xi.settings.LandKingSystem_NQ > 0 or xi.settings.LandKingSystem_HQ > 0 then
        GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)
    end
    if xi.settings.LandKingSystem_HQ == 0 then
        SetDropRate(24, 3344, 0) -- do not drop clump_of_red_pondweed
    end

    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.TORTOISE_TORTURER)
end

entity.onMobDespawn = function(mob)
    local ToD = GetServerVariable("[POP]Aspidochelone")
    local kills = GetServerVariable("[PH]Aspidochelone")
    local popNow = (math.random(1, 5) == 3 or kills > 6)

    if xi.settings.LandKingSystem_HQ ~= 1 and ToD <= os.time() and popNow then
        -- 0 = timed spawn, 1 = force pop only, 2 = BOTH
        if xi.settings.LandKingSystem_NQ == 0 then
            DisallowRespawn(ID.mob.ADAMANTOISE, true)
        end

        DisallowRespawn(ID.mob.ASPIDOCHELONE, false)
        UpdateNMSpawnPoint(ID.mob.ASPIDOCHELONE)
        GetMobByID(ID.mob.ASPIDOCHELONE):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    else
        if xi.settings.LandKingSystem_NQ ~= 1 then
            UpdateNMSpawnPoint(ID.mob.ADAMANTOISE)
            GetMobByID(ID.mob.ADAMANTOISE):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
            SetServerVariable("[PH]Aspidochelone", kills + 1)
        end
    end
end

return entity
