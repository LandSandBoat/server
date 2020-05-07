--------------------------------------------------------
require("scripts/globals/settings")
-------------------------------------------------------

tpz = tpz or {}
tpz.mystery = tpz.mystery or {}

local adoulinOptionOff = 0x80
local pictlogicaOptionOff = 0x100
local wantedOptionOff = 0x1000
local hideOptionFlags = adoulinOptionOff + pictlogicaOptionOff + wantedOptionOff
local costs =
{
    [1] = 10,
    [2] = 10,
    [3] = 10,
    [4] = 10,
    [5] = 10,
    [6] = 50
}
local keyToDial =
{
    [8973] = 6,  -- special dial
    [9217] = 9,  -- abjuration
    [9218] = 10, -- fortune
  --[????] = 11, -- furnishing
    [9274] = 13, -- anniversary
}
local abjurationItems =
{
    1314,1315,1316,1317,1318, -- dryadic
    1319,1320,1321,1322,1323, -- earthen
    1324,1325,1326,1327,1328, -- aquarian
    1329,1330,1331,1332,1333, -- martial
    1334,1335,1336,1337,1338, -- wyrmal
    1339,1340,1341,1342,1343, -- neptunal
    1441,1442,                -- food
    2429,2430,2431,2432,2433, -- phantasmal
    2434,2435,2436,2437,2438, -- hadean
    3559,3560,3561,3562,3563, -- corvine
    3564,3565,3566,3567,3568, -- supernal
    3569,3570,3571,3572,3573, -- transitory
    3574,3575,3576,3577,3578, -- foreboding
    3579,3580,3581,3582,3583, -- lenitive
    8762,8763,8764,8765,8766, -- bushin
    8767,8768,8769,8770,8771, -- vale
    8772,8773,8774,8775,8776, -- grove
    8777,8778,8779,8780,8781, -- triton
    8782,8783,8784,8785,8786, -- shinryu
    8787,8788,8789,8790,8791, -- abyssal
    9105,9106,9107,9108,9109, -- cronian
    9110,9111,9112,9113,9114, -- arean
    9115,9116,9117,9118,9119, -- jovian
    9120,9121,9122,9123,9124, -- venerian
    9125,9126,9127,9128,9129, -- cyllenian
}
local fortuneItems =
{
    5737,5736, -- alexandrite
    6180,6183,6532, -- pluton
    6181,6184,6535, -- beitetsu
    6182,6185,6534, -- rift boulder
    5854,5855,5856,5857,5858, -- frayed pouches
    5109,5110,5111,5112,5946,5947,6264,6345,6346,6370,6486,6487,6488 -- frayed sacks
}
local anniversaryItems =
{
    9274 -- just give them back their key until this table can be populated
}
local gobbieJunk =
{
    507,
    508,
    510,
    511,
    566,
    568,
    1239,
    1868,
    2542,
    2543,
    4539,
    4543,
    9777,
    15203,
    18180,
    19220
}
tpz.mystery.onTrade = function (player, npc, trade, events)
    if trade:getItemCount() == 1 then
        local tradeID = trade:getItemId(0)
        if keyToDial[tradeID] ~= nil then
            if player:getFreeSlotsCount() == 0 then
                player:startEvent(events.FULL_INV, tradeID, keyToDial[tradeID])
                return false
            end
            player:setLocalVar("gobbieBoxKey", tradeID)
            player:startEvent(events.KEY_TRADE, tradeID, keyToDial[tradeID])
        else -- trade for points
            return false
        end
    else
        return false
    end
end

tpz.mystery.onTrigger = function (player, npc, events)
    local event = events
    local playerAgeDays = (os.time() - player:getTimeCreated()) / 86400
    local dailyTallyPoints = player:getCurrency("daily_tally")
    local firstVisit = dailyTallyPoints == -1
    local gobbieBoxUsed = player:getCharVar("gobbieBoxUsed")
    local specialDialUsed = player:getMaskBit(gobbieBoxUsed, 0) and 1 or 0
    local adoulinDialUsed = player:getMaskBit(gobbieBoxUsed, 1) and 1 or 0
    local pictlogicaDialUsed = player:getMaskBit(gobbieBoxUsed, 2) and 1 or 0
    local wantedDialUsed = player:getMaskBit(gobbieBoxUsed, 3) and 1 or 0
    local holdingItem = player:getCharVar("gobbieBoxHoldingItem")

    if playerAgeDays >= GOBBIE_BOX_MIN_AGE and firstVisit then
        player:startEvent(event.INTRO)
    elseif playerAgeDays >= GOBBIE_BOX_MIN_AGE then
        if holdingItem ~= 0 then
            player:startEvent(event.HOLDING_ITEM)
        else
            player:startEvent(event.DEFAULT, specialDialUsed, adoulinDialUsed, pictlogicaDialUsed, wantedDialUsed, 0, 0, hideOptionFlags, dailyTallyPoints)
        end
    else
        player:messageSpecial(zones[player:getZoneID()].text.YOU_MUST_WAIT_ANOTHER_N_DAYS, GOBBIE_BOX_MIN_AGE - playerAgeDays)
    end
end

tpz.mystery.onEventUpdate = function (player, csid, option, events)
    local event = events
    local dailyTallyPoints = player:getCurrency("daily_tally")
    local holdingItem = player:getCharVar("gobbieBoxHoldingItem")
    local gobbieBoxUsed = player:getCharVar("gobbieBoxUsed")
    local specialDialUsed = player:getMaskBit(gobbieBoxUsed, 0) and 1 or 0
    local adoulinDialUsed = player:getMaskBit(gobbieBoxUsed, 1) and 1 or 0
    local pictlogicaDialUsed = player:getMaskBit(gobbieBoxUsed, 2) and 1 or 0
    local wantedDialUsed = player:getMaskBit(gobbieBoxUsed, 3) and 1 or 0
    local itemID = 0

    if csid == event.KEY_TRADE then
        if option == 1 then
            local keyID = player:getLocalVar("gobbieBoxKey")
            player:setLocalVar("gobbieBoxKey", 0)
            switch (keyToDial[keyID]): caseof
            {
                [6] = function() itemID = SelectDailyItem(player, 6) end,  -- special dial
                [9] = function() -- abjuration
                    itemID = abjurationItems[math.random(1, #abjurationItems)]
                    if player:hasItem(itemID) then
                        itemID = gobbieJunk[math.random(1, #gobbieJunk)]
                    end
                end,
                [10] = function() itemID = fortuneItems[math.random(1, #fortuneItems)] end, -- fortune
              --[??] = function()  end, -- furnishing
                [13] = function()-- anniversary
                    if math.random(1,100) == 1 then -- 1% chance for ANV exclusive item?
                        itemID = anniversaryItems[math.random(1, #anniversaryItems)] 
                    else
                        itemID = SelectDailyItem(player, 6)
                    end
                end
            }
            player:setCharVar("gobbieBoxHoldingItem", itemID)
            player:tradeComplete()
            player:updateEvent(itemID, keyToDial[keyID], 3)
        elseif option == 2 then
            if holdingItem > 0 and npcUtil.giveItem(player, holdingItem) then
                player:setCharVar("gobbieBoxHoldingItem", 0)
            end
            player:updateEvent(itemID, 0)
        end
    elseif csid == event.DEFAULT then
        if option == 4 then
            player:updateEvent(SelectDailyItem(player, 6), SelectDailyItem(player, 6), SelectDailyItem(player, 6), 0, 0, 0, 0, dailyTallyPoints) -- peek
        else
            local dial = math.floor(option / 8)
            local option_type = option % 8
            local dial_used = false
            local dial_cost = costs[dial]
            local dial_mask = false
            if dial >= 6 then
                dial_mask = dial - 6
                dial_used = player:getMaskBit(gobbieBoxUsed, dial_mask)
            end
            switch (option_type): caseof
            {
                [1] = function()
                    if dial_used then
                        player:updateEvent(1, dial, 2) -- already used this dial
                    elseif dailyTallyPoints >= dial_cost then
                        itemID = SelectDailyItem(player, dial)
                        player:setCharVar("gobbieBoxHoldingItem", itemID)
                        player:setCurrency("daily_tally", dailyTallyPoints - dial_cost)
                        if dial_mask then
                            player:setMaskBit(gobbieBoxUsed, "gobbieBoxUsed", dial_mask, true)
                        end
                        player:updateEvent(itemID, dial, 0)
                    else
                        player:updateEvent(1, dial, 1) -- not enough points
                    end
                end,
                [2] = function()
                    if player:getFreeSlotsCount() == 0 then
                        player:updateEvent(holdingItem, 0, 0, 1) -- inventory full, exit event
                        player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED + 2) -- generic "Cannot obtain the item."
                    end
                end,
                [5] = function()
                    if holdingItem > 0 and npcUtil.giveItem(player, holdingItem) then
                        player:setCharVar("gobbieBoxHoldingItem", 0)
                    end
                    player:updateEvent(specialDialUsed, adoulinDialUsed, pictlogicaDialUsed, wantedDialUsed, 0, 0, hideOptionFlags, dailyTallyPoints)
                end,
            }
        end
    end
end

tpz.mystery.onEventFinish = function (player, csid, option, events)
    local event = events
    if csid == event.INTRO then
        player:setCurrency("daily_tally", 50)
    elseif csid == event.HOLDING_ITEM then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED + 2) -- generic "Cannot obtain the item."
        elseif npcUtil.giveItem(player, player:getCharVar("gobbieBoxHoldingItem")) then
            player:setCharVar("gobbieBoxHoldingItem", 0)
        end
    end
end
