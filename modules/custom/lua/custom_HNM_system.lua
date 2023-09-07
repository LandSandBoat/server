-----------------------------------
-- Common Requires
-----------------------------------
require('modules/module_utils')
require('scripts/globals/npc_util')
-----------------------------------
-- ID Requires
-----------------------------------
local dragonsAeryID   = zones[xi.zone.DRAGONS_AERY]
local valleySorrowsID = zones[xi.zone.VALLEY_OF_SORROWS]
local behemothDomID   = zones[xi.zone.BEHEMOTHS_DOMINION]

-----------------------------------
-- Module definition
-----------------------------------
-- This module attempts to mix both era and retail styles for Land Kings.
-- It allows NQ Kings to retain their era timed rotation while allowing HQ Kings to be poped from their QMs. For Uncle Teo.
-- It comes along a ToD perpetuation/retainment system, for server crashes, since this NMs were usually contested by endgame LSs.
local hnmSystem = Module:new('custom_HNM_System')

-----------------------------------
-- Module enable/disable
-----------------------------------
-- Do not use along era_HNM_System module. Choose one or the other.
hnmSystem:setEnabled(false)

-----------------------------------
-- Dragon's Aery: Fafnir, Nidhogg
-----------------------------------
hnmSystem:addOverride('xi.zones.Dragons_Aery.Zone.onInitialize', function(zone)
    super(zone)

    local hnmPopTime  = GetServerVariable('[HNM]Fafnir')   -- Time the NM will spawn at.
    local currentTime = os.time()

    -- First-time setup.
    if hnmPopTime == 0 then
        hnmPopTime = currentTime + math.random(1, 48) * 1800

        SetServerVariable('[HNM]Fafnir', hnmPopTime) -- Save pop time.
    end

    UpdateNMSpawnPoint(dragonsAeryID.mob.FAFNIR)

    -- Spawn mob or set spawn time.
    if hnmPopTime <= currentTime then
        SpawnMob(dragonsAeryID.mob.FAFNIR)
    else
        GetMobByID(dragonsAeryID.mob.FAFNIR):setRespawnTime(hnmPopTime - currentTime)
    end
end)

hnmSystem:addOverride('xi.zones.Dragons_Aery.mobs.Fafnir.onMobDespawn', function(mob)
    super(mob)

    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800

    SetServerVariable('[HNM]Fafnir', os.time() + randomPopTime) -- Save next pop time.

    -- Set spawn time and position.
    GetMobByID(dragonsAeryID.mob.FAFNIR):setRespawnTime(randomPopTime)
    UpdateNMSpawnPoint(dragonsAeryID.mob.FAFNIR)
end)

hnmSystem:addOverride('xi.zones.Dragons_Aery.npcs.qm0.onTrade', function(player, npc, trade)
    if
        not GetMobByID(dragonsAeryID.mob.FAFNIR):isSpawned() and
        not GetMobByID(dragonsAeryID.mob.NIDHOGG):isSpawned() and
        npcUtil.tradeHasExactly(trade, xi.item.SWEET_TEA) and
        npcUtil.popFromQM(player, npc, dragonsAeryID.mob.NIDHOGG)
    then
        player:confirmTrade()
    end
end)

-----------------------------------
-- Valley of Sorrows: Adamantoise, Aspidochelone
-----------------------------------
hnmSystem:addOverride('xi.zones.Valley_of_Sorrows.Zone.onInitialize', function(zone)
    super(zone)

    local hnmPopTime  = GetServerVariable('[HNM]Adamantoise')   -- Time the NM will spawn at.
    local currentTime = os.time()

    -- First-time setup.
    if hnmPopTime == 0 then
        hnmPopTime = currentTime + math.random(1, 48) * 1800

        SetServerVariable('[HNM]Adamantoise', hnmPopTime) -- Save pop time.
    end

    UpdateNMSpawnPoint(valleySorrowsID.mob.ADAMANTOISE)

    -- Spawn mob or set spawn time.
    if hnmPopTime <= currentTime then
        SpawnMob(valleySorrowsID.mob.ADAMANTOISE)
    else
        GetMobByID(valleySorrowsID.mob.ADAMANTOISE):setRespawnTime(hnmPopTime - currentTime)
    end
end)

hnmSystem:addOverride('xi.zones.Valley_of_Sorrows.mobs.Adamantoise.onMobDespawn', function(mob)
    super(mob)

    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800

    SetServerVariable('[HNM]Adamantoise', os.time() + randomPopTime) -- Save next pop time.

    -- Set spawn time and position.
    GetMobByID(valleySorrowsID.mob.ADAMANTOISE):setRespawnTime(randomPopTime)
    UpdateNMSpawnPoint(valleySorrowsID.mob.ADAMANTOISE)
end)

hnmSystem:addOverride('xi.zones.Valley_of_Sorrows.npcs.qm1.onTrade', function(player, npc, trade)
    if
        not GetMobByID(valleySorrowsID.mob.ADAMANTOISE):isSpawned() and
        not GetMobByID(valleySorrowsID.mob.ASPIDOCHELONE):isSpawned() and
        npcUtil.tradeHasExactly(trade, xi.item.RED_PONDWEED) and
        npcUtil.popFromQM(player, npc, valleySorrowsID.mob.ASPIDOCHELONE)
    then
        player:confirmTrade()
    end
end)

-----------------------------------
-- Behemoth's Dominion: Behemoth, King Behemoth
-----------------------------------
hnmSystem:addOverride('xi.zones.Behemoths_Dominion.Zone.onInitialize', function(zone)
    super(zone)

    local hnmPopTime  = GetServerVariable('[HNM]Behemoth')   -- Time the NM will spawn at.
    local currentTime = os.time()

    -- First-time setup.
    if hnmPopTime == 0 then
        hnmPopTime = currentTime + math.random(1, 48) * 1800

        SetServerVariable('[HNM]Behemoth', hnmPopTime) -- Save pop time.
    end

    UpdateNMSpawnPoint(behemothDomID.mob.BEHEMOTH)

    -- Spawn mob or set spawn time.
    if hnmPopTime <= currentTime then
        SpawnMob(behemothDomID.mob.BEHEMOTH)
    else
        GetMobByID(behemothDomID.mob.BEHEMOTH):setRespawnTime(hnmPopTime - currentTime)
    end
end)

hnmSystem:addOverride('xi.zones.Behemoths_Dominion.mobs.Behemoth.onMobDespawn', function(mob)
    super(mob)

    -- Server Variable work.
    local randomPopTime = 75600 + math.random(0, 6) * 1800

    SetServerVariable('[HNM]Behemoth', os.time() + randomPopTime) -- Save next pop time.

    -- Set spawn time and position.
    GetMobByID(behemothDomID.mob.BEHEMOTH):setRespawnTime(randomPopTime)
    UpdateNMSpawnPoint(behemothDomID.mob.BEHEMOTH)
end)

hnmSystem:addOverride('xi.zones.Behemoths_Dominion.npcs.qm2.onTrade', function(player, npc, trade)
    if
        not GetMobByID(behemothDomID.mob.BEHEMOTH):isSpawned() and
        not GetMobByID(behemothDomID.mob.KING_BEHEMOTH):isSpawned() and
        npcUtil.tradeHasExactly(trade, xi.item.SAVORY_SHANK) and
        npcUtil.popFromQM(player, npc, behemothDomID.mob.KING_BEHEMOTH)
    then
        player:confirmTrade()
    end
end)

return hnmSystem
