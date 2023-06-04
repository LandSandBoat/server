-------------------------------------
-- Vana'versary Celebration Campaign
-------------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/zone")
-------------------------------------

xi = xi or {}
xi.events = xi.events or {}
xi.events.vanaversary = xi.events.vanaversary or {}
xi.events.vanaversary.npcData = xi.events.vanaversary.npcData or {}
xi.events.vanaversary.entities = xi.events.vanaversary.entities or {}

-------------------------------
-- Define Event and Date to run
-------------------------------

local event = SeasonalEvent:new("VanaversaryCelebration")

xi.events.vanaversary.enabledCheck = function()
    local enabled = xi.settings.main.VANAVERSARY_ENABLED
    local always  = xi.settings.main.VANAVERSARY_ALWAYS
    local sMonth  = xi.settings.main.VANAVERSARY_START_MONTH
    local sDay    = xi.settings.main.VANAVERSARY_START_DAY
    local eMonth  = xi.settings.main.VANAVERSARY_END_MONTH
    local eDay    = xi.settings.main.VANAVERSARY_END_DAY
    local month   = tonumber(os.date("%m"))
    local day     = tonumber(os.date("%d"))

    if enabled then
        if month >= sMonth and day >= sDay and month <= eMonth and day <= eDay then
            return true
        elseif always then
            return true
        end
    else
        return false
    end
end

event:setEnableCheck(xi.events.vanaversary.enabledCheck)

---------------------------------------
-- If Vana'versary is active, show NPCs
---------------------------------------

xi.events.vanaversary.showEntities = function(enabled)
    if enabled and #xi.events.vanaversary.entities == 0 then
        xi.events.vanaversary.generateEntities()
    end

    for _, entityID in pairs(xi.events.vanaversary.entities) do
        local entity = GetNPCByID(entityID)
        if entity then
            if enabled then
                entity:setStatus(xi.status.NORMAL)
            else
                -- TODO: Why doesn't DISAPPEAR work here?
                -- entity:setStatus(xi.status.DISAPPEAR)

                entity:setStatus(xi.status.INVISIBLE)
            end
        end
    end

    if not enabled then
        xi.events.vanaversary.entities = {}
    end
end

------------------------------------------------------
-- Index of Vanaversary Coffer Items (Gender Specific)
------------------------------------------------------

xi.events.vanaversary.cofferItemsF =
{
    [ 0] = xi.items.DINNER_JACKET,
    [ 1] = xi.items.DINNER_HOSE,
    [ 2] = xi.items.NOVENNIAL_DRESS,
    [ 3] = xi.items.NOVENNIAL_THIGH_BOOTS,
    [ 4] = xi.items.DECENNIAL_TIARA,
    [ 5] = xi.items.DECENNIAL_DRESS,
    [ 6] = xi.items.DECENNIAL_HOSE,
    [ 7] = xi.items.DECENNIAL_TIARA_P1,
    [ 8] = xi.items.DECENNIAL_DRESS_P1,
    [ 9] = xi.items.DECENNIAL_HOSE_P1,
    [10] = xi.items.MEMORIAL_CAKE,
    [11] = xi.items.MOOGLE_GUARD,
    [12] = xi.items.CHOCOBO_SHIELD,
    [13] = xi.items.MOOGLE_GUARD_P1,
    [14] = xi.items.CHOCOBO_SHIELD_P1,
    [15] = xi.items.GREEN_MOOGLE_MASQUE,
    [16] = xi.items.GREEN_MOOGLE_SUIT,
    [17] = xi.items.GOBLIN_MASQUE,
    [18] = xi.items.GOBLIN_SUIT,
    [19] = xi.items.CIPHER_OF_A_MOOGLES_ALTER_EGO,
    [20] = xi.items.CIPHER_OF_FABLINIXS_ALTER_EGO,
    [21] = xi.items.CIPHER_OF_ALDOS_ALTER_EGO,
    [22] = xi.items.BEHEMOTH_MASQUE,
    [23] = xi.items.BEHEMOTH_SUIT,
    [24] = xi.items.BEHEMOTH_MASQUE_P1,
    [25] = xi.items.BEHEMOTH_SUIT_P1,
    [26] = xi.items.VANACLOCK,
    [27] = xi.items.CIPHER_OF_KUPOFRIEDS_ALTER_EGO,
    [28] = xi.items.AKITU_SHIRT,
    [29] = xi.items.RED_CRAB_NOTEBOOK,
    [30] = xi.items.CRUSTACEAN_SHIRT,
    [31] = xi.items.HAPY_STAFF,
    [32] = xi.items.CORNELIA_STATUE,
    [33] = xi.items.PREMIUM_MOGTI,
    [34] = xi.items.JODY_SHIRT,
    [35] = xi.items.JODY_SHIELD,
    [36] = xi.items.MANDRAGORA_SHIRT,
    [37] = xi.items.PAINTING_OF_A_MERCENARY,
    [38] = xi.items.KORRIGAN_POT,
    [39] = xi.items.ADENIUM_POT,
    [40] = xi.items.CITRULLUS_POT,
}

xi.events.vanaversary.cofferItemsM =
{
    [ 0] = xi.items.DINNER_JACKET,
    [ 1] = xi.items.DINNER_HOSE,
    [ 2] = xi.items.NOVENNIAL_COAT,
    [ 3] = xi.items.NOVENNIAL_HOSE,
    [ 4] = xi.items.DECENNIAL_CROWN,
    [ 5] = xi.items.DECENNIAL_COAT,
    [ 6] = xi.items.DECENNIAL_TIGHTS,
    [ 7] = xi.items.DECENNIAL_CROWN_P1,
    [ 8] = xi.items.DECENNIAL_COAT_P1,
    [ 9] = xi.items.DECENNIAL_TIGHTS_P1,
    [10] = xi.items.MEMORIAL_CAKE,
    [11] = xi.items.MOOGLE_GUARD,
    [12] = xi.items.CHOCOBO_SHIELD,
    [13] = xi.items.MOOGLE_GUARD_P1,
    [14] = xi.items.CHOCOBO_SHIELD_P1,
    [15] = xi.items.GREEN_MOOGLE_MASQUE,
    [16] = xi.items.GREEN_MOOGLE_SUIT,
    [17] = xi.items.GOBLIN_MASQUE,
    [18] = xi.items.GOBLIN_SUIT,
    [19] = xi.items.CIPHER_OF_A_MOOGLES_ALTER_EGO,
    [20] = xi.items.CIPHER_OF_FABLINIXS_ALTER_EGO,
    [21] = xi.items.CIPHER_OF_ALDOS_ALTER_EGO,
    [22] = xi.items.BEHEMOTH_MASQUE,
    [23] = xi.items.BEHEMOTH_SUIT,
    [24] = xi.items.BEHEMOTH_MASQUE_P1,
    [25] = xi.items.BEHEMOTH_SUIT_P1,
    [26] = xi.items.VANACLOCK,
    [27] = xi.items.CIPHER_OF_KUPOFRIEDS_ALTER_EGO,
    [28] = xi.items.AKITU_SHIRT,
    [29] = xi.items.RED_CRAB_NOTEBOOK,
    [30] = xi.items.CRUSTACEAN_SHIRT,
    [31] = xi.items.HAPY_STAFF,
    [32] = xi.items.CORNELIA_STATUE,
    [33] = xi.items.PREMIUM_MOGTI,
    [34] = xi.items.JODY_SHIRT,
    [35] = xi.items.JODY_SHIELD,
    [36] = xi.items.MANDRAGORA_SHIRT,
    [37] = xi.items.PAINTING_OF_A_MERCENARY,
    [38] = xi.items.KORRIGAN_POT,
    [39] = xi.items.ADENIUM_POT,
    [40] = xi.items.CITRULLUS_POT,
}

xi.events.vanaversary.goods = xi.events.vanaversary.cofferItemsF -- Default Coffer Contents to Female

-------------------------
-- History Moogle Rewards
-------------------------

xi.events.vanaversary.historyRewards =
{
    [0] =  xi.items.ECHAD_RING,
    [1] =  xi.items.TRIZEK_RING,
    [2] =  xi.items.CALIBER_RING,
    [3] =  xi.items.FACILITY_RING,
    [4] =  xi.items.LEAF_BENCH,
    [5] =  xi.items.ASTRAL_CUBE,
    [6] =  xi.items.ALLIANCE_SHIRT,
}

----------------------------
-- Dynamic NPC Entity Tables
----------------------------

xi.events.vanaversary.npcType =
{
    HISTORY = 1, -- History Moogle
    COFFER  = 2, -- Treasure Coffer
    T_SHIRT = 3, -- Coffer Moogle (Moogle T-Shirt)
    CHACHA  = 4, -- Chacharoon
    PETS    = 5, -- Chacharoon's Pets
}

xi.events.vanaversary.npcData =
{
    [xi.zone.SOUTHERN_SAN_DORIA] =
        { --  "Name",               rot,        x,        y,        z, entityFlags, widescan, namevis,                                         look,                        npcType,  CSID,
            { "Moogle",             198,   55.636,    1.999,  -25.158,     4194307,        0,       0, "0x0000520000000000000000000000000000000000", xi.events.vanaversary.npcType.HISTORY, 32757, },
            { "Moogle ",             79,   14.190,    2.101,   10.190,           3,        0,       0, "0x0000390900000000000000000000000000000000", xi.events.vanaversary.npcType.T_SHIRT,  3630, },
            { "Chacharoon",         216,   26.000,    2.100,   -2.600,          27,        0,       0, "0x00005F0B00000000000000000000000000000000", xi.events.vanaversary.npcType.CHACHA,      0, },
            { "    ",               216,   26.500,    2.100,   -3.700,        2075,        0,       0, "0x0000620B00000000000000000000000000000000", xi.events.vanaversary.npcType.PETS,        0, },
            { "    ",               216,   24.900,    2.100,   -2.300,        2075,        0,       0, "0x0000690B00000000000000000000000000000000", xi.events.vanaversary.npcType.PETS,        0, },
            { "Treasure Coffer",     79,   13.559,    2.100,   11.330,           3,        0,       0, "0x0000C80300000000000000000000000000000000", xi.events.vanaversary.npcType.COFFER,    974, },
        },
    [xi.zone.BASTOK_MARKETS] =
        { --  "Name",               rot,        x,        y,        z, entityFlags, widescan, namevis,                                         look,               Behavior,
            { "Moogle",              40, -259.440,  -12.021,  -79.538,     4194307,        0,       0, "0x0000520000000000000000000000000000000000", xi.events.vanaversary.npcType.HISTORY, 32757, },
            { "Moogle ",            105, -293.121,  -12.021,  -76.843,           3,        0,       0, "0x0000390900000000000000000000000000000000", xi.events.vanaversary.npcType.T_SHIRT,   689, },
            { "Chacharoon",         152, -293.500,  -12.020,  -59.500,          27,        0,       0, "0x00005F0B00000000000000000000000000000000", xi.events.vanaversary.npcType.CHACHA,      0, },
            { "    ",               152, -292.700,  -12.020,  -58.700,        2075,        0,       0, "0x0000620B00000000000000000000000000000000", xi.events.vanaversary.npcType.PETS,        0, },
            { "    ",               152, -293.800,  -12.020,  -60.650,        2075,        0,       0, "0x0000690B00000000000000000000000000000000", xi.events.vanaversary.npcType.PETS,        0, },
            { "Treasure Coffer",    105, -293.114,  -12.020,  -75.732,           3,        0,       0, "0x0000C80300000000000000000000000000000000", xi.events.vanaversary.npcType.COFFER,    560, },
        },
    [xi.zone.WINDURST_WATERS] =
        { --  "Name",               rot,        x,        y,        z, entityFlags, widescan, namevis,                                         look,               Behavior,
            { "Moogle",             245,  -55.446,   -5.358,  216.826,     4194307,        0,       0, "0x0000520000000000000000000000000000000000", xi.events.vanaversary.npcType.HISTORY, 32757, },
            { "Moogle ",             79,  -53.507,   -3.500,   44.583,           3,        0,       0, "0x0000390900000000000000000000000000000000", xi.events.vanaversary.npcType.T_SHIRT,  1169, },
            { "Chacharoon",         207,  -48.500,   -3.500,   59.500,          27,        0,       0, "0x00005F0B00000000000000000000000000000000", xi.events.vanaversary.npcType.CHACHA,      0, },
            { "    ",               207,  -47.700,   -3.500,   58.700,        2075,        0,       0, "0x0000620B00000000000000000000000000000000", xi.events.vanaversary.npcType.PETS,        0, },
            { "    ",               207,  -49.700,   -3.500,   59.500,        2075,        0,       0, "0x0000690B00000000000000000000000000000000", xi.events.vanaversary.npcType.PETS,        0, },
            { "Treasure Coffer",     79,  -54.075,   -3.500,   45.366,           3,        0,       0, "0x0000C80300000000000000000000000000000000", xi.events.vanaversary.npcType.COFFER,   1033, },
        },
}

----------------------------
-- Generate Dynamic Entities
----------------------------

xi.events.vanaversary.generateEntities = function()
    for zoneId, data in pairs(xi.events.vanaversary.npcData) do
        local zone = GetZone(zoneId)
        if zone then
            for _, entry in pairs(data) do
                local name          = entry[ 1]
                local rot           = entry[ 2]
                local x             = entry[ 3]
                local y             = entry[ 4]
                local z             = entry[ 5]
                local entityFlags   = entry[ 6]
                local widescan      = entry[ 7]
                local namevis       = entry[ 8]
                local look          = entry[ 9]
                local behavior      = entry[10]
                local entityCsid    = entry[11]
                local params        = {}

                if behavior == xi.events.vanaversary.npcType.HISTORY then
                    params = zone:insertDynamicEntity({
                    objtype = xi.objType.NPC,
                    name = name,
                    look = look,
                    x = x,
                    y = y,
                    z = z,
                    rotation = rot,
                    widescan = widescan,
                    entityFlags = entityFlags,
                    namevis = namevis,
                    releaseIdOnDisappear = true,
                    onTrigger = function(player, npc)
                        npc:facePlayer(player, true)
                        xi.events.vanaversary.historyMoogle(player, entityCsid)
                    end,

                    onEventUpdate = function(player, csid, option)
                        xi.events.vanaversary.historyMoogleUpdate(player, csid, option)
                    end,

                    onEventFinish = function(player, csid, option, npc)
                        npc:setRotation(rot)
                    end,

                    })
                end

                if behavior == xi.events.vanaversary.npcType.COFFER then
                    params = zone:insertDynamicEntity({
                    objtype = xi.objType.NPC,
                    name = name,
                    look = look,
                    x = x,
                    y = y,
                    z = z,
                    rotation = rot,
                    widescan = widescan,
                    entityFlags = entityFlags,
                    namevis = namevis,
                    releaseIdOnDisappear = true,
                    onTrigger = function(player, npc)
                        npc:entityAnimationPacket("open")
                        xi.events.vanaversary.treasureCoffer(player, entityCsid)
                    end,

                    onEventUpdate = function(player, csid, option)
                        xi.events.vanaversary.treaureCofferGoods(player, csid, option)
                    end,

                    onEventFinish = function(player, csid, option, npc)
                        npc:entityAnimationPacket("close")
                    end,

                    })
                end

                if behavior == xi.events.vanaversary.npcType.T_SHIRT then
                    params = zone:insertDynamicEntity({
                    objtype = xi.objType.NPC,
                    name = name,
                    look = look,
                    x = x,
                    y = y,
                    z = z,
                    rotation = rot,
                    widescan = widescan,
                    entityFlags = entityFlags,
                    namevis = namevis,
                    releaseIdOnDisappear = true,
                    onTrigger = function(player, npc)
                        player:timer(400, function(playerArg)
                            playerArg:lookAt(npc:getPos())
                        end)

                        npc:facePlayer(player, true)
                        -- TODO: Better handling of Moogle CS Behavior. Add missing Animations.
                        xi.events.vanaversary.tshirtMoogle(player, entityCsid)
                    end,

                    onEventFinish = function(player, csid, option, npc)
                        xi.events.vanaversary.tshirtMoogleEnd(player, csid)
                        npc:setRotation(rot)
                    end,

                    })
                end

                if behavior == xi.events.vanaversary.npcType.CHACHA then
                    params = zone:insertDynamicEntity({
                    objtype = xi.objType.NPC,
                    name = name,
                    look = look,
                    x = x,
                    y = y,
                    z = z,
                    rotation = rot,
                    widescan = widescan,
                    entityFlags = entityFlags,
                    namevis = namevis,
                    releaseIdOnDisappear = true,
                    onTrigger = function(player, npc)
                        npc:facePlayer(player, true)
                        player:PrintToPlayer("Mandragoria Mania Madness is currently unavailable.", 0, npc:getPacketName())
                        npc:timer(600, function(npcArg)
                            player:PrintToPlayer("Happy Vana'versary!", 0, npcArg:getPacketName())
                            npcArg:setRotation(rot)
                        end)

                        npc:timer(1000, function(npcArg)
                            npcArg:setRotation(rot)
                        end)
                    end,

                    })
                end

                if behavior == xi.events.vanaversary.npcType.PETS then
                    params = zone:insertDynamicEntity({
                    objtype = xi.objType.NPC,
                    name = name,
                    look = look,
                    x = x,
                    y = y,
                    z = z,
                    rotation = rot,
                    widescan = widescan,
                    entityFlags = entityFlags,
                    namevis = namevis,
                    releaseIdOnDisappear = true,
                    })
                end

                table.insert(xi.events.vanaversary.entities, params:getID())
            end
        end
    end
end

---------------------------------
-- "Free to Take" Treasure Coffer
---------------------------------

xi.events.vanaversary.treasureCoffer = function(player, csid, option)
    if player:getGender() == 1 then -- Male
        xi.events.vanaversary.goods = xi.events.vanaversary.cofferItemsM
    end

    player:startEvent(csid)
end

xi.events.vanaversary.treaureCofferGoods = function(player, csid, option)
    local choice = xi.events.vanaversary.goods[option]

    if player:isChargedItem(choice) then
        npcUtil.giveUsedItem(player, choice)
    else
        npcUtil.giveItem(player, choice)
    end
end

-----------------
-- T-Shirt Moogle
-----------------

xi.events.vanaversary.tshirtMoogle = function(player, csid)
    local greeting = player:getCharVar("[VANAVERSARY]SawGreeting")

    if not player:hasItem(xi.items.MOOGLE_SHIRT) then
        if greeting > 0 then
            player:startEvent(csid, 2)
        else
            player:startEvent(csid)
        end
    else
        player:startEvent(csid, greeting)
    end
end

xi.events.vanaversary.tshirtMoogleEnd = function(player, csid)
    local greeting = player:getCharVar("[VANAVERSARY]SawGreeting")

    if not player:hasItem(xi.items.MOOGLE_SHIRT) then
        if greeting > 0 then -- Replacement for lost shirt is max reuse timer.
            npcUtil.giveUsedItem(player, xi.items.MOOGLE_SHIRT)
        else -- First shirt is immediately usable.
            npcUtil.giveItem(player, xi.items.MOOGLE_SHIRT)
        end
    end

    if player:getCharVar("[VANAVERSARY]SawGreeting") ~= 1 then
        player:setCharVar("[VANAVERSARY]SawGreeting", 1)
    end
end

-----------------
-- History Moogle
-----------------

xi.events.vanaversary.historyMoogle = function(player, csid)
    local chatHist          = player:getHistory(xi.history.CHATS_SENT)
    local npcHist           = player:getHistory(xi.history.NPC_INTERACTIONS)
    local partiesJoined     = player:getHistory(xi.history.JOINED_PARTIES)
    local allianceJoined    = player:getHistory(xi.history.JOINED_ALLIANCES)
    local battlesFought     = player:getHistory(xi.history.BATTLES_FOUGHT)
    local koCount           = player:getHistory(xi.history.TIMES_KNOCKED_OUT)
    local enemiesDefeated   = player:getHistory(xi.history.ENEMIES_DEFEATED)
    local gmCalls           = player:getHistory(xi.history.GM_CALLS)

    player:startEvent(csid, chatHist, npcHist, partiesJoined, allianceJoined, battlesFought, koCount, enemiesDefeated, gmCalls)
end

xi.events.vanaversary.historyMoogleUpdate = function(player, csid, option)
    local rewardsClaimed = player:getCharVar("[VANAVERSARY]RewardCount")

    player:updateEvent(0, 0, 0, 0, 0, 0, rewardsClaimed, 0)

    if option < 7 then
        if rewardsClaimed == 0 then
            if npcUtil.giveItem(player, xi.events.vanaversary.historyRewards[option]) then
                player:incrementCharVar("[VANAVERSARY]RewardCount", 1)
            end
        elseif rewardsClaimed == 1 then
            if npcUtil.giveItem(player, xi.events.vanaversary.historyRewards[option]) then
                player:incrementCharVar("[VANAVERSARY]RewardCount", 2) -- Not enough information is available for the "Bonus" time based gift to implement.
            end
        end
    end
end

event:setStartFunction(function()
    xi.events.vanaversary.showEntities(true)
end)

event:setEndFunction(function()
    xi.events.vanaversary.showEntities(false)
end)

return event
