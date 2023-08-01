-----------------------------------
require("scripts/globals/utils")
-----------------------------------

xi = xi or {}
xi.mystery = xi.mystery or {}

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
--  [????] = 11, -- furnishing
    [9274] = 13, -- anniversary
}

local abjurationItems =
{
    xi.items.DRYADIC_ABJURATION_HEAD,
    xi.items.DRYADIC_ABJURATION_BODY,
    xi.items.DRYADIC_ABJURATION_HANDS,
    xi.items.DRYADIC_ABJURATION_LEGS,
    xi.items.DRYADIC_ABJURATION_FEET,
    xi.items.EARTHEN_ABJURATION_HEAD,
    xi.items.EARTHEN_ABJURATION_BODY,
    xi.items.EARTHEN_ABJURATION_HANDS,
    xi.items.EARTHEN_ABJURATION_LEGS,
    xi.items.EARTHEN_ABJURATION_FEET,
    xi.items.AQUARIAN_ABJURATION_HEAD,
    xi.items.AQUARIAN_ABJURATION_BODY,
    xi.items.AQUARIAN_ABJURATION_HANDS,
    xi.items.AQUARIAN_ABJURATION_LEGS,
    xi.items.AQUARIAN_ABJURATION_FEET,
    xi.items.MARTIAL_ABJURATION_HEAD,
    xi.items.MARTIAL_ABJURATION_BODY,
    xi.items.MARTIAL_ABJURATION_HANDS,
    xi.items.MARTIAL_ABJURATION_LEGS,
    xi.items.MARTIAL_ABJURATION_FEET,
    xi.items.WYRMAL_ABJURATION_HEAD,
    xi.items.WYRMAL_ABJURATION_BODY,
    xi.items.WYRMAL_ABJURATION_HANDS,
    xi.items.WYRMAL_ABJURATION_LEGS,
    xi.items.WYRMAL_ABJURATION_FEET,
    xi.items.NEPTUNAL_ABJURATION_HEAD,
    xi.items.NEPTUNAL_ABJURATION_BODY,
    xi.items.NEPTUNAL_ABJURATION_HANDS,
    xi.items.NEPTUNAL_ABJURATION_LEGS,
    xi.items.NEPTUNAL_ABJURATION_FEET,
    xi.items.LIBATION_ABJURATION,
    xi.items.OBLATION_ABJURATION,
    xi.items.PHANTASMAL_ABJURATION_HEAD,
    xi.items.PHANTASMAL_ABJURATION_BODY,
    xi.items.PHANTASMAL_ABJURATION_HANDS,
    xi.items.PHANTASMAL_ABJURATION_LEGS,
    xi.items.PHANTASMAL_ABJURATION_FEET,
    xi.items.HADEAN_ABJURATION_HEAD,
    xi.items.HADEAN_ABJURATION_BODY,
    xi.items.HADEAN_ABJURATION_HANDS,
    xi.items.HADEAN_ABJURATION_LEGS,
    xi.items.HADEAN_ABJURATION_FEET,
    xi.items.CORVINE_ABJURATION_HEAD,
    xi.items.CORVINE_ABJURATION_BODY,
    xi.items.CORVINE_ABJURATION_HANDS,
    xi.items.CORVINE_ABJURATION_LEGS,
    xi.items.CORVINE_ABJURATION_FEET,
    xi.items.SUPERNAL_ABJURATION_HEAD,
    xi.items.SUPERNAL_ABJURATION_BODY,
    xi.items.SUPERNAL_ABJURATION_HANDS,
    xi.items.SUPERNAL_ABJURATION_LEGS,
    xi.items.SUPERNAL_ABJURATION_FEET,
    xi.items.TRANSITORY_ABJURATION_HEAD,
    xi.items.TRANSITORY_ABJURATION_BODY,
    xi.items.TRANSITORY_ABJURATION_HANDS,
    xi.items.TRANSITORY_ABJURATION_LEGS,
    xi.items.TRANSITORY_ABJURATION_FEET,
    xi.items.FOREBODING_ABJURATION_HEAD,
    xi.items.FOREBODING_ABJURATION_BODY,
    xi.items.FOREBODING_ABJURATION_HANDS,
    xi.items.FOREBODING_ABJURATION_LEGS,
    xi.items.FOREBODING_ABJURATION_FEET,
    xi.items.LENITIVE_ABJURATION_HEAD,
    xi.items.LENITIVE_ABJURATION_BODY,
    xi.items.LENITIVE_ABJURATION_HANDS,
    xi.items.LENITIVE_ABJURATION_LEGS,
    xi.items.LENITIVE_ABJURATION_FEET,
    xi.items.BUSHIN_ABJURATION_HEAD,
    xi.items.BUSHIN_ABJURATION_BODY,
    xi.items.BUSHIN_ABJURATION_HANDS,
    xi.items.BUSHIN_ABJURATION_LEGS,
    xi.items.BUSHIN_ABJURATION_FEET,
    xi.items.VALE_ABJURATION_HEAD,
    xi.items.VALE_ABJURATION_BODY,
    xi.items.VALE_ABJURATION_HANDS,
    xi.items.VALE_ABJURATION_LEGS,
    xi.items.VALE_ABJURATION_FEET,
    xi.items.GROVE_ABJURATION_HEAD,
    xi.items.GROVE_ABJURATION_BODY,
    xi.items.GROVE_ABJURATION_HANDS,
    xi.items.GROVE_ABJURATION_LEGS,
    xi.items.GROVE_ABJURATION_FEET,
    xi.items.TRITON_ABJURATION_HEAD,
    xi.items.TRITON_ABJURATION_BODY,
    xi.items.TRITON_ABJURATION_HANDS,
    xi.items.TRITON_ABJURATION_LEGS,
    xi.items.TRITON_ABJURATION_FEET,
    xi.items.SHINRYU_ABJURATION_HEAD,
    xi.items.SHINRYU_ABJURATION_BODY,
    xi.items.SHINRYU_ABJURATION_HANDS,
    xi.items.SHINRYU_ABJURATION_LEGS,
    xi.items.SHINRYU_ABJURATION_FEET,
    xi.items.ABYSSAL_ABJURATION_HEAD,
    xi.items.ABYSSAL_ABJURATION_BODY,
    xi.items.ABYSSAL_ABJURATION_HANDS,
    xi.items.ABYSSAL_ABJURATION_LEGS,
    xi.items.ABYSSAL_ABJURATION_FEET,
    xi.items.CRONIAN_ABJURATION_HEAD,
    xi.items.CRONIAN_ABJURATION_BODY,
    xi.items.CRONIAN_ABJURATION_HANDS,
    xi.items.CRONIAN_ABJURATION_LEGS,
    xi.items.CRONIAN_ABJURATION_FEET,
    xi.items.AREAN_ABJURATION_HEAD,
    xi.items.AREAN_ABJURATION_BODY,
    xi.items.AREAN_ABJURATION_HANDS,
    xi.items.AREAN_ABJURATION_LEGS,
    xi.items.AREAN_ABJURATION_FEET,
    xi.items.JOVIAN_ABJURATION_HEAD,
    xi.items.JOVIAN_ABJURATION_BODY,
    xi.items.JOVIAN_ABJURATION_HANDS,
    xi.items.JOVIAN_ABJURATION_LEGS,
    xi.items.JOVIAN_ABJURATION_FEET,
    xi.items.VENERIAN_ABJURATION_HEAD,
    xi.items.VENERIAN_ABJURATION_BODY,
    xi.items.VENERIAN_ABJURATION_HANDS,
    xi.items.VENERIAN_ABJURATION_LEGS,
    xi.items.VENERIAN_ABJURATION_FEET,
    xi.items.CYLLENIAN_ABJURATION_HEAD,
    xi.items.CYLLENIAN_ABJURATION_BODY,
    xi.items.CYLLENIAN_ABJURATION_HANDS,
    xi.items.CYLLENIAN_ABJURATION_LEGS,
    xi.items.CYLLENIAN_ABJURATION_FEET,
}

local fortuneItems =
{
    xi.items.FRAYED_POUCH_OF_BIRTH,
    xi.items.FRAYED_POUCH_OF_ADVANCEMENT,
    xi.items.FRAYED_POUCH_OF_GLORY,
    xi.items.FRAYED_POUCH_OF_DECAY,
    xi.items.FRAYED_POUCH_OF_RUIN,
    xi.items.FRAYED_SACK_OF_ABUNDANCE_P1,
    xi.items.FRAYED_SACK_OF_ABUNDANCE_P2,
    xi.items.FRAYED_SACK_OF_MORTALITY_P1,
    xi.items.FRAYED_SACK_OF_MORTALITY_P2,
    xi.items.FRAYED_SACK_OF_DEVIOUSNESS,
    xi.items.FRAYED_SACK_OF_LIMINALITY,
    xi.items.COTTON_COIN_PURSE,
    xi.items.LINEN_COIN_PURSE,
    xi.items.PLUTON_CASE,
    xi.items.BEITETSU_PARCEL,
    xi.items.BOULDER_CASE,
    xi.items.PLUTON_BOX,
    xi.items.BEITETSU_BOX,
    xi.items.BOULDER_BOX,
    xi.items.FRAYED_SACK_OF_HORROR_P1,
    xi.items.FRAYED_SACK_OF_HORROR_P2,
    xi.items.FRAYED_SACK_OF_BEAUTY,
    xi.items.FRAYED_SACK_OF_SPLENDOR,
    xi.items.FRAYED_SACK_OF_FECUNDITY,
    xi.items.FRAYED_SACK_OF_PLENTY,
    xi.items.FRAYED_SACK_OF_OPULENCE,
    xi.items.AGED_BOX_BAYLD,
    xi.items.HEAVY_METAL_POUCH,
}
local anniversaryItems =
{
    -- TODO: The anniversary item table needs to be populated
    xi.items.DIAL_KEY_ANV, -- just give them back their key until this table can be populated
}

local gobbieJunk =
{
    xi.items.GOBLIN_MESS_TIN,
    xi.items.GOBLIN_WEEL,
    xi.items.CHUNK_OF_HOBGOBLIN_CHOCOLATE,
    xi.items.HOBGOBLIN_PIE,
    xi.items.LOAF_OF_HOBGOBLIN_BREAD,
    xi.items.LOAF_OF_GOBLIN_BREAD,
    xi.items.CHUNK_OF_GOBLIN_CHOCOLATE,
    xi.items.GOBLIN_PIE,
}

xi.mystery.onTrade = function(player, npc, trade, events)
    if trade:getItemCount() == 1 then
        local tradeID = trade:getItemId(0)
        if keyToDial[tradeID] ~= nil then
            -- TODO: Without campaigns, there's currently no method for obtaining keys
            if player:getFreeSlotsCount() == 0 then
                player:startEvent(events.FULL_INV, tradeID, keyToDial[tradeID])
                return false
            end

            player:setLocalVar("gobbieBoxKey", tradeID)
            player:startEvent(events.KEY_TRADE, tradeID, keyToDial[tradeID])
        else -- trade for points
            -- TODO: Point system needs to be defined
            return false
        end
    else
        return false
    end
end

xi.mystery.onTrigger = function(player, npc, events)
    local event = events
    local playerAgeDays = (os.time() - player:getTimeCreated()) / 86400
    local dailyTallyPoints = player:getCurrency("daily_tally")
    local firstVisit = dailyTallyPoints == -1
    local gobbieBoxUsed = player:getCharVar("gobbieBoxUsed")
    local specialDialUsed = utils.mask.getBit(gobbieBoxUsed, 0) and 1 or 0
    local adoulinDialUsed = utils.mask.getBit(gobbieBoxUsed, 1) and 1 or 0
    local pictlogicaDialUsed = utils.mask.getBit(gobbieBoxUsed, 2) and 1 or 0
    local wantedDialUsed = utils.mask.getBit(gobbieBoxUsed, 3) and 1 or 0
    local holdingItem = player:getCharVar("gobbieBoxHoldingItem")

    if playerAgeDays >= xi.settings.main.GOBBIE_BOX_MIN_AGE and firstVisit then
        player:startEvent(event.INTRO)
    elseif playerAgeDays >= xi.settings.main.GOBBIE_BOX_MIN_AGE then
        if holdingItem ~= 0 then
            player:startEvent(event.HOLDING_ITEM)
        else
            player:startEvent(event.DEFAULT, specialDialUsed, adoulinDialUsed, pictlogicaDialUsed, wantedDialUsed, 0, 0, hideOptionFlags, dailyTallyPoints)
        end
    else
        player:messageSpecial(zones[player:getZoneID()].text.YOU_MUST_WAIT_ANOTHER_N_DAYS, xi.settings.main.GOBBIE_BOX_MIN_AGE - playerAgeDays + 1)
    end
end

xi.mystery.onEventUpdate = function(player, csid, option, events)
    local event = events
    local dailyTallyPoints = player:getCurrency("daily_tally")
    local holdingItem = player:getCharVar("gobbieBoxHoldingItem")
    local gobbieBoxUsed = player:getCharVar("gobbieBoxUsed")
    local specialDialUsed = utils.mask.getBit(gobbieBoxUsed, 0) and 1 or 0
    local adoulinDialUsed = utils.mask.getBit(gobbieBoxUsed, 1) and 1 or 0
    local pictlogicaDialUsed = utils.mask.getBit(gobbieBoxUsed, 2) and 1 or 0
    local wantedDialUsed = utils.mask.getBit(gobbieBoxUsed, 3) and 1 or 0
    local itemID = 0

    if csid == event.KEY_TRADE then
        if option == 1 then
            local keyID = player:getLocalVar("gobbieBoxKey")
            player:setLocalVar("gobbieBoxKey", 0)
            switch (keyToDial[keyID]): caseof
            {
                [6] = function()
                    itemID = SelectDailyItem(player, 6)
                end,  -- special dial

                [9] = function() -- abjuration
                    itemID = abjurationItems[math.random(1, #abjurationItems)]
                    if player:hasItem(itemID) then
                        itemID = gobbieJunk[math.random(1, #gobbieJunk)]
                    end
                end,

                [10] = function()
                    itemID = fortuneItems[math.random(1, #fortuneItems)]
                end, -- fortune

            --  [??] = function()  end, -- furnishing

                [13] = function()-- anniversary
                    if math.random(1, 100) == 1 then -- 1% chance for ANV exclusive item?
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
            local optionType = option % 8
            local dialUsed = false
            local dialCost = costs[dial]
            local dialMask = false

            if dial >= 6 then
                dialMask = dial - 6
                dialUsed = utils.mask.getBit(gobbieBoxUsed, dialMask)
            end

            switch (optionType): caseof
            {
                [1] = function()
                    if dialUsed then
                        player:updateEvent(1, dial, 2) -- already used this dial
                    elseif dailyTallyPoints >= dialCost then
                        itemID = SelectDailyItem(player, dial)
                        player:setCharVar("gobbieBoxHoldingItem", itemID)
                        player:setCurrency("daily_tally", dailyTallyPoints - dialCost)
                        if dialMask then
                            player:setCharVar("gobbieBoxUsed", utils.mask.setBit(gobbieBoxUsed, dialMask, true))
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

xi.mystery.onEventFinish = function(player, csid, option, events)
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
