-----------------------------------
-- Common Requires
-----------------------------------
require("modules/module_utils")
require("scripts/globals/conquest")
require("scripts/globals/zone")

-----------------------------------
-- ID Requires
-----------------------------------
local dragonsAeryID   = require("scripts/zones/Dragons_Aery/IDs")
local valleySorrowsID = require("scripts/zones/Valley_of_Sorrows/IDs")
local behemothDomID   = require("scripts/zones/Behemoths_Dominion/IDs")

-----------------------------------
-- Module definition
-----------------------------------
local hnmSystem = Module:new("era_HNM_System")

-- NOTE: This module attempts to replicate old Land King pop system in an era-accurate way.
-- It comes along a ToD perpetuation/retainment system, for server crashes, since this NMs were usually contested by endgame LSs.
-- Do not use along custom_HNM_System module. Choose one or the other.

----------------------------------------------------------------------------------------------------
-- Dragon's Aery: Fafnir, Nidhogg
----------------------------------------------------------------------------------------------------

hnmSystem:addOverride("xi.zones.Dragons_Aery.Zone.onInitialize", function(zone)
    local hnmPopTime   = GetServerVariable("[HNM]Fafnir")   -- Time the NM will spawn at.
    local hnmKillCount = GetServerVariable("[HNM]Fafnir_C") -- Number of times NQ King has been slain in a row.

    -- First-time setup.
    if hnmPopTime == 0 then
        hnmPopTime = os.time() + math.random(1, 48) * 1800

        SetServerVariable("[HNM]Fafnir", hnmPopTime) -- Save pop time.
    end

    -- HQ King.
    if hnmKillCount > 3 and (math.random(1, 5) == 3 or hnmKillCount > 6) then
        UpdateNMSpawnPoint(dragonsAeryID.mob.NIDHOGG)

        -- Spawn mob or set spawn time.
        if hnmPopTime <= os.time() then
            SpawnMob(dragonsAeryID.mob.NIDHOGG)
        else
            GetMobByID(dragonsAeryID.mob.NIDHOGG):setRespawnTime(hnmPopTime - os.time())
        end

    -- NQ King.
    else
        UpdateNMSpawnPoint(dragonsAeryID.mob.FAFNIR)

        -- Spawn mob or set spawn time.
        if hnmPopTime <= os.time() then
            SpawnMob(dragonsAeryID.mob.FAFNIR)
        else
            GetMobByID(dragonsAeryID.mob.FAFNIR):setRespawnTime(hnmPopTime - os.time())
        end
    end

    -- Hide ??? NPC.
    GetNPCByID(dragonsAeryID.npc.FAFNIR_QM):setStatus(xi.status.DISAPPEAR)
end)

hnmSystem:addOverride("xi.zones.Dragons_Aery.mobs.Fafnir.onMobDespawn", function(mob)
    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800
    local hnmKillCount  = GetServerVariable("[HNM]Fafnir_C") + 1

    SetServerVariable("[HNM]Fafnir", os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable("[HNM]Fafnir_C", hnmKillCount)            -- Save kill count.

    -- HQ King.
    if hnmKillCount > 3 and (math.random(1, 5) == 3 or hnmKillCount > 6) then
        UpdateNMSpawnPoint(dragonsAeryID.mob.NIDHOGG)

        -- Set spawn time.
        GetMobByID(dragonsAeryID.mob.NIDHOGG):setRespawnTime(randomPopTime)

    -- NQ King.
    else
        UpdateNMSpawnPoint(dragonsAeryID.mob.FAFNIR)

        -- Set spawn time.
        GetMobByID(dragonsAeryID.mob.FAFNIR):setRespawnTime(randomPopTime)
    end
end)

hnmSystem:addOverride("xi.zones.Dragons_Aery.mobs.Nidhogg.onMobDespawn", function(mob)
    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800

    SetServerVariable("[HNM]Fafnir", os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable("[HNM]Fafnir_C", 0)                       -- Save kill count.

    -- Setup NQ King.
    UpdateNMSpawnPoint(dragonsAeryID.mob.FAFNIR)

    -- Set spawn time.
    GetMobByID(dragonsAeryID.mob.FAFNIR):setRespawnTime(randomPopTime)
end)

----------------------------------------------------------------------------------------------------
-- Valley of Sorrows: Adamantoise, Aspidochelone
----------------------------------------------------------------------------------------------------

hnmSystem:addOverride("xi.zones.Valley_of_Sorrows.Zone.onInitialize", function(zone)
    local hnmPopTime   = GetServerVariable("[HNM]Adamantoise")   -- Time the NM will spawn at.
    local hnmKillCount = GetServerVariable("[HNM]Adamantoise_C") -- Number of times NQ King has been slain in a row.

    -- First-time setup.
    if hnmPopTime == 0 then
        hnmPopTime = os.time() + math.random(1, 48) * 1800

        SetServerVariable("[HNM]Adamantoise", hnmPopTime) -- Save pop time.
    end

    -- HQ King.
    if hnmKillCount > 3 and (math.random(1, 5) == 3 or hnmKillCount > 6) then
        UpdateNMSpawnPoint(valleySorrowsID.mob.ASPIDOCHELONE)

        -- Spawn mob or set spawn time.
        if hnmPopTime <= os.time() then
            SpawnMob(valleySorrowsID.mob.ASPIDOCHELONE)
        else
            GetMobByID(valleySorrowsID.mob.ASPIDOCHELONE):setRespawnTime(hnmPopTime - os.time())
        end

    -- NQ King.
    else
        UpdateNMSpawnPoint(valleySorrowsID.mob.ADAMANTOISE)

        -- Spawn mob or set spawn time.
        if hnmPopTime <= os.time() then
            SpawnMob(valleySorrowsID.mob.ADAMANTOISE)
        else
            GetMobByID(valleySorrowsID.mob.ADAMANTOISE):setRespawnTime(hnmPopTime - os.time())
        end
    end

    -- Hide ??? NPC.
    GetNPCByID(valleySorrowsID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)
end)

hnmSystem:addOverride("xi.zones.Valley_of_Sorrows.mobs.Adamantoise.onMobDespawn", function(mob)
    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800
    local hnmKillCount  = GetServerVariable("[HNM]Adamantoise_C") + 1

    SetServerVariable("[HNM]Adamantoise", os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable("[HNM]Adamantoise_C", hnmKillCount)            -- Save kill count.

    -- HQ King.
    if hnmKillCount > 3 and (math.random(1, 5) == 3 or hnmKillCount > 6) then
        UpdateNMSpawnPoint(valleySorrowsID.mob.ASPIDOCHELONE)

        -- Set spawn time.
        GetMobByID(valleySorrowsID.mob.ASPIDOCHELONE):setRespawnTime(randomPopTime)

    -- NQ King.
    else
        UpdateNMSpawnPoint(valleySorrowsID.mob.ADAMANTOISE)

        -- Set spawn time.
        GetMobByID(valleySorrowsID.mob.ADAMANTOISE):setRespawnTime(randomPopTime)
    end
end)

hnmSystem:addOverride("xi.zones.Valley_of_Sorrows.mobs.Aspidochelone.onMobDespawn", function(mob)
    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800

    SetServerVariable("[HNM]Adamantoise", os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable("[HNM]Adamantoise_C", 0)                       -- Save kill count.

    -- Setup NQ King.
    UpdateNMSpawnPoint(valleySorrowsID.mob.ADAMANTOISE)

    -- Set spawn time.
    GetMobByID(valleySorrowsID.mob.ADAMANTOISE):setRespawnTime(randomPopTime)
end)

----------------------------------------------------------------------------------------------------
-- Behemoth's Dominion: Behemoth, King Behemoth
----------------------------------------------------------------------------------------------------

hnmSystem:addOverride("xi.zones.Behemoths_Dominion.Zone.onInitialize", function(zone)
    local hnmPopTime   = GetServerVariable("[HNM]Behemoth")   -- Time the NM will spawn at.
    local hnmKillCount = GetServerVariable("[HNM]Behemoth_C") -- Number of times NQ King has been slain in a row.

    -- First-time setup.
    if hnmPopTime == 0 then
        hnmPopTime = os.time() + math.random(1, 48) * 1800

        SetServerVariable("[HNM]Behemoth", hnmPopTime) -- Save pop time.
    end

    -- HQ King.
    if hnmKillCount > 3 and (math.random(1, 5) == 3 or hnmKillCount > 6) then
        UpdateNMSpawnPoint(behemothDomID.mob.KING_BEHEMOTH)

        -- Spawn mob or set spawn time.
        if hnmPopTime <= os.time() then
            SpawnMob(behemothDomID.mob.KING_BEHEMOTH)
        else
            GetMobByID(behemothDomID.mob.KING_BEHEMOTH):setRespawnTime(hnmPopTime - os.time())
        end

    -- NQ King.
    else
        UpdateNMSpawnPoint(behemothDomID.mob.BEHEMOTH)

        -- Spawn mob or set spawn time.
        if hnmPopTime <= os.time() then
            SpawnMob(behemothDomID.mob.BEHEMOTH)
        else
            GetMobByID(behemothDomID.mob.BEHEMOTH):setRespawnTime(hnmPopTime - os.time())
        end
    end

    -- Hide ??? NPC.
    GetNPCByID(behemothDomID.npc.BEHEMOTH_QM):setStatus(xi.status.DISAPPEAR)
end)

hnmSystem:addOverride("xi.zones.Behemoths_Dominion.mobs.Behemoth.onMobDespawn", function(mob)
    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800
    local hnmKillCount  = GetServerVariable("[HNM]Behemoth_C") + 1

    SetServerVariable("[HNM]Behemoth", os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable("[HNM]Behemoth_C", hnmKillCount)            -- Save kill count.

    -- HQ King.
    if hnmKillCount > 3 and (math.random(1, 5) == 3 or hnmKillCount > 6) then
        UpdateNMSpawnPoint(behemothDomID.mob.KING_BEHEMOTH)

        -- Set spawn time.
        GetMobByID(behemothDomID.mob.KING_BEHEMOTH):setRespawnTime(randomPopTime)

    -- NQ King.
    else
        UpdateNMSpawnPoint(behemothDomID.mob.BEHEMOTH)

        -- Set spawn time.
        GetMobByID(behemothDomID.mob.BEHEMOTH):setRespawnTime(randomPopTime)
    end
end)

hnmSystem:addOverride("xi.zones.Behemoths_Dominion.mobs.King_Behemoth.onMobDespawn", function(mob)
    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800

    SetServerVariable("[HNM]Behemoth", os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable("[HNM]Behemoth_C", 0)                       -- Save kill count.

    -- Setup NQ King.
    UpdateNMSpawnPoint(behemothDomID.mob.BEHEMOTH)

    -- Set spawn time.
    GetMobByID(behemothDomID.mob.BEHEMOTH):setRespawnTime(randomPopTime)
end)

return hnmSystem
