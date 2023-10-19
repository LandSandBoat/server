-----------------------------------
-- Common Requires
-----------------------------------
require('modules/module_utils')
-----------------------------------
-- ID Requires
-----------------------------------
local dragonsAeryID   = zones[xi.zone.DRAGONS_AERY]
local valleySorrowsID = zones[xi.zone.VALLEY_OF_SORROWS]
local behemothDomID   = zones[xi.zone.BEHEMOTHS_DOMINION]

-----------------------------------
-- Module definition
-----------------------------------
-- This module attempts to replicate old Land King pop system in an era-accurate way.
-- It comes along a ToD perpetuation/retainment system, for server crashes, since this NMs were usually contested by endgame LSs.
local hnmSystem = Module:new('era_HNM_System')

-----------------------------------
-- Module enable/disable
-----------------------------------
-- Do not use along custom_HNM_System module. Choose one or the other.
hnmSystem:setEnabled(false)

-----------------------------------
-- Dragon's Aery: Fafnir, Nidhogg
-----------------------------------
hnmSystem:addOverride('xi.zones.Dragons_Aery.Zone.onInitialize', function(zone)
    super(zone)

    local hnmPopTime   = GetServerVariable('[HNM]Fafnir')   -- Time the NM will spawn at.
    local hnmKillCount = GetServerVariable('[HNM]Fafnir_C') -- Number of times NQ King has been slain in a row.
    local currentTime  = os.time()

    -- First-time setup.
    if hnmPopTime == 0 then
        hnmPopTime = currentTime + math.random(1, 48) * 1800

        SetServerVariable('[HNM]Fafnir', hnmPopTime) -- Save pop time.
    end

    -- Calculate monster to pop.
    local monster = dragonsAeryID.mob.FAFNIR

    if
        hnmKillCount > 3 and
        (math.random(1, 5) == 3 or hnmKillCount > 6)
    then
        monster = dragonsAeryID.mob.NIDHOGG
    end

    -- Update mob spawn position.
    UpdateNMSpawnPoint(monster)

    -- Spawn mob or set spawn time.
    if hnmPopTime <= currentTime then
        SpawnMob(monster)
    else
        GetMobByID(monster):setRespawnTime(hnmPopTime - currentTime)
    end

    -- Hide ??? NPC.
    GetNPCByID(dragonsAeryID.npc.FAFNIR_QM):setStatus(xi.status.DISAPPEAR)
end)

hnmSystem:addOverride('xi.zones.Dragons_Aery.mobs.Fafnir.onMobDespawn', function(mob)
    super(mob)

    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800
    local hnmKillCount  = GetServerVariable('[HNM]Fafnir_C') + 1

    SetServerVariable('[HNM]Fafnir', os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable('[HNM]Fafnir_C', hnmKillCount)            -- Save kill count.

    -- Mob setup.
    local monster = dragonsAeryID.mob.FAFNIR

    if
        hnmKillCount > 3 and
        (math.random(1, 5) == 3 or hnmKillCount > 6)
    then
        monster = dragonsAeryID.mob.NIDHOGG
    end

    UpdateNMSpawnPoint(monster)
    GetMobByID(monster):setRespawnTime(randomPopTime)
end)

hnmSystem:addOverride('xi.zones.Dragons_Aery.mobs.Nidhogg.onMobDespawn', function(mob)
    super(mob)

    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800

    SetServerVariable('[HNM]Fafnir', os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable('[HNM]Fafnir_C', 0)                       -- Save kill count.

    -- Mob setup.
    UpdateNMSpawnPoint(dragonsAeryID.mob.FAFNIR)
    GetMobByID(dragonsAeryID.mob.FAFNIR):setRespawnTime(randomPopTime)
end)

-----------------------------------
-- Valley of Sorrows: Adamantoise, Aspidochelone
-----------------------------------
hnmSystem:addOverride('xi.zones.Valley_of_Sorrows.Zone.onInitialize', function(zone)
    super(zone)

    local hnmPopTime   = GetServerVariable('[HNM]Adamantoise')   -- Time the NM will spawn at.
    local hnmKillCount = GetServerVariable('[HNM]Adamantoise_C') -- Number of times NQ King has been slain in a row.
    local currentTime  = os.time()

    -- First-time setup.
    if hnmPopTime == 0 then
        hnmPopTime = currentTime + math.random(1, 48) * 1800

        SetServerVariable('[HNM]Adamantoise', hnmPopTime) -- Save pop time.
    end

    -- Calculate monster to pop.
    local monster = valleySorrowsID.mob.ADAMANTOISE

    if
        hnmKillCount > 3 and
        (math.random(1, 5) == 3 or hnmKillCount > 6)
    then
        monster = valleySorrowsID.mob.ASPIDOCHELONE
    end

    -- Update mob spawn position.
    UpdateNMSpawnPoint(monster)

    -- Spawn mob or set spawn time.
    if hnmPopTime <= currentTime then
        SpawnMob(monster)
    else
        GetMobByID(monster):setRespawnTime(hnmPopTime - currentTime)
    end

    -- Hide ??? NPC.
    GetNPCByID(valleySorrowsID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)
end)

hnmSystem:addOverride('xi.zones.Valley_of_Sorrows.mobs.Adamantoise.onMobDespawn', function(mob)
    super(mob)

    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800
    local hnmKillCount  = GetServerVariable('[HNM]Adamantoise_C') + 1

    SetServerVariable('[HNM]Adamantoise', os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable('[HNM]Adamantoise_C', hnmKillCount)            -- Save kill count.

    -- Mob setup.
    local monster = valleySorrowsID.mob.ADAMANTOISE

    if
        hnmKillCount > 3 and
        (math.random(1, 5) == 3 or hnmKillCount > 6)
    then
        monster = valleySorrowsID.mob.ASPIDOCHELONE
    end

    UpdateNMSpawnPoint(monster)
    GetMobByID(monster):setRespawnTime(randomPopTime)
end)

hnmSystem:addOverride('xi.zones.Valley_of_Sorrows.mobs.Aspidochelone.onMobDespawn', function(mob)
    super(mob)

    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800

    SetServerVariable('[HNM]Adamantoise', os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable('[HNM]Adamantoise_C', 0)                       -- Save kill count.

    -- Mob setup.
    UpdateNMSpawnPoint(valleySorrowsID.mob.ADAMANTOISE)
    GetMobByID(valleySorrowsID.mob.ADAMANTOISE):setRespawnTime(randomPopTime)
end)

-----------------------------------
-- Behemoth's Dominion: Behemoth, King Behemoth
-----------------------------------
hnmSystem:addOverride('xi.zones.Behemoths_Dominion.Zone.onInitialize', function(zone)
    super(zone)

    local hnmPopTime   = GetServerVariable('[HNM]Behemoth')   -- Time the NM will spawn at.
    local hnmKillCount = GetServerVariable('[HNM]Behemoth_C') -- Number of times NQ King has been slain in a row.
    local currentTime  = os.time()

    -- First-time setup.
    if hnmPopTime == 0 then
        hnmPopTime = currentTime + math.random(1, 48) * 1800

        SetServerVariable('[HNM]Behemoth', hnmPopTime) -- Save pop time.
    end

    -- Calculate monster to pop.
    local monster = behemothDomID.mob.BEHEMOTH

    if
        hnmKillCount > 3 and
        (math.random(1, 5) == 3 or hnmKillCount > 6)
    then
        monster = behemothDomID.mob.KING_BEHEMOTH
    end

    -- Update mob spawn position.
    UpdateNMSpawnPoint(monster)

    -- Spawn mob or set spawn time.
    if hnmPopTime <= currentTime then
        SpawnMob(monster)
    else
        GetMobByID(monster):setRespawnTime(hnmPopTime - currentTime)
    end

    -- Hide ??? NPC.
    GetNPCByID(behemothDomID.npc.BEHEMOTH_QM):setStatus(xi.status.DISAPPEAR)
end)

hnmSystem:addOverride('xi.zones.Behemoths_Dominion.mobs.Behemoth.onMobDespawn', function(mob)
    super(mob)

    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800
    local hnmKillCount  = GetServerVariable('[HNM]Behemoth_C') + 1

    SetServerVariable('[HNM]Behemoth', os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable('[HNM]Behemoth_C', hnmKillCount)            -- Save kill count.

    -- Mob setup.
    local monster = behemothDomID.mob.BEHEMOTH

    if
        hnmKillCount > 3 and
        (math.random(1, 5) == 3 or hnmKillCount > 6)
    then
        monster = behemothDomID.mob.KING_BEHEMOTH
    end

    UpdateNMSpawnPoint(monster)
    GetMobByID(monster):setRespawnTime(randomPopTime)
end)

hnmSystem:addOverride('xi.zones.Behemoths_Dominion.mobs.King_Behemoth.onMobDespawn', function(mob)
    super(mob)

    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800

    SetServerVariable('[HNM]Behemoth', os.time() + randomPopTime) -- Save next pop time.
    SetServerVariable('[HNM]Behemoth_C', 0)                       -- Save kill count.

    -- Mob setup.
    UpdateNMSpawnPoint(behemothDomID.mob.BEHEMOTH)
    GetMobByID(behemothDomID.mob.BEHEMOTH):setRespawnTime(randomPopTime)
end)

return hnmSystem
