-----------------------------------
-- Area: Apollyon
-- NPC:  Armoury Crate
-----------------------------------

require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/limbus")
-----------------------------------

local loot =
{
    --  SE_Apollyon floor 1
    [110] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1939, droprate = 350},
            {itemid = 1941, droprate = 278},
            {itemid = 1959, droprate = 174},
            {itemid = 1949, droprate = 200},
        },
        {
            {itemid = 1945, droprate = 47},
            {itemid = 1951, droprate = 49},
            {itemid = 1955, droprate = 200},
            {itemid = 2659, droprate = 62},
            {itemid = 2715, droprate = 407},
        },
    },
    -- SE_Apollyon floor 2
    [111] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1959, droprate = 47},
            {itemid = 1949, droprate = 30},
            {itemid = 1943, droprate = 200},
            {itemid = 1947, droprate = 460},
            {itemid = 2661, droprate = 400},
        },
        {
            {itemid = 1951, droprate = 20},
            {itemid = 1955, droprate = 80},
            {itemid = 1945, droprate = 90},
            {itemid = 2659, droprate = 100},
            {itemid = 2715, droprate = 120},
        },
    },
    -- SE_Apollyon floor 3
    [112] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1955, droprate = 59},
            {itemid = 1959, droprate = 139},
            {itemid = 1949, droprate = 39},
            {itemid = 1681, droprate = 39},
            {itemid = 645, droprate = 39},
            {itemid = 1933, droprate = 627},
        },
        {
            {itemid = 1945, droprate = 159},
            {itemid = 1951, droprate = 139},
            {itemid = 2659, droprate = 39},
            {itemid = 664, droprate = 20},
            {itemid = 646, droprate = 20},
            {itemid = 1931, droprate = 200},
        },
    },
    -- SE_Apollyon floor 4
    [113] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1935, droprate = 220},
            {itemid = 1937, droprate = 300},
            {itemid = 1957, droprate = 260},
            {itemid = 1953, droprate = 340},
        },
        {
            {itemid = 2657, droprate = 220},
            {itemid = 2717, droprate = 180},
            {itemid = 1931, droprate = 300},
        },
        {
            {itemid = 1909, droprate = 1000},
        },
        {
            {itemid = 2127, droprate = 59},
            {itemid = 1875, droprate = 100},
        },
    },
    -- NE_Apollyon floor 1
    [114] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1953, droprate = 304},
            {itemid = 1943, droprate = 18},
            {itemid = 1941, droprate = 200},
            {itemid = 2715, droprate = 200},
            {itemid = 2661, droprate = 36},
        },
        {
            {itemid = 1933, droprate = 18},
            {itemid = 1939, droprate = 36},
            {itemid = 1935, droprate = 411},
            {itemid = 2717, droprate = 482},
            {itemid = 1947, droprate = 18},
        },
    },
    -- NE_Apollyon floor 2
    [115] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1947, droprate = 26},
            {itemid = 1933, droprate = 53},
            {itemid = 1943, droprate = 26},
            {itemid = 2661, droprate = 26},
            {itemid = 1937, droprate = 395},
        },
        {
            {itemid = 1957, droprate = 289},
            {itemid = 1941, droprate = 53},
            {itemid = 1939, droprate = 112},
            {itemid = 2657, droprate = 477},
        },
    },
    -- NE_Apollyon floor 3
    [116] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1931, droprate = 788},
            {itemid = 1939, droprate = 30},
            {itemid = 1953, droprate = 130},
            {itemid = 1957, droprate = 100},
            {itemid = 1947, droprate = 90},
        },
        {
            {itemid = 1933, droprate = 30},
            {itemid = 1941, droprate = 99},
            {itemid = 2661, droprate = 61},
            {itemid = 2715, droprate = 30},
            {itemid = 1943, droprate = 160},
        },
        {
            {itemid = 1633, droprate = 30},
            {itemid = 821, droprate = 40},
        },
        {
            {itemid = 1311, droprate = 50},
            {itemid = 1883, droprate = 40},
            {itemid = 2004, droprate = 20},
        },
    },
    -- NE_Apollyon floor 4
    [117] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1949, droprate = 326},
            {itemid = 1945, droprate = 256},
            {itemid = 1951, droprate = 395},
        },
        {
            {itemid = 1959, droprate = 279},
            {itemid = 1955, droprate = 256},
            {itemid = 2659, droprate = 326},
        },
    },
    -- NE_Apollyon floor 5
    [118] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 100},
            {itemid = 2127, droprate = 59},
        },
        {
            {itemid = 1910, droprate = 1000},
        },
    },
    -- SW_Apollyon floor 1
    [119] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1949, droprate = 464},
            {itemid = 1945, droprate = 250},
            {itemid = 1953, droprate = 110},
            {itemid = 1937, droprate = 71},
        },
        {
            {itemid = 1931, droprate = 180},
            {itemid = 2657, droprate = 210},
            {itemid = 2717, droprate = 111},
            {itemid = 1935, droprate = 107},
        },
    },
    -- SW_Apollyon floor 2
    [120] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1951, droprate = 154},
            {itemid = 1935, droprate = 95},
            {itemid = 1959, droprate = 269},
        },
        {
            {itemid = 1937, droprate = 106},
            {itemid = 1931, droprate = 77},
            {itemid = 2659, droprate = 423},
            {itemid = 1957, droprate = 110},
        },
    },
    -- SW_Apollyon floor 3
    [121] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1955, droprate = 595},
            {itemid = 1957, droprate = 100},
            {itemid = 1937, droprate = 24},
            {itemid = 1953, droprate = 48},
        },
        {
            {itemid = 1931, droprate = 120},
            {itemid = 1953, droprate = 48},
            {itemid = 1935, droprate = 24},
            {itemid = 2657, droprate = 24},
            {itemid = 2717, droprate = 71},
        },
        {
            {itemid = 1311, droprate = 32},
            {itemid = 1883, droprate = 40},
            {itemid = 1681, droprate = 31},
            {itemid = 1633, droprate = 71},
            {itemid = 645, droprate = 31},
            {itemid = 664, droprate = 63},
            {itemid = 646, droprate = 31},
            {itemid = 821, droprate = 63},
        },
    },
    -- SW_Apollyon floor 4
    [122] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1941, droprate = 468},
            {itemid = 1947, droprate = 340},
            {itemid = 1933, droprate = 255},
            {itemid = 1939, droprate = 191},
        },
        {
            {itemid = 1943, droprate = 170},
            {itemid = 2661, droprate = 340},
            {itemid = 2715, droprate = 170},
        },
        {
            {itemid = 1987, droprate = 1000},
        },
        {
            {itemid = 2127, droprate = 59},
            {itemid = 1875, droprate = 100},
        },
    },
    -- NW_Apollyon floor 1
    [123] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1937, droprate = 25},
            {itemid = 2657, droprate = 175},
            {itemid = 1957, droprate = 100},
            {itemid = 1943, droprate = 25},
            {itemid = 1953, droprate = 250},
            {itemid = 2717, droprate = 75},
            {itemid = 1931, droprate = 225},
            {itemid = 1935, droprate = 50},
        },
    },
    -- NW_Apollyon floor 2
    [124] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1943, droprate = 235},
            {itemid = 2659, droprate = 59},
            {itemid = 1945, droprate = 235},
            {itemid = 1955, droprate = 147},
            {itemid = 1951, droprate = 118},
            {itemid = 1959, droprate = 176},
            {itemid = 1935, droprate = 110},
        },
    },
    -- NW_Apollyon floor 3
    [125] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1947, droprate = 133},
            {itemid = 1933, droprate = 133},
            {itemid = 1943, droprate = 133},
            {itemid = 2661, droprate = 133},
            {itemid = 1939, droprate = 110},
            {itemid = 1941, droprate = 400},
        },
        {
            {itemid = 646, droprate = 50},
            {itemid = 1633, droprate = 50},
            {itemid = 664, droprate = 50},
            {itemid = 645, droprate = 50},
            {itemid = 1311, droprate = 50},
            {itemid = 1681, droprate = 50},
            {itemid = 821, droprate = 50},
            {itemid = 1883, droprate = 50},
        },
    },
    -- NW_Apollyon floor 4
    [126] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1937, droprate = 80},
            {itemid = 2657, droprate = 70},
            {itemid = 1949, droprate = 48},
            {itemid = 1947, droprate = 30},
            {itemid = 2659, droprate = 25},
            {itemid = 1957, droprate = 19},
            {itemid = 1945, droprate = 48},
            {itemid = 1933, droprate = 90},
            {itemid = 1955, droprate = 00},
            {itemid = 2661, droprate = 48},
            {itemid = 1939, droprate = 136},
            {itemid = 1951, droprate = 80},
            {itemid = 1953, droprate = 110},
            {itemid = 1959, droprate = 95},
            {itemid = 2715, droprate = 123},
            {itemid = 1935, droprate = 48},
        },
    },
    -- NW_Apollyon floor 5
    [127] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1937, droprate = 109},
            {itemid = 2657, droprate = 152},
            {itemid = 1949, droprate = 283},
            {itemid = 1947, droprate = 109},
            {itemid = 2659, droprate = 65},
            {itemid = 2715, droprate = 130},
        },
        {
            {itemid = 1957, droprate = 65},
            {itemid = 1945, droprate = 174},
            {itemid = 1933, droprate = 130},
            {itemid = 1955, droprate = 196},
            {itemid = 1943, droprate = 174},
            {itemid = 2661, droprate = 174},
            {itemid = 1939, droprate = 109},
        },
        {
            {itemid = 1951, droprate = 130},
            {itemid = 1953, droprate = 304},
            {itemid = 2717, droprate = 87},
            {itemid = 1959, droprate = 217},
            {itemid = 1941, droprate = 174},
            {itemid = 1931, droprate = 130},
            {itemid = 1935, droprate = 109},
        },
        {
            {itemid = 1988, droprate = 1000},
        },
        {
            {itemid = 2127, droprate = 59},
            {itemid = 1875, droprate = 100},
        },
    },
    -- omega
    [128] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1925, droprate = 659},
            {itemid = 1927, droprate = 394},
            {itemid = 1928, droprate = 388},
            {itemid = 1929, droprate = 404},
        },
        {
            {itemid = 1928, droprate = 394},
            {itemid = 1929, droprate = 402},
            {itemid = 1925, droprate = 659},
            {itemid = 1927, droprate = 383},
        },
        {
            {itemid = 1926, droprate = 265},
            {itemid = 1875, droprate = 100},
        },
    },
    -- pod
    [129] =
    {
        {
            {itemid = 1933, droprate = 9},
            {itemid = 1931, droprate = 53},
            {itemid = 1959, droprate = 6},
            {itemid = 1935, droprate = 12},
            {itemid = 1945, droprate = 29},
            {itemid = 1957, droprate = 12},
            {itemid = 1949, droprate = 35},
            {itemid = 2659, droprate = 35},
            {itemid = 1939, droprate = 12},
            {itemid = 1951, droprate = 12},
            {itemid = 2661, droprate = 12},
            {itemid = 1937, droprate = 18},
            {itemid = 1955, droprate = 29},
            {itemid = 2717, droprate = 12},
            {itemid = 1947, droprate = 12},
            {itemid = 2657, droprate = 18},
            {itemid = 2715, droprate = 5},
            {itemid = 1953, droprate = 35},
            {itemid = 1941, droprate = 41},
            {itemid = 1943, droprate = 18},
            {itemid = 1987, droprate = 53},
            {itemid = 1988, droprate = 76},
            {itemid = 1909, droprate = 64},
            {itemid = 1910, droprate = 41},
        },
        {
            {itemid = 646, droprate = 50},
            {itemid = 1633, droprate = 50},
            {itemid = 664, droprate = 50},
            {itemid = 645, droprate = 50},
            {itemid = 1311, droprate = 50},
            {itemid = 1681, droprate = 50},
            {itemid = 821, droprate = 50},
            {itemid = 1883, droprate = 50},
        },
    }
}

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player, npc, trade)
end

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player, npc)
    local battlefield = player:getBattlefield()
    local CofferID = npc:getID()
    local CofferType = 0
    local lootID = 0
    local InstanceRegion = 0
    local addtime = 0
    local DespawnOtherCoffer = false
    local MimicID = 0
    if not battlefield then
        printf("Error: battlefield nil but we're opening a treasure box! "..player:getName())
        printf("Illegal CofferID: "..CofferID)
        return
    end

    for coffer = 1, #ARMOURY_CRATES_LIST_APOLLYON, 2 do
        if (ARMOURY_CRATES_LIST_APOLLYON[coffer]== CofferID-16932864) then
           CofferType=ARMOURY_CRATES_LIST_APOLLYON[coffer+1][1]
           InstanceRegion=ARMOURY_CRATES_LIST_APOLLYON[coffer+1][2]
           addtime=ARMOURY_CRATES_LIST_APOLLYON[coffer+1][3]
           DespawnOtherCoffer=ARMOURY_CRATES_LIST_APOLLYON[coffer+1][4]
           MimicID=ARMOURY_CRATES_LIST_APOLLYON[coffer+1][5]
           lootID=ARMOURY_CRATES_LIST_APOLLYON[coffer+1][6]
        end
    end

-- printf("CofferID : %u", CofferID-16932864)
-- printf("Coffertype %u", CofferType)
-- printf("InstanceRegion: %u", InstanceRegion)
-- printf("addtime: %u", addtime)
-- printf("MimicID: %u", MimicID)
-- printf("lootID: %u", lootID)

    if (CofferType == cTIME) then
        tpz.battlefield.ExtendTimeLimit(battlefield, addtime)
    elseif (CofferType == cITEM) then
        battlefield:setLocalVar("loot", 1)
        battlefield:spawnLoot(npc)
        tpz.battlefield.HandleLootRolls(battlefield, loot[lootID], nil, npc)
    elseif (CofferType == cRESTORE) then
        tpz.battlefield.HealPlayers(battlefield)
    elseif (CofferType == cMIMIC) then
         if (CofferID==16932864+210) then
                GetNPCByID(16932864+195):setPos(npc:getXPos(), npc:getYPos(), npc:getZPos())
                GetNPCByID(16932864+195):setStatus(tpz.status.NORMAL)
         elseif (CofferID==16932864+211) then
                          GetMobByID(16932896):setPos(npc:getXPos(), npc:getYPos(), npc:getZPos())
                        GetMobByID(16932896):setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos())
                        GetMobByID(16932896):updateClaim(player)
         elseif (CofferID==16932864+212) then
                GetNPCByID(16932864+196):setPos(npc:getXPos(), npc:getYPos(), npc:getZPos())
                GetNPCByID(16932864+196):setStatus(tpz.status.NORMAL)
         elseif (CofferID==16932864+213) then
                         GetMobByID(16932897):setPos(npc:getXPos(), npc:getYPos(), npc:getZPos())
                        GetMobByID(16932897):setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos())
                        GetMobByID(16932897):updateClaim(player)
         elseif (CofferID==16932864+214) then
                GetNPCByID(16932864+197):setPos(npc:getXPos(), npc:getYPos(), npc:getZPos())
                GetNPCByID(16932864+197):setStatus(tpz.status.NORMAL)
         elseif (CofferID==16932864+215) then
                         GetMobByID(16932898):setPos(npc:getXPos(), npc:getYPos(), npc:getZPos())
                        GetMobByID(16932898):setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos())
                        GetMobByID(16932898):updateClaim(player)
         elseif (CofferID==16932864+216) then
                          GetMobByID(16932899):setPos(npc:getXPos(), npc:getYPos(), npc:getZPos())
                        GetMobByID(16932899):setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos())
                        GetMobByID(16932899):updateClaim(player)
         end
    end

    if (DespawnOtherCoffer==true) then
        HideArmouryCrates(InstanceRegion, APOLLYON_SE_NE)
    end

   npc:setStatus(tpz.status.DISAPPEAR)
end

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player, csid, option)
end

-----------------------------------
-- onEventFinish Action
-----------------------------------

function onEventFinish(player, csid, option)
end
