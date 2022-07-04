--------------------------------------------
--         Dynamis 75 Era Module          --
--------------------------------------------
--------------------------------------------
--       Module Required Scripts          --
--------------------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/status")
require("modules/module_utils")
--------------------------------------------
--       Module Affected Scripts          --
--------------------------------------------
--------------------------------------------

local m = Module:new("era_dynamis_zones")

local dynamisZones =
{
    {xi.zone.DYNAMIS_BASTOK, "Dynamis-Bastok", 2},
    {xi.zone.DYNAMIS_BEAUCEDINE, "Dynamis-Beaucedine", 5},
    {xi.zone.DYNAMIS_BUBURIMU, "Dynamis-Buburimu", 8},
    {xi.zone.DYNAMIS_JEUNO, "Dynamis-Jeuno", 4},
    {xi.zone.DYNAMIS_QUFIM, "Dynamis-Qufim", 9},
    {xi.zone.DYNAMIS_SAN_DORIA, "Dynamis-San_dOria", 1},
    {xi.zone.DYNAMIS_TAVNAZIA, "Dynamis-Tavnazia", 10},
    {xi.zone.DYNAMIS_VALKURM, "Dynamis-Valkurm", 7},
    {xi.zone.DYNAMIS_WINDURST, "Dynamis-Windurst", 3},
    {xi.zone.DYNAMIS_XARCABARD, "Dynamis-Xarcabard", 6}
}

local startingZones =
{
    {xi.zone.BASTOK_MINES, "Bastok_Mines", 2, xi.zone.DYNAMIS_BASTOK, "Trail_Markings"},
    {xi.zone.BEAUCEDINE_GLACIER, "Beaucedine_Glacier", 5, xi.zone.DYNAMIS_BEAUCEDINE, "Trail_Markings"},
    {xi.zone.BUBURIMU_PENINSULA, "Buburimu_Peninsula", 8, xi.zone.DYNAMIS_BUBURIMU, "Hieroglyphics"},
    {xi.zone.RULUDE_GARDENS, "RuLude_Gardens", 4, xi.zone.DYNAMIS_JEUNO, "Trail_Markings"},
    {xi.zone.QUFIM_ISLAND, "Qufim_Island", 9, xi.zone.QUFIM_ISLAND, "Hieroglyphics"},
    {xi.zone.SOUTHERN_SAN_DORIA, "Southern_San_dOria", 1, xi.zone.DYNAMIS_SAN_DORIA, "Trail_Markings"},
    {xi.zone.TAVNAZIAN_SAFEHOLD, "Tavnazian_Safehold", 10, xi.zone.DYNAMIS_TAVNAZIA, "Hieroglyphics"},
    {xi.zone.VALKURM_DUNES, "Valkurm_Dunes", 7, xi.zone.DYNAMIS_VALKURM, "Hieroglyphics"},
    {xi.zone.WINDURST_WALLS, "Windurst_Walls", 3, xi.zone.DYNAMIS_WINDURST, "Trail_Markings"},
    {xi.zone.XARCABARD, "Xarcabard", 6, xi.zone.DYNAMIS_XARCABARD, "Trail_Markings"}
}

local timelessHourglassID = 4236

local currencyHaggle =
{
    1455,
    1456,
    1457
}

local currencyAntiqix =
{
    1449,
    1450,
    1451
}

local currencyLootblox =
{
    1452,
    1453,
    1454
}

local shopLootblox =
{
    5, 1295, -- Twincoon
    6, 1466, -- Relic Iron
    7, 1520, -- Goblin Grease
    8, 1516, -- Griffon Hide
   23, 1459, -- Griffon Leather
   25, 883,  -- Behemoth Horn
   28, 1458, -- Mammoth Tusk
}

local shopHaggle =
{
    7, 1313, -- Siren's Hair
    8, 1521, -- Slime Juice
    9, 1469, -- Wootz Ore
    12, 4246, -- Cantarella
    20, 1468, -- Marksman's Oil
    25, 1461, -- Wootz Ingot
    33, 1460, -- Koh-I-Noor
}

local shopAntiqix =
{
    7, 1312, -- Angel Skin
    8, 1518, -- Colossal Skull
    9, 1464, -- Lancewood Log
   23, 1463, -- Chronos Tooth
   24, 1467, -- Relic Steel
   25, 1462, -- Lancewood Lumber
   28, 658,  -- Damascus Ingot
}

local maps =
{
    [xi.ki.MAP_OF_DYNAMIS_SAN_DORIA]   = 10000,
    [xi.ki.MAP_OF_DYNAMIS_BASTOK]     = 10000,
    [xi.ki.MAP_OF_DYNAMIS_WINDURST]   = 10000,
    [xi.ki.MAP_OF_DYNAMIS_JEUNO]      = 10000,
    [xi.ki.MAP_OF_DYNAMIS_BEAUCEDINE] = 15000,
    [xi.ki.MAP_OF_DYNAMIS_XARCABARD]  = 20000,
    [xi.ki.MAP_OF_DYNAMIS_VALKURM]    = 10000,
    [xi.ki.MAP_OF_DYNAMIS_BUBURIMU]   = 10000,
    [xi.ki.MAP_OF_DYNAMIS_QUFIM]      = 10000,
    [xi.ki.MAP_OF_DYNAMIS_TAVNAZIA]   = 20000,
}

local hourglassVendors =
{
    {"Davoi", "Lootblox", currencyLootblox, shopLootblox, 130},
    {"Castle_Oztroja", "Antiqix", currencyAntiqix, shopAntiqix, 50},
    {"Beadeaux", "Haggleblix", currencyHaggle, shopHaggle, 130}
}

for _, zoneID in pairs(dynamisZones) do
    m:addOverride(string.format("xi.zones.%s.Zone.onInitialize", zoneID[2]),
    function(zone)
        xi.dynamis.cleanupDynamis(zone) -- Run cleanupDynamis
    end)
    m:addOverride(string.format("xi.zones.%s.Zone.onZoneOut", zoneID[2]),
    function(player)
        xi.dynamis.zoneOnZoneOut(player) -- Run onZoneIn functions.
    end)
    m:addOverride(string.format("xi.zones.%s.Zone.onZoneTick", zoneID[2]),
    function(zone)
        xi.dynamis.handleDynamis(zone)
    end)
    if zoneID[3] >= 7 then
        m:addOverride(string.format("xi.zones.%s.npcs.qm0.onTrigger", zoneID[2]),
        function(player, npc)
            xi.dynamis.sjQMOnTrigger(player, npc)
        end)
    end
end


for _, zoneID in pairs(startingZones) do
    m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrade", zoneID[2], zoneID[5]),
    function(player, npc, trade)
        xi.dynamis.entryNpcOnTrade(player, npc, trade)
    end)
    m:addOverride(string.format("xi.zones.%s.npcs.%s.onEventUpdate", zoneID[2], zoneID[5]),
    function(player, npc, trade)
        xi.dynamis.entryNpcOnEventUpdate(player, npc, trade)
    end)
    m:addOverride(string.format("xi.zones.%s.npcs.%s.onEventFinish", zoneID[2], zoneID[5]),
    function(player, npc, trade)
        xi.dynamis.entryNpcOnEventFinish(player, npc, trade)
    end)
    m:addOverride(string.format("xi.zones.%s.Zone.onZoneTick", zoneID[2]),
    function(zone)
        local dynamisZone = GetZone(zoneID[4])
        if dynamisZone:getLocalVar(string.format("[DYNA]NoPlayersInZone_%s", dynamisZone:getID())) ~= 0 then
            if dynamisZone:getLocalVar(string.format("[DYNA]NoPlayersInZone_%s", dynamisZone:getID())) <= os.time() then
                xi.dynamis.cleanupDynamis(dynamisZone)
            end
        end
    end)
end

for _, npcEntry in pairs(hourglassVendors) do
    m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrade", npcEntry[1], npcEntry[2]), function(player, npc, trade)
        local gil = trade:getGil()
        local count = trade:getItemCount()
        local eventId = npcEntry[5]
        if player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) then
            -- buy timeless hourglass
            if (gil == xi.settings.main.TIMELESS_HOURGLASS_COST and count == 1 and not player:hasItem(4236)) then
                player:startEvent(eventId + 4)
            -- currency exchanges
            elseif (count == xi.settings.main.CURRENCY_EXCHANGE_RATE and trade:hasItemQty(npcEntry[3][1], xi.settings.main.CURRENCY_EXCHANGE_RATE)) then
                player:startEvent(eventId + 5, xi.settings.main.CURRENCY_EXCHANGE_RATE)
            elseif (count == xi.settings.main.CURRENCY_EXCHANGE_RATE and trade:hasItemQty(npcEntry[3][2], xi.settings.main.CURRENCY_EXCHANGE_RATE)) then
                player:startEvent(eventId + 6, xi.settings.main.CURRENCY_EXCHANGE_RATE)
            elseif (count == 1 and trade:hasItemQty(npcEntry[3][3], 1)) then
                player:startEvent(eventId + 8, npcEntry[3][3], npcEntry[3][2], xi.settings.main.CURRENCY_EXCHANGE_RATE)
            -- shop
            else
                local item
                local price
                for i=1, 13, 2 do
                    price = npcEntry[4][i]
                    item = npcEntry[4][i+1]
                    if (count == price and trade:hasItemQty(npcEntry[3][2], price)) then
                        player:setLocalVar("hundoItemBought", item)
                        player:startEvent(eventId + 7, npcEntry[3][2], price, item)
                        break
                    end
                end
            end
        end
    end)
    m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrigger", npcEntry[1], npcEntry[2]), function(player, npc)
        local eventId = npcEntry[5]
        if (player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND)) then
            player:startEvent(eventId + 3, npcEntry[3][1], xi.settings.main.CURRENCY_EXCHANGE_RATE, npcEntry[3][2], xi.settings.main.CURRENCY_EXCHANGE_RATE, npcEntry[3][3], xi.settings.main.TIMELESS_HOURGLASS_COST, 4236, xi.settings.main.TIMELESS_HOURGLASS_COST)
        else
            player:startEvent(eventId)
        end
    end)
    m:addOverride(string.format("xi.zones.%s.npcs.%s.onEventUpdate", npcEntry[1], npcEntry[2]), function(player, csid, option)
        local eventId = npcEntry[5]
        if csid == eventId + 3 then
            if option == 1 then
                player:release()
            elseif option == 2 then -- Shop
                player:updateEvent(unpack(npcEntry[4], 1, 8))
            elseif option == 3 then -- Shop
                player:updateEvent(unpack(npcEntry[4], 9, 14))
            elseif option == 10 then -- Offer to trade down for 10k
                player:updateEvent(npcEntry[3][3], npcEntry[3][2], xi.settings.main.CURRENCY_EXCHANGE_RATE)
            elseif option == 11 then -- main menu (param1 = dynamis map bitmask, param2 = gil)
                player:updateEvent(xi.dynamis.getDynamisMapList(player), player:getGil())
            elseif maps[option] ~= nil then
                local price = maps[option]
                if (price > player:getGil()) then
                    player:messageSpecial(zones[player:getZoneID()].text.NOT_ENOUGH_GIL)
                else
                    player:delGil(price)
                    player:addKeyItem(option)
                    player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, option)
                end
                player:updateEvent(xi.dynamis.getDynamisMapList(player), player:getGil())
            end
        end
    end)
    m:addOverride(string.format("xi.zones.%s.npcs.%s.onEventFinish", npcEntry[1], npcEntry[2]), function(player, csid, option)
        local eventId = npcEntry[5]
        if csid == eventId + 4 then -- Bought hourglass
            player:tradeComplete()
            player:addItem(4236)
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 4236)
        elseif csid == eventId + 5 then -- Currency conversion to Singles
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, npcEntry[3][2])
            else
                player:tradeComplete()
                player:addItem(npcEntry[3][2])
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, npcEntry[3][2])
            end
        elseif csid == eventId + 6 then -- Currency Conversion to 10k
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, npcEntry[3][3])
            else
                player:tradeComplete()
                player:addItem(npcEntry[3][3])
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, npcEntry[3][3])
            end
        elseif csid == eventId + 8 then -- Currency Conversion to 10k
            local slotsReq = math.ceil(xi.settings.main.CURRENCY_EXCHANGE_RATE / 99)
            if player:getFreeSlotsCount() < slotsReq then
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, npcEntry[3][2])
            else
                player:tradeComplete()
                for i=1, slotsReq do
                    if (i < slotsReq or (xi.settings.main.CURRENCY_EXCHANGE_RATE % 99) == 0) then
                        player:addItem(npcEntry[3][2], xi.settings.main.CURRENCY_EXCHANGE_RATE)
                    else
                        player:addItem(npcEntry[3][2], xi.settings.main.CURRENCY_EXCHANGE_RATE % 99)
                    end
                end
                player:messageSpecial(zones[player:getZoneID()].text.ITEMS_OBTAINED, npcEntry[3][2], xi.settings.main.CURRENCY_EXCHANGE_RATE)
            end
        -- bought item from shop
        elseif csid == eventId + 7 then
            local item = player:getLocalVar("hundoItemBought")
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, item)
            else
                player:tradeComplete()
                player:addItem(item)
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, item)
            end
            player:setLocalVar("hundoItemBought", 0)
        end
    end)
end

return m
