-----------------------------------
-- Area: Castle Zvahl Baileys
--  NPC: Switchstix
-- !pos 386.091 -13 -17.399 161
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- TODO: Temporary workaround
---@diagnostic disable: param-type-mismatch

local requiredItems = 1
local currencyType = 2
local currencyAmount = 3
local stageNumber = 4
local csParam = 5

local currency =
{
    BYNE_100 = 1456,
    BYNE_10000 = 1457,
    SILVER_100 = 1453,
    SILVER_10000 = 1454,
    SHELL_100 = 1450,
    SHELL_10000 = 1451,
}

local relics =
{
    -- Spharai
    [18260] = { { 1460, 1459, 665 }, currency.BYNE_100, 4, 1, 1 }, -- Relic Knuckles
    [18261] = { { 16390, 16392, 16396 }, currency.SILVER_100, 14, 2, 2 }, -- Militant Knuckles
    [18262] = { { 1556 }, currency.SHELL_100, 61, 3, 3 }, -- Dynamis Knuckles
    [18263] = { { 1571, 1589 }, currency.BYNE_10000, 1, 4, 3 }, -- Caestus

    -- Mandau
    [18266] = { { 4246, 747, 4166 }, currency.BYNE_100, 4, 1, 1 }, -- Relic Dagger
    [18267] = { { 16449, 16496, 16452 }, currency.SILVER_100, 14, 2, 2 }, -- Malefic Dagger
    [18268] = { { 1557 }, currency.SHELL_100, 61, 3, 3 }, -- Dynamis Dagger
    [18269] = { { 1572, 1589 }, currency.BYNE_10000, 1, 4, 3 }, -- Batardeau

    -- Excalibur
    [18272] = { { 1460, 763, 931 }, currency.SILVER_100, 4, 1, 1 }, -- Relic Sword
    [18273] = { { 16535, 16537, 16542 }, currency.BYNE_100, 14, 2, 2 }, -- Glyptic Sword
    [18274] = { { 1558 }, currency.SHELL_100, 61, 3, 3 }, -- Dynamis Sword
    [18275] = { { 1573, 1589 }, currency.SILVER_10000, 1, 4, 3 }, -- Caliburn

    -- Ragnarok
    [18278] = { { 1459, 655, 746 }, currency.SILVER_100, 4, 1, 1 }, -- Relic Blade
    [18279] = { { 16583, 16584, 16585 }, currency.SHELL_100, 14, 2, 2 }, -- Gilded Blade
    [18280] = { { 1559 }, currency.BYNE_100, 61, 3, 3 }, -- Dynamis Blade
    [18281] = { { 1574, 1589 }, currency.SILVER_10000, 1, 4, 3 }, -- Valhalla

    -- Guttler
    [18284] = { { 1312, 1463, 13060 }, currency.SHELL_100, 3, 1, 1 }, -- Relic Axe
    [18285] = { { 16657, 16658, 16659 }, currency.SILVER_100, 14, 2, 2 }, -- Leonine Axe
    [18286] = { { 1560 }, currency.BYNE_100, 60, 3, 3 }, -- Dynamis Axe
    [18287] = { { 1575, 1589 }, currency.SHELL_10000, 1, 4, 3 }, -- Ogre Killer

    -- Bravura
    [18290] = { { 1461, 658, 720 }, currency.BYNE_100, 3, 1, 1 }, -- Relic Bhuj
    [18291] = { { 16704, 16705, 16724 }, currency.SHELL_100, 16, 2, 2 }, -- Agonal Bhuj
    [18292] = { { 1561 }, currency.SILVER_100, 60, 3, 3 }, -- Dynamis Bhuj
    [18293] = { { 1576, 1589 }, currency.BYNE_10000, 1, 4, 3 }, -- Abaddon Killer

    -- Gungnir
    [18296] = { { 1462, 747, 1294 }, currency.SHELL_100, 4, 1, 1 }, -- Relic Lance
    [18297] = { { 16834, 16836, 16841 }, currency.BYNE_100, 16, 2, 2 }, -- Hotspur Lance
    [18298] = { { 1563 }, currency.SILVER_100, 61, 3, 3 }, -- Dynamis Lance
    [18299] = { { 1578, 1589 }, currency.SHELL_10000, 1, 4, 3 }, -- Gae Assail

    -- Apocalypse
    [18302] = { { 1458, 1117, 13208 }, currency.SHELL_100, 5, 1, 1 }, -- Relic Scythe
    [18303] = { { 16774, 16794, 16777 }, currency.SILVER_100, 16, 2, 2 }, -- Memento Scythe
    [18304] = { { 1562 }, currency.BYNE_100, 62, 3, 3 }, -- Dynamis Scythe
    [18305] = { { 1577, 1589 }, currency.SHELL_10000, 1, 4, 3 }, -- Bec De Faucon

    -- Kikoku
    [18308] = { { 1467, 1276, 1278 }, currency.BYNE_100, 4, 1, 1 }, -- Ihintanto
    [18309] = { { 16900, 16903, 16902 }, currency.SHELL_100, 16, 2, 2 }, -- Mimizuku
    [18310] = { { 1564 }, currency.SILVER_100, 61, 3, 3 }, -- Rogetsu
    [18311] = { { 1579, 1589 }, currency.BYNE_10000, 1, 4, 3 }, -- Yoshimitsu

    -- Amanomurakumo
    [18314] = { { 1467, 1409, 657 }, currency.SILVER_100, 3, 1, 1 }, -- Ito
    [18315] = { { 16966, 16967, 16972 }, currency.SHELL_100, 15, 2, 2 }, -- Hayatemaru
    [18316] = { { 1565 }, currency.BYNE_100, 60, 3, 3 }, -- Oboromaru
    [18317] = { { 1580, 1589 }, currency.SILVER_10000, 1, 4, 3 }, -- Totsukanotsurugi

    -- Mjollnir
    [18320] = { { 1461, 746, 830 }, currency.SILVER_100, 5, 1, 1 }, -- Relic Maul
    [18321] = { { 17044, 17080, 17043 }, currency.BYNE_100, 16, 2, 2 }, -- Battering Maul
    [18322] = { { 1566 }, currency.SHELL_100, 62, 3, 3 }, -- Dynamis Maul
    [18323] = { { 1581, 1589 }, currency.SILVER_10000, 1, 4, 3 }, -- Gullintani

    -- Claustrum
    [18326] = { { 1462, 1271, 1415 }, currency.SHELL_100, 5, 1, 1 }, -- Relic Staff
    [18327] = { { 17088, 17090, 17092 }, currency.BYNE_100, 16, 2, 2 }, -- Sage's Staff
    [18328] = { { 1567 }, currency.SILVER_100, 62, 3, 3 }, -- Dynamis Staff
    [18329] = { { 1582, 1589 }, currency.SHELL_10000, 1, 4, 3 }, -- Thyrus

    -- Annihilator
    [18332] = { { 1468, 830, 654 }, currency.BYNE_100, 5, 1, 1 }, -- Relic Gun
    [18333] = { { 17248, 17251, 17259 }, currency.SHELL_100, 15, 2, 2 }, -- Marksman Gun
    [18334] = { { 1570 }, currency.SILVER_100, 62, 3, 3 }, -- Dynamis Gun
    [18335] = { { 1585, 1589 }, currency.BYNE_10000, 1, 4, 3 }, -- Ferdinand

    -- Gjallarhorn
    [18338] = { { 1458, 1463, 13232 }, currency.SHELL_100, 3, 1, 1 }, -- Relic Horn
    [18339] = { { 17352, 17351, 17362 }, currency.BYNE_100, 14, 2, 2 }, -- Pyrrhic Horn
    [18340] = { { 1569 }, currency.SILVER_100, 60, 3, 3 }, -- Dynamis Horn
    [18341] = { { 1584, 1589 }, currency.SHELL_10000, 1, 4, 3 }, -- Milennium Horn

    -- Yoichinoyumi
    [18344] = { { 883, 1462, 932 }, currency.SILVER_100, 4, 1, 1 }, -- Relic Bow
    [18345] = { { 17161, 17164, 18142 }, currency.SILVER_100, 15, 2, 2 }, -- Wolver Bow
    [18346] = { { 1568 }, currency.SHELL_100, 61, 3, 3 }, -- Dynamis Bow
    [18347] = { { 1583, 1589 }, currency.SILVER_10000, 1, 4, 3 }, -- Futatokoroto

    -- Aegis
    [15066] = { { 875, 668, 720 }, 0, 1, 1, 4 }, -- Relic Shield
    [15067] = { { 12301, 12295, 12387 }, 0, 4, 2, 5 }, -- Bulwark Shield
    [15068] = { { 1821 }, 0, 20, 3, 6 }, -- Dynamis Shield
    [15069] = { { 1822, 1589 }, currency.SILVER_10000, 1, 4, 6 }, -- Ancile
}

local function hasRelic(player, isTrade)
    if isTrade then
        for key, value in pairs(relics) do
            if player:hasItemQty(key, 1) then
                return key
            end
        end

        return nil
    else
        for key, value in pairs(relics) do
            if player:hasItem(key, xi.inv.INVENTORY) then
                return key
            end
        end

        return nil
    end
end

local function tradeHasRequiredCurrency(trade, currentRelic)
    local relic = relics[currentRelic]

    if currentRelic == 15066 or currentRelic == 15067 or currentRelic == 15068 then
        if currentRelic == 15066 and trade:getItemCount() == 3 then
            return trade:hasItemQty(currency.BYNE_100, 1) and trade:hasItemQty(currency.SILVER_100, 1) and trade:hasItemQty(currency.SHELL_100, 1)
        elseif currentRelic == 15067 and trade:getItemCount() == 12 then
            return trade:hasItemQty(currency.BYNE_100, 4) and trade:hasItemQty(currency.SILVER_100, 4) and trade:hasItemQty(currency.SHELL_100, 4)
        elseif currentRelic == 15068 and trade:getItemCount() == 60 then
            return trade:hasItemQty(currency.BYNE_100, 20) and trade:hasItemQty(currency.SILVER_100, 20) and trade:hasItemQty(currency.SHELL_100, 20)
        else
            return false
        end
    else
        if trade:getItemCount() ~= relic[currencyAmount] then
            return false
        else
            return trade:hasItemQty(relic[currencyType], relic[currencyAmount])
        end
    end
end

local function tradeHasRequiredMaterials(trade, relicId, reqItems)
    if trade:getItemCount() ~= (#reqItems + 1) then
        return false
    else
        if not trade:hasItemQty(relicId, 1) then
            return false
        end

        for i = 1, #reqItems, 1 do
            if not trade:hasItemQty(reqItems[i], 1) then
                return false
            end
        end

        return true
    end
end

entity.onTrade = function(player, npc, trade)
    local relicId = hasRelic(trade, true)
    local currentRelic = player:getCharVar('RELIC_IN_PROGRESS')
    local gil = trade:getGil()

    if gil ~= 0 then
        return
    elseif relicId ~= nil then
        local relic = relics[relicId]
        local relicDupe = player:getCharVar('RELIC_MAKE_ANOTHER')

        if player:hasItem(relicId + 1) and relicDupe ~= 1 then
            player:startEvent(20, relicId)
        elseif currentRelic == 0 then
            if
                relic[stageNumber] ~= 4 and
                tradeHasRequiredMaterials(trade, relicId, relic[requiredItems])
            then
                local requiredItem1 = relic[requiredItems][1] ~= nil and relic[requiredItems][1] or 0
                local requiredItem2 = relic[requiredItems][2] ~= nil and relic[requiredItems][2] or 0
                local requiredItem3 = relic[requiredItems][3] ~= nil and relic[requiredItems][3] or 0
                player:setCharVar('RELIC_IN_PROGRESS', relicId)
                player:tradeComplete()
                player:startEvent(11, relicId, requiredItem1, requiredItem2, requiredItem3, relic[currencyType], relic[currencyAmount], 0, relic[csParam])
            end
        elseif currentRelic ~= 0 and relicId ~= currentRelic then
            player:startEvent(87)
        end
    elseif currentRelic ~= 0 then
        local relic = relics[currentRelic]
        local currentStage = relic[stageNumber]

        if currentStage ~= 4 and tradeHasRequiredCurrency(trade, currentRelic) then
            if currentStage == 1 then
                player:setCharVar('RELIC_DUE_AT', getVanaMidnight())
            elseif currentStage == 2 then
                player:setCharVar('RELIC_DUE_AT', os.time() + xi.settings.main.RELIC_2ND_UPGRADE_WAIT_TIME)
            elseif currentStage == 3 then
                player:setCharVar('RELIC_DUE_AT', os.time() + xi.settings.main.RELIC_3RD_UPGRADE_WAIT_TIME)
            end

            player:tradeComplete()
            player:startEvent(13, currentRelic, relic[currencyType], relic[currencyAmount], 0, 0, 0, 0, relic[csParam])
        end
    end
end

entity.onTrigger = function(player, npc)
    local relicId = hasRelic(player, false)
    local currentRelic = player:getCharVar('RELIC_IN_PROGRESS')
    local relicWait = player:getCharVar('RELIC_DUE_AT')
    local relicConquest = player:getCharVar('RELIC_CONQUEST_WAIT')

    if
        currentRelic ~= 0 and
        relicWait ~= 0 and
        relics[currentRelic][stageNumber] ~= 4
    then
        local relic = relics[currentRelic]
        local currentStage = relic[stageNumber]

        if relicWait > os.time() then
            -- Not enough time has passed
            if currentStage == 1 then
                player:startEvent(15, 0, 0, 0, 0, 0, 0, 0, relic[csParam])
            elseif currentStage == 2 then
                player:startEvent(18, 0, 0, 0, 0, 0, 0, 0, relic[csParam])
            elseif currentStage == 3 then
                player:startEvent(51, 0, 0, 0, 0, 0, 0, 0, relic[csParam])
            end
        elseif relicWait <= os.time() then
            -- Enough time has passed
            if currentStage == 1 then
                player:startEvent(16, currentRelic, 0, 0, 0, 0, 0, 0, relic[csParam])
            elseif currentStage == 2 then
                player:startEvent(19, currentRelic, 0, 0, 0, 0, 0, 0, relic[csParam])
            elseif currentStage == 3 then
                player:startEvent(52, currentRelic, 0, 0, 0, 0, 0, 0, relic[csParam])
            end
        end
    elseif
        currentRelic ~= 0 and
        relicWait == 0 and
        relics[currentRelic][stageNumber] ~= 4
    then
        -- Need currency to start timer
        local relic = relics[currentRelic]
        player:startEvent(12, currentRelic, relic[currencyType], relic[currencyAmount], 0, 0, 0, 0, relic[csParam])
    elseif relicId == nil or relicConquest > os.time() then
        -- Player doesn't have a relevant item and hasn't started one
        player:startEvent(10)
    elseif relicId ~= nil and relicConquest <= os.time() then
        -- Player has a relevant item and conquest tally has passed
        local relic = relics[relicId]
        local currentStage = relic[stageNumber]
        local requiredItem1 = relic[requiredItems][1] ~= nil and relic[requiredItems][1] or 0
        local requiredItem2 = relic[requiredItems][2] ~= nil and relic[requiredItems][2] or 0
        local requiredItem3 = relic[requiredItems][3] ~= nil and relic[requiredItems][3] or 0

        if currentStage == 1 then
            player:startEvent(14, relicId, requiredItem1, requiredItem2, requiredItem3, 0, 0, 0, relic[csParam])
        elseif currentStage == 2 then
            player:startEvent(17, relicId, requiredItem1, requiredItem2, requiredItem3, 0, 0, 0, relic[csParam])
        elseif currentStage == 3 then
            player:startEvent(50, relicId, requiredItem1, requiredItem2, requiredItem3, 0, 0, 0, relic[csParam])
        elseif currentStage == 4 then
            -- TODO: Use xi.items enum in key for the below table
            local itemToEventId =
            {
                [18263] = 68, -- Spharai
                [18269] = 69, -- Mandau
                [18275] = 70, -- Excalibur
                [18281] = 71, -- Ragnarok
                [18287] = 72, -- Guttler
                [18293] = 73, -- Bravura
                [18299] = 75, -- Gungnir
                [18305] = 74, -- Apocalypse
                [18311] = 76, -- Kikoku
                [18317] = 77, -- Amanomurakumo
                [18323] = 78, -- Mjollnir
                [18329] = 79, -- Claustrum
                [18335] = 81, -- Annihilator
                [18341] = 82, -- Gjallarhorn
                [18347] = 80, -- Yoichinoyumi
                [15069] = 86, -- Aegis
            }

            player:startEvent(itemToEventId[relicId], requiredItem1, requiredItem2, relic[currencyType], relic[currencyAmount], relicId)
        end
    else
        player:startEvent(10)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    -- Handles the displayed currency types and amounts for Aegis Stage 1->2, 2->3, and 3->4 based on option.
    if (csid == 11 or csid == 12 or csid == 13) and option ~= 0 then
        if option == 1 then
            player:updateEvent(15066, 1453, 1, 1456, 1, 1450, 1)
        elseif option == 2 then
            player:updateEvent(15067, 1453, 4, 1456, 4, 1450, 4)
        elseif option == 3 then
            player:updateEvent(15068, 1453, 20, 1456, 20, 1450, 20)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local reward = player:getCharVar('RELIC_IN_PROGRESS')

    -- User is cancelling a relic.  Null everything out, it never happened.
    if csid == 87 and option == 666 then
        player:setCharVar('RELIC_IN_PROGRESS', 0)
        player:setCharVar('RELIC_DUE_AT', 0)
        player:setCharVar('RELIC_MAKE_ANOTHER', 0)
        player:setCharVar('RELIC_CONQUEST_WAIT', 0)

        -- User is okay with making a relic they cannot possibly accept
    elseif csid == 20 and option == 1 then
        player:setCharVar('RELIC_MAKE_ANOTHER', 1)

        -- Picking up a finished relic stage 1>2 and 2>3.
    elseif (csid == 16 or csid == 19) and reward ~= 0 then
        if player:getFreeSlotsCount() < 1 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward + 1)
        else
            player:addItem(reward + 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, reward + 1)
            player:setCharVar('RELIC_IN_PROGRESS', 0)
            player:setCharVar('RELIC_DUE_AT', 0)
            player:setCharVar('RELIC_MAKE_ANOTHER', 0)
            player:setCharVar('RELIC_CONQUEST_WAIT', NextConquestTally())
        end

        -- Picking up a finished relic stage 3>4.
    elseif csid == 52 and reward ~= 0 then
        if player:getFreeSlotsCount() < 1 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward + 1)
        else
            player:addItem(reward + 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, reward + 1)
            player:setCharVar('RELIC_IN_PROGRESS', 0)
            player:setCharVar('RELIC_DUE_AT', 0)
            player:setCharVar('RELIC_MAKE_ANOTHER', 0)
            player:setCharVar('RELIC_CONQUEST_WAIT', 0)
        end

        -- Stage 4 cutscenes
    elseif (csid >= 68 and csid <= 82) or csid == 86 then
        -- TODO: Use xi.items enum below
        local eventToItemId =
        {
                [68] = 18263, -- Spharai
                [69] = 18269, -- Mandau
                [70] = 18275, -- Excalibur
                [71] = 18281, -- Ragnarok
                [72] = 18287, -- Guttler
                [73] = 18293, -- Bravura
                [75] = 18299, -- Gungnir
                [74] = 18305, -- Apocalypse
                [76] = 18311, -- Kikoku
                [77] = 18317, -- Amanomurakumo
                [78] = 18323, -- Mjollnir
                [79] = 18329, -- Claustrum
                [81] = 18335, -- Annihilator
                [82] = 18341, -- Gjallarhorn
                [80] = 18347, -- Yoichinoyumi
                [86] = 15069, -- Aegis
        }

        player:setCharVar('RELIC_CONQUEST_WAIT', 0)
        player:setCharVar('RELIC_IN_PROGRESS', eventToItemId[csid])
    end
end

return entity

-- TODO: Temporary workaround
---@diagnostic enable: param-type-mismatch
