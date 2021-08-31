-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Aspidochelone
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

    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.ASPIDOCHELONE_SINKER)
end

entity.onMobDespawn = function(mob)
    -- Set Aspidochelone's Window Open Time
    if xi.settings.LandKingSystem_HQ ~= 1 then
        local wait = 72 * 3600
        SetServerVariable("[POP]Aspidochelone", os.time() + wait) -- 3 days
        if xi.settings.LandKingSystem_HQ == 0 then -- Is time spawn only
            DisallowRespawn(mob:getID(), true)
        end
    end

    -- Set Adamantoise's spawnpoint and respawn time (21-24 hours)
    if xi.settings.LandKingSystem_NQ ~= 1 then
        SetServerVariable("[PH]Aspidochelone", 0)
        DisallowRespawn(ID.mob.ADAMANTOISE, false)
        UpdateNMSpawnPoint(ID.mob.ADAMANTOISE)
        GetMobByID(ID.mob.ADAMANTOISE):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    end
end

return entity
