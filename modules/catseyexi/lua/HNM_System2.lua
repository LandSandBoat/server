-----------------------------------
-- Common Requires
-----------------------------------
require("modules/module_utils")
require("scripts/globals/conquest")
require("scripts/globals/helm")
require("scripts/globals/titles")
require("scripts/globals/treasure")
require("scripts/globals/zone")
require("scripts/missions/amk/helpers")

-----------------------------------
-- ID Requires
-----------------------------------
local dragonsAeryID    = require("scripts/zones/Dragons_Aery/IDs")
local valleySorrowsID  = require("scripts/zones/Valley_of_Sorrows/IDs")
local behemothDomID    = require("scripts/zones/Behemoths_Dominion/IDs")
local jugnerForestID   = require("scripts/zones/Jugner_Forest/IDs")
local monasticCavernID = require("scripts/zones/Monastic_Cavern/IDs")
local qulunDomeID      = require("scripts/zones/Qulun_Dome/IDs")
local castleOztrojaID  = require("scripts/zones/Castle_Oztroja/IDs")

local oztrojaGlobal    = require("scripts/zones/Castle_Oztroja/globals")

-----------------------------------
-- Module definition
-----------------------------------
local hnmSystem = Module:new("HNM_System")

----------------------------------------------------------------------------------------------------
-- Dragon's Aery: Fafnir, Nidhogg
----------------------------------------------------------------------------------------------------

hnmSystem:addOverride("xi.zones.Dragons_Aery.Zone.onInitialize", function(zone)
    local hnmPopTime = GetServerVariable("[HNM]Fafnir") -- Time the NM will spawn at.

    -- Fallback in case of DB corruption or other fancy stuff.
    if hnmPopTime == 0 then
        hnmPopTime = os.time() + math.random(1, 48) * 1800

        SetServerVariable("[HNM]Fafnir", hnmPopTime) -- Save pop time.
    end

    UpdateNMSpawnPoint(dragonsAeryID.mob.FAFNIR)

    -- Spawn mob.
    if hnmPopTime <= os.time() then
        SpawnMob(dragonsAeryID.mob.FAFNIR)

    -- Set spawn time.
    else
        GetMobByID(dragonsAeryID.mob.FAFNIR):setRespawnTime(hnmPopTime - os.time()) 
    end

    -- Regular operations.
    zone:registerRegion(1, -61.164, -1.725, -33.673, -55.521, -1.332, -18.122)
    GetNPCByID(dragonsAeryID.npc.FAFNIR_QM):setStatus(xi.status.DISAPPEAR)
end)

hnmSystem:addOverride("xi.zones.Dragons_Aery.mobs.Fafnir.onMobDespawn", function(mob)
    -- Server Variable work.
    local deathCount = GetServerVariable("[HNM]Fafnir_C")
    local random     = 75600 + math.random(0, 6) * 1800

    SetServerVariable("[HNM]Fafnir", os.time() + random) -- Save next pop time.
    SetServerVariable("[HNM]Fafnir_C", deathCount + 1)   -- Save kill count.

    -- Set NQ respawn Time.
    GetMobByID(dragonsAeryID.mob.FAFNIR):setRespawnTime(random)

    -- HQ check.
    if deathCount >= 3 then
        local chance = 10 + (deathCount - 3) * 15

        if math.random(1,100) <= chance then
            SpawnMob(dragonsAeryID.mob.NIDHOGG)
        end
    end
end)

hnmSystem:addOverride("xi.zones.Dragons_Aery.mobs.Nidhogg.onMobDespawn", function(mob)
    -- Server Variable work.
    SetServerVariable("[HNM]Fafnir_C", 0)
end)

----------------------------------------------------------------------------------------------------
-- Valley of Sorrows: Adamantoise, Aspidochelone
----------------------------------------------------------------------------------------------------

hnmSystem:addOverride("xi.zones.Valley_of_Sorrows.Zone.onInitialize", function(zone)
    local hnmPopTime = GetServerVariable("[HNM]Adamantoise") -- Time the NM will spawn at.

    -- Fallback in case of DB corruption or other fancy stuff. This var should never be 0 after the first time.
    if hnmPopTime == 0 then
        hnmPopTime = os.time() + math.random(1, 48) * 1800

        SetServerVariable("[HNM]Adamantoise", hnmPopTime) -- Save pop time.
    end

    UpdateNMSpawnPoint(valleySorrowsID.mob.ADAMANTOISE)

    -- Spawn mob.
    if hnmPopTime <= os.time() then
        SpawnMob(valleySorrowsID.mob.ADAMANTOISE)

    -- Set spawn time.
    else
        GetMobByID(valleySorrowsID.mob.ADAMANTOISE):setRespawnTime(hnmPopTime - os.time()) 
    end

    -- Regular operations.
    GetNPCByID(valleySorrowsID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)
end)

hnmSystem:addOverride("xi.zones.Valley_of_Sorrows.mobs.Adamantoise.onMobDespawn", function(mob)
    -- Server Variable work.
    local deathCount = GetServerVariable("[HNM]Adamantoise_C")
    local random     = 75600 + math.random(0, 6) * 1800

    SetServerVariable("[HNM]Adamantoise", os.time() + random) -- Save next pop time.
    SetServerVariable("[HNM]Adamantoise_C", deathCount + 1)   -- Save kill count.

    -- Set NQ respawn Time.
    GetMobByID(valleySorrowsID.mob.ADAMANTOISE):setRespawnTime(75600 + random * 1800)

    -- HQ check.
    if deathCount >= 3 then
        local chance = 10 + (deathCount - 3) * 15

        if math.random(1,100) <= chance then
            SpawnMob(valleySorrowsID.mob.ASPIDOCHELONE)
        end
    end
end)

hnmSystem:addOverride("xi.zones.Valley_of_Sorrows.mobs.Aspidochelone.onMobDespawn", function(mob)
    -- Server Variable work.
    SetServerVariable("[HNM]Adamantoise_C", 0)
end)

----------------------------------------------------------------------------------------------------
-- Behemoth's Dominion: Behemoth, King Behemoth
----------------------------------------------------------------------------------------------------

hnmSystem:addOverride("xi.zones.Behemoths_Dominion.Zone.onInitialize", function(zone)
    local hnmPopTime = GetServerVariable("[HNM]Behemoth") -- Time the NM will spawn at.

    -- Fallback in case of DB corruption or other fancy stuff. This var should never be 0 after the first time.
    if hnmPopTime == 0 then
        hnmPopTime = os.time() + math.random(1, 48) * 1800

        SetServerVariable("[HNM]Behemoth", hnmPopTime) -- Save pop time.
    end

    UpdateNMSpawnPoint(behemothDomID.mob.BEHEMOTH)

    -- Spawn mob.
    if hnmPopTime <= os.time() then
        SpawnMob(behemothDomID.mob.BEHEMOTH)

    -- Set spawn time.
    else
        GetMobByID(behemothDomID.mob.BEHEMOTH):setRespawnTime(hnmPopTime - os.time()) 
    end

    -- Regular operations.
    GetNPCByID(behemothDomID.npc.BEHEMOTH_QM):setStatus(xi.status.DISAPPEAR)
end)

hnmSystem:addOverride("xi.zones.Behemoths_Dominion.mobs.Behemoth.onMobDespawn", function(mob)
    -- Server Variable work.
    local deathCount = GetServerVariable("[HNM]Behemoth_C")
    local random     = 75600 + math.random(0, 6) * 1800

    SetServerVariable("[HNM]Behemoth", os.time() + random) -- Save next pop time.
    SetServerVariable("[HNM]Behemoth_C", deathCount + 1)   -- Save kill count.

    -- Set NQ respawn Time.
    GetMobByID(behemothDomID.mob.BEHEMOTH):setRespawnTime(75600 + random * 1800)

    -- HQ check.
    if deathCount >= 3 then
        local chance = 10 + (deathCount - 3) * 15

        if math.random(1,100) <= chance then
            SpawnMob(behemothDomID.mob.KING_BEHEMOTH)
        end
    end
end)

hnmSystem:addOverride("xi.zones.Behemoths_Dominion.mobs.King_Behemoth.onMobDespawn", function(mob)
    -- Server Variable work.
    SetServerVariable("[HNM]Behemoth_C", 0)
end)

----------------------------------------------------------------------------------------------------
-- Jugner Forest: King Arthro, Kight Crabs
----------------------------------------------------------------------------------------------------

hnmSystem:addOverride("xi.zones.Jugner_Forest.Zone.onInitialize", function(zone)
    local hnmPopTime = GetServerVariable("[HNM]KA") -- Time the NM will spawn at.

    -- Fallback in case of DB corruption or other fancy stuff. This var should never be 0 after the first time.
    if hnmPopTime == 0 then
        hnmPopTime = os.time() + math.random(1, 48) * 1800

        SetServerVariable("[HNM]KA", hnmPopTime) -- Save pop time.
    end

    -- Spawn mob.
    if hnmPopTime <= os.time() then
        for offset = 1, 10 do
            SpawnMob(jugnerForestID.mob.KING_ARTHRO - offset)
        end

    -- Set spawn time.
    else
        for offset = 1, 10 do
            GetMobByID(jugnerForestID.mob.KING_ARTHRO - offset):setRespawnTime(hnmPopTime - os.time())
        end
    end

    -- Regular operations.
    zone:registerRegion(1, -484, 10, 292, 0, 0, 0)

    UpdateNMSpawnPoint(jugnerForestID.mob.FRAELISSA)
    GetMobByID(jugnerForestID.mob.FRAELISSA):setRespawnTime(math.random(900, 10800))

    xi.voidwalker.zoneOnInit(zone)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.helm.initZone(zone, xi.helm.type.LOGGING)
end)

hnmSystem:addOverride("xi.zones.Jugner_Forest.mobs.Knight_Crab.onMobDespawn", function(mob)
    -- Mob work.
    local kingArthro = GetMobByID(jugnerForestID.mob.KING_ARTHRO)

    kingArthro:setLocalVar("[POP]King_Arthro", kingArthro:getLocalVar("[POP]King_Arthro") + 1)

    -- Pop King Arthro.
    if kingArthro:getLocalVar("[POP]King_Arthro") == 10 then
        kingArthro:setLocalVar("[POP]King_Arthro", 0)
        UpdateNMSpawnPoint(jugnerForestID.mob.KING_ARTHRO)
        SpawnMob(jugnerForestID.mob.KING_ARTHRO)
    end
end)

hnmSystem:addOverride("xi.zones.Jugner_Forest.mobs.King_Arthro.onMobDespawn", function(mob)
    -- Mob work.
    local kingArthroID = mob:getID()

    GetMobByID(kingArthroID):setLocalVar("[POP]King_Arthro", 0)

    -- Server Variable work.
    local random = 75900 + math.random(0, 6) * 1800

    SetServerVariable("[HNM]KA", os.time() + random) -- Save next pop time.

    -- Set respawn Time.
    for offset = 1, 10 do
        GetMobByID(kingArthroID - offset):setRespawnTime(random)
    end
end)

----------------------------------------------------------------------------------------------------
-- Monastic Cavern: Orcish Overlord, Overlord Bakgodek
----------------------------------------------------------------------------------------------------

hnmSystem:addOverride("xi.zones.Monastic_Cavern.Zone.onInitialize", function(zone)
    local hnmPopTime = GetServerVariable("[HNM]Overlord") -- Time the NM will spawn at.

    -- Fallback in case of DB corruption or other fancy stuff. This var should never be 0 after the first time.
    if hnmPopTime == 0 then
        hnmPopTime = os.time() + math.random(1, 48) * 1800

        SetServerVariable("[HNM]Overlord", hnmPopTime) -- Set a pop time.
    end

    UpdateNMSpawnPoint(monasticCavernID.mob.ORCISH_OVERLORD)

    -- Spawn mob.
    if hnmPopTime <= os.time() then
        SpawnMob(monasticCavernID.mob.ORCISH_OVERLORD)

    -- Set spawn time.
    else
        GetMobByID(monasticCavernID.mob.ORCISH_OVERLORD):setRespawnTime(hnmPopTime - os.time()) 
    end

    -- Regular operations.
    xi.treasure.initZone(zone)
end)

hnmSystem:addOverride("xi.zones.Monastic_Cavern.mobs.Orcish_Overlord.onMobDespawn", function(mob)
    local placeholderID = mob:getID()

    -- The quest version of this NM doesn't respawn or count toward hq nm.
    if placeholderID == monasticCavernID.mob.ORCISH_OVERLORD then
        -- Server Variable work.
        local deathCount = GetServerVariable("[HNM]Overlord_C")
        local random     = 75600 + math.random(0, 6) * 1800

        SetServerVariable("[HNM]Overlord", os.time() + random) -- Save next pop time.
        SetServerVariable("[HNM]Overlord_C", deathCount + 1)   -- Save kill count.

        -- Set NQ respawn Time.
        GetMobByID(monasticCavernID.mob.ORCISH_OVERLORD):setRespawnTime(random) -- Set next pop time.

        -- HQ check.
        if deathCount >= 3 then
            local chance = 10 + (deathCount - 3) * 15

            if math.random(1,100) <= chance then
                SpawnMob(monasticCavernID.mob.ORCISH_OVERLORD + 1)
            end
        end
    end
end)

hnmSystem:addOverride("xi.zones.Monastic_Cavern.mobs.Overlord_Bakgodek.onMobDespawn", function(mob)
    -- Server Variable work.
    SetServerVariable("[HNM]Overlord_C", 0)
end)

----------------------------------------------------------------------------------------------------
-- Qulun Dome: Diamond Quadav, Za'Dha Adamantking
----------------------------------------------------------------------------------------------------

hnmSystem:addOverride("xi.zones.Qulun_Dome.Zone.onInitialize", function(zone)
    local hnmPopTime = GetServerVariable("[HNM]Diamond") -- Time the NM will spawn at.

    -- Fallback in case of DB corruption or other fancy stuff. This var should never be 0 after the first time.
    if hnmPopTime == 0 then
        hnmPopTime = os.time() + math.random(1, 48) * 1800

        SetServerVariable("[HNM]Diamond", hnmPopTime) -- Set a pop time.
    end

    UpdateNMSpawnPoint(qulunDomeID.mob.DIAMOND_QUADAV)

    -- Spawn mob.
    if hnmPopTime <= os.time() then
        SpawnMob(qulunDomeID.mob.DIAMOND_QUADAV)

    -- Set spawn time.
    else
        GetMobByID(qulunDomeID.mob.DIAMOND_QUADAV):setRespawnTime(hnmPopTime - os.time()) 
    end
end)

hnmSystem:addOverride("xi.zones.Qulun_Dome.mobs.Diamond_Quadav.onMobDespawn", function(mob)
    local placeholderID = mob:getID()

    -- The quest version of this NM doesn't respawn or count toward hq nm.
    if placeholderID == qulunDomeID.mob.DIAMOND_QUADAV then
        -- Server Variable work.
        local deathCount = GetServerVariable("[HNM]Diamond_C")
        local random     = 75600 + math.random(0, 6) * 1800

        SetServerVariable("[HNM]Diamond", os.time() + random) -- Save next pop time.
        SetServerVariable("[HNM]Diamond_C", deathCount + 1)   -- Save kill count.

        -- Set NQ respawn Time.
        GetMobByID(qulunDomeID.mob.DIAMOND_QUADAV):setRespawnTime(random) -- Set next pop time.

        -- HQ Check.
        if deathCount >= 3 then
            local chance = 10 + (deathCount - 3) * 15

            if math.random(1,100) <= chance then
                SpawnMob(qulunDomeID.mob.DIAMOND_QUADAV + 1)
            end
        end
    end
end)

hnmSystem:addOverride("xi.zones.Qulun_Dome.mobs.ZaDha_Adamantking.onMobDespawn", function(mob)
    -- Server Variable work.
    SetServerVariable("[HNM]Diamond_C", 0)
end)

----------------------------------------------------------------------------------------------------
-- Castle Oztroja: Yagudo Avatar, Tzee Xicu the Manifest
----------------------------------------------------------------------------------------------------

hnmSystem:addOverride("xi.zones.Castle_Oztroja.Zone.onInitialize", function(zone)
    local hnmPopTime = GetServerVariable("[HNM]Avatar") -- Time the NM will spawn at.

    -- Fallback in case of DB corruption or other fancy stuff. This var should never be 0 after the first time.
    if hnmPopTime == 0 then
        hnmPopTime = os.time() + math.random(1, 48) * 1800

        SetServerVariable("[HNM]Avatar", hnmPopTime) -- Set a pop time.
    end

    UpdateNMSpawnPoint(castleOztrojaID.mob.YAGUDO_AVATAR)

    -- Spawn mob.
    if hnmPopTime <= os.time() then
        SpawnMob(castleOztrojaID.mob.YAGUDO_AVATAR)

    -- Set spawn time.
    else
        GetMobByID(castleOztrojaID.mob.YAGUDO_AVATAR):setRespawnTime(hnmPopTime - os.time()) 
    end

    -- Regular operations
    oztrojaGlobal.pickNewCombo()    -- Update floor 2 brass door combination.
    oztrojaGlobal.pickNewPassword() -- Update floor 4 trap door password.

    xi.treasure.initZone(zone)
end)

hnmSystem:addOverride("xi.zones.Castle_Oztroja.mobs.Yagudo_Avatar.onMobDespawn", function(mob)
    local placeholderID = mob:getID()

    -- The quest version of this NM doesn't respawn or count toward hq nm.
    if placeholderID == castleOztrojaID.mob.YAGUDO_AVATAR then
        -- Server Variable work.
        local deathCount = GetServerVariable("[HNM]Avatar_C")
        local random     = 75600 + math.random(0, 6) * 1800

        SetServerVariable("[HNM]Avatar", os.time() + random) -- Save next pop time.
        SetServerVariable("[HNM]Avatar_C", deathCount + 1)   -- Save kill count.

        -- Set NQ respawn Time.
        GetMobByID(castleOztrojaID.mob.YAGUDO_AVATAR):setRespawnTime(random) -- Set next pop time.

        -- HQ Check.
        if deathCount >= 3 then
            local chance = 10 + (deathCount - 3) * 15

            if math.random(1,100) <= chance then
                SpawnMob(castleOztrojaID.mob.YAGUDO_AVATAR + 3)
            end
        end
    end
end)

hnmSystem:addOverride("xi.zones.Castle_Oztroja.mobs.Tzee_Xicu_the_Manifest.onMobDespawn", function(mob)
    -- Server Variable work.
    SetServerVariable("[HNM]Avatar_C", 0)
end)

return hnmSystem
