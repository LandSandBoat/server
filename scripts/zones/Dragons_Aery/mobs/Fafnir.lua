-----------------------------------
-- Area: Dragons Aery
--  HNM: Fafnir
-----------------------------------
local ID = require("scripts/zones/Dragons_Aery/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobSpawn(mob)
    if LandKingSystem_NQ > 0 or LandKingSystem_HQ > 0 then
        GetNPCByID(ID.npc.FAFNIR_QM):setStatus(tpz.status.DISAPPEAR)
    end
    if LandKingSystem_HQ == 0 then
        SetDropRate(918, 3340, 0) -- do not drop cup_of_sweet_tea
    end

    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.FAFNIR_SLAYER)
end

function onMobDespawn(mob)
    local ToD = GetServerVariable("[POP]Nidhogg")
    local kills = GetServerVariable("[PH]Nidhogg")
    local popNow = (math.random(1, 5) == 3 or kills > 6)

    if LandKingSystem_HQ ~= 1 and ToD <= os.time() and popNow then
        -- 0 = timed spawn, 1 = force pop only, 2 = BOTH
        if LandKingSystem_NQ == 0 then
            DisallowRespawn(ID.mob.FAFNIR, true)
        end

        DisallowRespawn(ID.mob.NIDHOGG, false)
        UpdateNMSpawnPoint(ID.mob.NIDHOGG)
        GetMobByID(ID.mob.NIDHOGG):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    else
        if LandKingSystem_NQ ~= 1 then
            UpdateNMSpawnPoint(ID.mob.FAFNIR)
            GetMobByID(ID.mob.FAFNIR):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
            SetServerVariable("[PH]Nidhogg", kills + 1)
        end
    end
end
