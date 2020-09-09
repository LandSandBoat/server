-----------------------------------
-- Area: Castle Zvahl Baileys
--   NPC: Switchstix
-- Type: Standard NPC
-- !pos 386.091 -13 -17.399 161
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Baileys/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------

local relics = {
    -- Current Stage, Item 1, Item 2, Item 3, # of items, currency type, currency amount, stage #, cs param 8 (manages turn in cutscenes (1-3) and Aegis (4-6))
    -- The various parameters are stored in a subarray for ease of use with return.
    18260, { 1460,  1459,   665,  4,  1456,   4,  1,  1}, -- Spharai
    18261, {16390, 16392, 16396,  4,  1453,  14,  2,  2},
    18262, { 1556,     0,     0,  2,  1450,  61,  3,  3},
    18263, { 1571,  1589,     0,  0,  1457,   1,  4,  3},

    18266, { 4246,   747,  4166,  4,  1456,   4,  1,  1}, -- Mandau
    18267, {16449, 16496, 16452,  4,  1453,  14,  2,  2},
    18268, { 1557,     0,     0,  2,  1450,  61,  3,  3},
    18269, { 1572,  1589,     0,  0,  1457,   1,  4,  3},

    18272, { 1460,   763,   931,  4,  1453,   4,  1,  1}, -- Excalibur
    18273, {16535, 16537, 16542,  4,  1456,  14,  2,  2},
    18274, { 1558,     0,     0,  2,  1450,  61,  3,  3},
    18275, { 1573,  1589,     0,  0,  1454,   1,  4,  3},

    18278, { 1459,   655,   746,  4,  1453,   4,  1,  1}, -- Ragnarok
    18279, {16583, 16584, 16585,  4,  1450,  14,  2,  2},
    18280, { 1559,     0,     0,  2,  1456,  61,  3,  3},
    18281, { 1574,  1589,     0,  0,  1454,   1,  4,  3},

    18284, { 1312,  1463, 13060,  4,  1450,   3,  1,  1}, -- Guttler
    18285, {16657, 16658, 16659,  4,  1453,  14,  2,  2},
    18286, { 1560,     0,     0,  2,  1456,  60,  3,  3},
    18287, { 1575,  1589,     0,  0,  1451,   1,  4,  3},

    18290, { 1461,   658,   720,  4,  1456,   3,  1,  1}, -- Bravura
    18291, {16704, 16705, 16724,  4,  1450,  16,  2,  2},
    18292, { 1561,     0,     0,  2,  1453,  60,  3,  3},
    18293, { 1576,  1589,     0,  0,  1457,   1,  4,  3},

    18296, { 1462,   747,  1294,  4,  1450,   4,  1,  1}, -- Gungnir
    18297, {16834, 16836, 16841,  4,  1456,  16,  2,  2},
    18298, { 1563,     0,     0,  2,  1453,  61,  3,  3},
    18299, { 1578,  1589,     0,  0,  1451,   1,  4,  3},

    18302, { 1458,  1117, 13208,  4,  1450,   5,  1,  1}, -- Apocalypse
    18303, {16774, 16794, 16777,  4,  1453,  16,  2,  2},
    18304, { 1562,     0,     0,  2,  1456,  62,  3,  3},
    18305, { 1577,  1589,     0,  0,  1451,   1,  4,  3},

    18308, { 1467,  1276,  1278,  4,  1456,   4,  1,  1}, -- Kikoku
    18309, {16900, 16903, 16902,  4,  1450,  16,  2,  2},
    18310, { 1564,     0,     0,  2,  1453,  61,  3,  3},
    18311, { 1579,  1589,     0,  0,  1457,   1,  4,  3},

    18314, { 1467,  1409,   657,  4,  1453,   3,  1,  1}, -- Amanomurakumo
    18315, {16966, 16967, 16972,  4,  1450,  15,  2,  2},
    18316, { 1565,     0,     0,  2,  1456,  60,  3,  3},
    18317, { 1580,  1589,     0,  0,  1454,   1,  4,  3},

    18320, { 1461,   746,   830,  4,  1453,   5,  1,  1}, -- Mjollnir
    18321, {17044, 17080, 17043,  4,  1456,  16,  2,  2},
    18322, { 1566,     0,     0,  2,  1450,  62,  3,  3},
    18323, { 1581,  1589,     0,  0,  1454,   1,  4,  3},

    18326, { 1462,  1271,  1415,  4,  1450,   5,  1,  1}, -- Claustrum
    18327, {17088, 17090, 17092,  4,  1456,  16,  2,  2},
    18328, { 1567,     0,     0,  2,  1453,  62,  3,  3},
    18329, { 1582,  1589,     0,  0,  1451,   1,  4,  3},

    18332, { 1468,   830,   654,  4,  1456,   5,  1,  1}, -- Annihilator
    18333, {17248, 17251, 17259,  4,  1450,  15,  2,  2},
    18334, { 1570,     0,     0,  2,  1453,  62,  3,  3},
    18335, { 1585,  1589,     0,  0,  1457,   1,  4,  3},

    18338, { 1458,  1463, 13232,  4,  1450,   3,  1,  1}, -- Gjallarhorn
    18339, {17352, 17351, 17362,  4,  1456,  14,  2,  2},
    18340, { 1569,     0,     0,  2,  1453,  60,  3,  3},
    18341, { 1584,  1589,     0,  0,  1451,   1,  4,  3},

    18344, {  883,  1462,   932,  4,  1453,   4,  1,  1}, -- Yoichinoyumi
    18345, {17161, 17164, 18142,  4,  1453,  15,  2,  2},
    18346, { 1568,     0,     0,  2,  1450,  61,  3,  3},
    18347, { 1583,  1589,     0,  0,  1454,   1,  4,  3},

    15066, {  875,   668,   720,  4,     0,   1,  1,  4}, -- Aegis
    15067, {12301, 12295, 12387,  4,     0,   4,  2,  5},
    15068, { 1821,     0,     0,  2,     0,  20,  3,  6},
    15069, { 1822,  1589,     0,  0,  1454,   1,  4,  6}
}

function hasRelic(entity, checktype)
    -- Type 1 == Player is triggering NPC
    -- Type 2 == Player is trading an item

    if checktype == 1 then
        for i=1, #relics, 2 do -- Step through the array grabbing every second (2 value, and see if it matches that itemid.
            if (entity:hasItem(relics[i], tpz.inv.INVENTORY)) then -- Specifically checks inventory, so that items in other containers (mog safe, satchel, etc) will be ignored.
                return relics[i]
            end
        end
    elseif checktype == 2 then
        for i=1, #relics, 2 do
            if (entity:hasItemQty(relics[i], 1)) then
                return relics[i]
            end
        end
    end
end

function getRelicParameters(itemid)
    for i=1, #relics, 2 do
        if (relics[i] == itemid) then -- If you've found the right itemid, return the array stored in the next value.
            return relics[i + 1]
        end
    end
end

function onTrade(player, npc, trade)
    local itemid = hasRelic(trade, 2)
    local eventParams = {} -- item1, item2, item3, num_items, currencytype, currencyamount, finalvar
    local currentRelic = player:getCharVar("RELIC_IN_PROGRESS") -- Stores which item has been taken from the player
    local relicWait = player:getCharVar("RELIC_DUE_AT") -- Stores time that relic can be retrieved after
    local relicDupe = player:getCharVar("RELIC_MAKE_ANOTHER") -- Stores a value that the player has acknowledged they can't hold the item they want to make yet they're making it anyway.
    local count = trade:getItemCount()
    local gil = trade:getGil()
    local tradeOK = false

    -- Starting a stage upgrade.
    -- No relics in progress, found a relic in the trade with other items, and (doesn't already own next stage, or (owns it and has acknowledged this is a bad idea))
    if (currentRelic == 0 and itemid ~= nil and gil == 0 and count > 1 and (player:hasItem(itemid+1) == false or (player:hasItem(itemid+1) == true and relicDupe == 1))) then
        eventParams = getRelicParameters(itemid)

        -- Stage 1->2 or 2->3, 3 items + relic itself
        if (count == eventParams[4] and trade:hasItemQty(eventParams[1], 1) and trade:hasItemQty(eventParams[2], 1) and
        trade:hasItemQty(eventParams[3], 1) and trade:hasItemQty(itemid, 1)) then
            tradeOK = true

        -- Stage 3->4, just check for attestation + relic itself
        elseif (count == eventParams[4] and trade:hasItemQty(eventParams[1], 1) and trade:hasItemQty(itemid, 1)) then
            tradeOK = true

        -- Stage 4->5, Shard + Necropschye + relic itself
        elseif (count == eventParams[4] and trade:hasItemQty(eventParams[1], 1) and trade:hasItemQty(eventParams[2], 1) and trade:hasItemQty(itemid, 1)) then
            tradeOK = true
        end

        -- Trade is valid, so set vars, complete trade, and give a CS
        if tradeOK == true then
            player:setCharVar("RELIC_IN_PROGRESS", itemid)
            player:tradeComplete()
            player:startEvent(11, itemid, eventParams[1], eventParams[2], eventParams[3], eventParams[5], eventParams[6], 0, eventParams[8])
        end

    -- Already owns the next stage and hasn't acknowledged this is a bad idea yet.
    elseif (itemid ~= nil and relicDupe ~= 1 and player:hasItem(itemid+1) == true) then
        player:startEvent(20, itemid)

    -- Trading a new relic with one already in progress.  Offer cancellation.
    elseif (currentRelic ~= 0 and itemid ~= nil) then
        player:startEvent(87)

    -- Has turned in a relic and items, has not turned in currency (no wait), so they must be bringing currency, but not 10, 000 piece
    elseif (currentRelic ~= 0 and relicWait == 0 and gil == 0 and itemid~=1451 and itemid~=1454 and itemid~=1457) then
        eventParams = getRelicParameters(currentRelic)

        -- Has currencyamount of currencytype, and nothing additional.  See below for Aegis, since it's different.
        if (count == eventParams[6] and trade:hasItemQty(eventParams[5], eventParams[6])) then
            tradeOK = true

        -- Aegis uses all three currency types for the first 3 stages.  It has currencytype 0 in these situations.
        elseif (count == eventParams[6] * 3 and eventParams[5] == 0) then
            -- Has currencyamount of all three currencies
            if (trade:hasItemQty(1450, eventParams[6]) and trade:hasItemQty(1453, eventParams[6]) and trade:hasItemQty(1456, eventParams[6])) then
                if (eventParams[5] ~= 1451 and eventParams[5] ~= 1454 and eventParams[5] ~= 1457) then -- disallow trade of 10k piece, else the gob will eat it.
                    tradeOK = true
                end
            end
        end

        -- Trade is valid, so set variables, complete the trade, and give a CS to acknowledge it.
        if (tradeOK == true) then

            -- Stage is stored in array value 7

            -- Stage 1->2, wait until next game day
            if (eventParams[7] == 1) then
                player:setCharVar("RELIC_DUE_AT", getVanaMidnight())

            -- Stage 2->3, wait RELIC_2ND_UPGRADE_WAIT_TIME (7200s / 2 hours default)
            elseif (eventParams[7] == 2) then
                player:setCharVar("RELIC_DUE_AT", os.time() + RELIC_2ND_UPGRADE_WAIT_TIME)

            -- Stage 3->4, wait RELIC_3RD_UPGRADE_WAIT_TIME (3600s / 1 hour default)
            elseif (eventParams[7] == 3) then
                player:setCharVar("RELIC_DUE_AT", os.time() + RELIC_3RD_UPGRADE_WAIT_TIME)
            end

            player:tradeComplete()
            player:startEvent(13, currentRelic, eventParams[5], eventParams[6], 0, 0, 0, 0, eventParams[8])
        end
    end

end

function onTrigger(player, npc)
    local itemid = hasRelic(player, 1)
    local eventParams = {} -- item1, item2, item3, num_items, currencytype, currencyamount, finalvar
    local currentRelic = player:getCharVar("RELIC_IN_PROGRESS")
    local relicWait = player:getCharVar("RELIC_DUE_AT") -- Stores time that relic can be retrieved after
    local relicConquest = player:getCharVar("RELIC_CONQUEST_WAIT")

    -- Working on a relic, waiting on completion, and time hasn't passed yet, so tell them to wait longer.
    if (currentRelic ~= 0 and relicWait ~= 0 and relicWait > os.time()) then
        eventParams = getRelicParameters(currentRelic)

        -- Determine cutscene to play by Stage
        if (eventParams[7] == 1) then
            player:startEvent(15, 0, 0, 0, 0, 0, 0, 0, eventParams[8])
        elseif (eventParams[7] == 2) then
            player:startEvent(18, 0, 0, 0, 0, 0, 0, 0, eventParams[8])
        elseif (eventParams[7] == 3) then
            player:startEvent(51, 0, 0, 0, 0, 0, 0, 0, eventParams[8])
        end

    -- Working on a relic, waiting on completion, and time has passed.
    elseif (currentRelic ~= 0 and relicWait ~= 0 and relicWait <= os.time()) then
        eventParams = getRelicParameters(currentRelic)

        -- Determine the cutscene to play by Stage
        if (eventParams[7] == 1) then
            player:startEvent(16, currentRelic, 0, 0, 0, 0, 0, 0, eventParams[8])
        elseif (eventParams[7] == 2) then
            player:startEvent(19, currentRelic, 0, 0, 0, 0, 0, 0, eventParams[8])
        elseif (eventParams[7] == 3) then
            player:startEvent(52, currentRelic, 0, 0, 0, 0, 0, 0, eventParams[8])
        end

    -- Working on a relic and not waiting, so currency is due
    elseif (currentRelic ~= 0 and relicWait == 0) then
        eventParams = getRelicParameters(currentRelic)
        player:startEvent(12, currentRelic, eventParams[5], eventParams[6], 0, 0, 0, 0, eventParams[8])

    -- No relic, or waiting until next conquest tally.
    elseif (itemid == nil or relicConquest > os.time()) then
        player:startEvent(10)

    -- Found a relic and conquest tally is not due (0, or passed), time to explain a stage
    elseif (itemid ~= nil and relicConquest <= os.time()) then
        eventParams = getRelicParameters(itemid)

        -- Determine stage based on eventParams[7]
        if (eventParams[7] == 1) then
            player:startEvent(14, itemid, eventParams[1], eventParams[2], eventParams[3], 0, 0, 0, eventParams[8])
        elseif (eventParams[7] == 2) then
            player:startEvent(17, itemid, eventParams[1], eventParams[2], eventParams[3], 0, 0, 0, eventParams[8])
        elseif (eventParams[7] == 3) then
            player:startEvent(50, itemid, eventParams[1], 0, 0, 0, 0, 0, eventParams[8])

        -- Stage 4 logic starts here.  Every weapon has its own cutscene.
        elseif (eventParams[7] == 4) then
            switch (itemid): caseof
            { -- Fragment for body, Necropsyche for soul
                [18263] = function (x) player:startEvent(68, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Spharai
                [18269] = function (x) player:startEvent(69, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Mandau
                [18275] = function (x) player:startEvent(70, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Excalibur
                [18281] = function (x) player:startEvent(71, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Ragnarok
                [18287] = function (x) player:startEvent(72, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Guttler
                [18293] = function (x) player:startEvent(73, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Bravura
                [18299] = function (x) player:startEvent(75, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Gungnir
                [18305] = function (x) player:startEvent(74, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Apocalypse
                [18311] = function (x) player:startEvent(76, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Kikoku
                [18317] = function (x) player:startEvent(77, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Amanomurakumo
                [18323] = function (x) player:startEvent(78, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Mjollnir
                [18329] = function (x) player:startEvent(79, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Claustrum
                [18335] = function (x) player:startEvent(81, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Annihilator
                [18341] = function (x) player:startEvent(82, eventParams[2], eventParams[1], eventParams[5], eventParams[6], itemid); end, -- Gjallarhorn
                [18347] = function (x) player:startEvent(80, eventParams[1], eventParams[2], eventParams[5], eventParams[6], itemid); end, -- Yoichinoyumi
                [15069] = function (x) player:startEvent(86, eventParams[2], eventParams[1], eventParams[5], eventParams[6], itemid); end, -- Aegis
            }
        end

    -- Should never happen, but should be here just in case.
    else
        player:startEvent(10)
    end
end

function onEventUpdate(player, csid, option)
    -- printf("Update CSID: %u", csid)
    -- printf("Update RESULT: %u", option)

    -- Handles the displayed currency types and amounts for Aegis Stage 1->2, 2->3, and 3->4 based on option.
    if ((csid == 11 or csid == 12 or csid == 13) and option ~= 0) then
        if (option == 1) then
            player:updateEvent(15066, 1453, 1, 1456, 1, 1450, 1)
        elseif (option == 2) then
            player:updateEvent(15067, 1453, 4, 1456, 4, 1450, 4)
        elseif (option == 3) then
            player:updateEvent(15068, 1453, 20, 1456, 20, 1450, 20)
        end
    end
end

function onEventFinish(player, csid, option)
    -- printf("Finish CSID: %u", csid)
    -- printf("Finish RESULT: %u", option)

    local reward = player:getCharVar("RELIC_IN_PROGRESS")

    -- User is cancelling a relic.  Null everything out, it never happened.
    if (csid == 87 and option == 666) then
        player:setCharVar("RELIC_IN_PROGRESS", 0)
        player:setCharVar("RELIC_DUE_AT", 0)
        player:setCharVar("RELIC_MAKE_ANOTHER", 0)
        player:setCharVar("RELIC_CONQUEST_WAIT", 0)

    -- User is okay with making a relic they cannot possibly accept
    elseif (csid == 20 and option == 1) then
        player:setCharVar("RELIC_MAKE_ANOTHER", 1)

    -- Picking up a finished relic stage 1>2 and 2>3.
    elseif ((csid == 16 or csid == 19) and reward ~= 0) then
        if (player:getFreeSlotsCount() < 1) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward+1)
        else
            player:addItem(reward+1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, reward+1)
            player:setCharVar("RELIC_IN_PROGRESS", 0)
            player:setCharVar("RELIC_DUE_AT", 0)
            player:setCharVar("RELIC_MAKE_ANOTHER", 0)
            player:setCharVar("RELIC_CONQUEST_WAIT", getConquestTally())
        end
    -- Picking up a finished relic stage 3>4.
    elseif (csid == 52 and reward ~= 0) then
        if (player:getFreeSlotsCount() < 1) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward+1)
        else
            player:addItem(reward+1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, reward+1)
            player:setCharVar("RELIC_IN_PROGRESS", 0)
            player:setCharVar("RELIC_DUE_AT", 0)
            player:setCharVar("RELIC_MAKE_ANOTHER", 0)
            player:setCharVar("RELIC_CONQUEST_WAIT", 0)
        end

    -- Stage 4 cutscenes
    elseif ((csid >= 68 and csid <= 82) or csid == 86) then
        player:setCharVar("RELIC_CONQUEST_WAIT", 0)
        switch (csid): caseof
        {
            [68] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18263); end, -- Spharai
            [69] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18269); end, -- Mandau
            [70] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18275); end, -- Excalibur
            [71] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18281); end, -- Ragnarok
            [72] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18287); end, -- Guttler
            [73] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18293); end, -- Bravura
            [75] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18299); end, -- Gungnir
            [74] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18305); end, -- Apocalypse
            [76] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18311); end, -- Kikoku
            [77] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18317); end, -- Amanomurakumo
            [78] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18323); end, -- Mjollnir
            [79] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18329); end, -- Claustrum
            [81] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18335); end, -- Annihilator
            [82] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18341); end, -- Gjallarhorn
            [80] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 18347); end, -- Yoichinoyumi
            [86] = function (x) player:setCharVar("RELIC_IN_PROGRESS", 15069); end, -- Aegis
        }
    end
end
