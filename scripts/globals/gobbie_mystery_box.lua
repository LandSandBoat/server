-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.gobbieMysteryBox = xi.gobbieMysteryBox or {}

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
    xi.item.DRYADIC_ABJURATION_HEAD,
    xi.item.DRYADIC_ABJURATION_BODY,
    xi.item.DRYADIC_ABJURATION_HANDS,
    xi.item.DRYADIC_ABJURATION_LEGS,
    xi.item.DRYADIC_ABJURATION_FEET,
    xi.item.EARTHEN_ABJURATION_HEAD,
    xi.item.EARTHEN_ABJURATION_BODY,
    xi.item.EARTHEN_ABJURATION_HANDS,
    xi.item.EARTHEN_ABJURATION_LEGS,
    xi.item.EARTHEN_ABJURATION_FEET,
    xi.item.AQUARIAN_ABJURATION_HEAD,
    xi.item.AQUARIAN_ABJURATION_BODY,
    xi.item.AQUARIAN_ABJURATION_HANDS,
    xi.item.AQUARIAN_ABJURATION_LEGS,
    xi.item.AQUARIAN_ABJURATION_FEET,
    xi.item.MARTIAL_ABJURATION_HEAD,
    xi.item.MARTIAL_ABJURATION_BODY,
    xi.item.MARTIAL_ABJURATION_HANDS,
    xi.item.MARTIAL_ABJURATION_LEGS,
    xi.item.MARTIAL_ABJURATION_FEET,
    xi.item.WYRMAL_ABJURATION_HEAD,
    xi.item.WYRMAL_ABJURATION_BODY,
    xi.item.WYRMAL_ABJURATION_HANDS,
    xi.item.WYRMAL_ABJURATION_LEGS,
    xi.item.WYRMAL_ABJURATION_FEET,
    xi.item.NEPTUNAL_ABJURATION_HEAD,
    xi.item.NEPTUNAL_ABJURATION_BODY,
    xi.item.NEPTUNAL_ABJURATION_HANDS,
    xi.item.NEPTUNAL_ABJURATION_LEGS,
    xi.item.NEPTUNAL_ABJURATION_FEET,
    xi.item.LIBATION_ABJURATION,
    xi.item.OBLATION_ABJURATION,
    xi.item.PHANTASMAL_ABJURATION_HEAD,
    xi.item.PHANTASMAL_ABJURATION_BODY,
    xi.item.PHANTASMAL_ABJURATION_HANDS,
    xi.item.PHANTASMAL_ABJURATION_LEGS,
    xi.item.PHANTASMAL_ABJURATION_FEET,
    xi.item.HADEAN_ABJURATION_HEAD,
    xi.item.HADEAN_ABJURATION_BODY,
    xi.item.HADEAN_ABJURATION_HANDS,
    xi.item.HADEAN_ABJURATION_LEGS,
    xi.item.HADEAN_ABJURATION_FEET,
    xi.item.CORVINE_ABJURATION_HEAD,
    xi.item.CORVINE_ABJURATION_BODY,
    xi.item.CORVINE_ABJURATION_HANDS,
    xi.item.CORVINE_ABJURATION_LEGS,
    xi.item.CORVINE_ABJURATION_FEET,
    xi.item.SUPERNAL_ABJURATION_HEAD,
    xi.item.SUPERNAL_ABJURATION_BODY,
    xi.item.SUPERNAL_ABJURATION_HANDS,
    xi.item.SUPERNAL_ABJURATION_LEGS,
    xi.item.SUPERNAL_ABJURATION_FEET,
    xi.item.TRANSITORY_ABJURATION_HEAD,
    xi.item.TRANSITORY_ABJURATION_BODY,
    xi.item.TRANSITORY_ABJURATION_HANDS,
    xi.item.TRANSITORY_ABJURATION_LEGS,
    xi.item.TRANSITORY_ABJURATION_FEET,
    xi.item.FOREBODING_ABJURATION_HEAD,
    xi.item.FOREBODING_ABJURATION_BODY,
    xi.item.FOREBODING_ABJURATION_HANDS,
    xi.item.FOREBODING_ABJURATION_LEGS,
    xi.item.FOREBODING_ABJURATION_FEET,
    xi.item.LENITIVE_ABJURATION_HEAD,
    xi.item.LENITIVE_ABJURATION_BODY,
    xi.item.LENITIVE_ABJURATION_HANDS,
    xi.item.LENITIVE_ABJURATION_LEGS,
    xi.item.LENITIVE_ABJURATION_FEET,
    xi.item.BUSHIN_ABJURATION_HEAD,
    xi.item.BUSHIN_ABJURATION_BODY,
    xi.item.BUSHIN_ABJURATION_HANDS,
    xi.item.BUSHIN_ABJURATION_LEGS,
    xi.item.BUSHIN_ABJURATION_FEET,
    xi.item.VALE_ABJURATION_HEAD,
    xi.item.VALE_ABJURATION_BODY,
    xi.item.VALE_ABJURATION_HANDS,
    xi.item.VALE_ABJURATION_LEGS,
    xi.item.VALE_ABJURATION_FEET,
    xi.item.GROVE_ABJURATION_HEAD,
    xi.item.GROVE_ABJURATION_BODY,
    xi.item.GROVE_ABJURATION_HANDS,
    xi.item.GROVE_ABJURATION_LEGS,
    xi.item.GROVE_ABJURATION_FEET,
    xi.item.TRITON_ABJURATION_HEAD,
    xi.item.TRITON_ABJURATION_BODY,
    xi.item.TRITON_ABJURATION_HANDS,
    xi.item.TRITON_ABJURATION_LEGS,
    xi.item.TRITON_ABJURATION_FEET,
    xi.item.SHINRYU_ABJURATION_HEAD,
    xi.item.SHINRYU_ABJURATION_BODY,
    xi.item.SHINRYU_ABJURATION_HANDS,
    xi.item.SHINRYU_ABJURATION_LEGS,
    xi.item.SHINRYU_ABJURATION_FEET,
    xi.item.ABYSSAL_ABJURATION_HEAD,
    xi.item.ABYSSAL_ABJURATION_BODY,
    xi.item.ABYSSAL_ABJURATION_HANDS,
    xi.item.ABYSSAL_ABJURATION_LEGS,
    xi.item.ABYSSAL_ABJURATION_FEET,
    xi.item.CRONIAN_ABJURATION_HEAD,
    xi.item.CRONIAN_ABJURATION_BODY,
    xi.item.CRONIAN_ABJURATION_HANDS,
    xi.item.CRONIAN_ABJURATION_LEGS,
    xi.item.CRONIAN_ABJURATION_FEET,
    xi.item.AREAN_ABJURATION_HEAD,
    xi.item.AREAN_ABJURATION_BODY,
    xi.item.AREAN_ABJURATION_HANDS,
    xi.item.AREAN_ABJURATION_LEGS,
    xi.item.AREAN_ABJURATION_FEET,
    xi.item.JOVIAN_ABJURATION_HEAD,
    xi.item.JOVIAN_ABJURATION_BODY,
    xi.item.JOVIAN_ABJURATION_HANDS,
    xi.item.JOVIAN_ABJURATION_LEGS,
    xi.item.JOVIAN_ABJURATION_FEET,
    xi.item.VENERIAN_ABJURATION_HEAD,
    xi.item.VENERIAN_ABJURATION_BODY,
    xi.item.VENERIAN_ABJURATION_HANDS,
    xi.item.VENERIAN_ABJURATION_LEGS,
    xi.item.VENERIAN_ABJURATION_FEET,
    xi.item.CYLLENIAN_ABJURATION_HEAD,
    xi.item.CYLLENIAN_ABJURATION_BODY,
    xi.item.CYLLENIAN_ABJURATION_HANDS,
    xi.item.CYLLENIAN_ABJURATION_LEGS,
    xi.item.CYLLENIAN_ABJURATION_FEET,
}

local fortuneItems =
{
    xi.item.FRAYED_POUCH_OF_BIRTH,
    xi.item.FRAYED_POUCH_OF_ADVANCEMENT,
    xi.item.FRAYED_POUCH_OF_GLORY,
    xi.item.FRAYED_POUCH_OF_DECAY,
    xi.item.FRAYED_POUCH_OF_RUIN,
    xi.item.FRAYED_SACK_OF_ABUNDANCE_P1,
    xi.item.FRAYED_SACK_OF_ABUNDANCE_P2,
    xi.item.FRAYED_SACK_OF_MORTALITY_P1,
    xi.item.FRAYED_SACK_OF_MORTALITY_P2,
    xi.item.FRAYED_SACK_OF_DEVIOUSNESS,
    xi.item.FRAYED_SACK_OF_LIMINALITY,
    xi.item.COTTON_COIN_PURSE,
    xi.item.LINEN_COIN_PURSE,
    xi.item.PLUTON_CASE,
    xi.item.BEITETSU_PARCEL,
    xi.item.BOULDER_CASE,
    xi.item.PLUTON_BOX,
    xi.item.BEITETSU_BOX,
    xi.item.BOULDER_BOX,
    xi.item.FRAYED_SACK_OF_HORROR_P1,
    xi.item.FRAYED_SACK_OF_HORROR_P2,
    xi.item.FRAYED_SACK_OF_BEAUTY,
    xi.item.FRAYED_SACK_OF_SPLENDOR,
    xi.item.FRAYED_SACK_OF_FECUNDITY,
    xi.item.FRAYED_SACK_OF_PLENTY,
    xi.item.FRAYED_SACK_OF_OPULENCE,
    xi.item.AGED_BOX_BAYLD,
    xi.item.HEAVY_METAL_POUCH,
}
local anniversaryItems =
{
    -- TODO: The anniversary item table needs to be populated
    xi.item.DIAL_KEY_ANV, -- just give them back their key until this table can be populated
}

local gobbieJunk =
{
    xi.item.GOBLIN_MESS_TIN,
    xi.item.GOBLIN_WEEL,
    xi.item.CHUNK_OF_HOBGOBLIN_CHOCOLATE,
    xi.item.HOBGOBLIN_PIE,
    xi.item.LOAF_OF_HOBGOBLIN_BREAD,
    xi.item.LOAF_OF_GOBLIN_BREAD,
    xi.item.CHUNK_OF_GOBLIN_CHOCOLATE,
    xi.item.GOBLIN_PIE,
}

xi.gobbieMysteryBox.onTrade = function(player, npc, trade, events)
    if trade:getItemCount() == 1 then
        local tradeID = trade:getItemId(0)
        if keyToDial[tradeID] ~= nil then
            -- TODO: Without campaigns, there's currently no method for obtaining keys
            if player:getFreeSlotsCount() == 0 then
                player:startEvent(events.FULL_INV, tradeID, keyToDial[tradeID])
                return false
            end

            player:setLocalVar('gobbieBoxKey', tradeID)
            player:startEvent(events.KEY_TRADE, tradeID, keyToDial[tradeID])
        else -- trade for points
            -- TODO: Point system needs to be defined
            return false
        end
    else
        return false
    end
end

xi.gobbieMysteryBox.onTrigger = function(player, npc, events)
    local event = events
    local playerAgeDays = (os.time() - player:getTimeCreated()) / 86400
    local dailyTallyPoints = player:getCurrency('daily_tally')
    local firstVisit = dailyTallyPoints == -1
    local gobbieBoxUsed = player:getCharVar('gobbieBoxUsed')
    local specialDialUsed = utils.mask.getBit(gobbieBoxUsed, 0) and 1 or 0
    local adoulinDialUsed = utils.mask.getBit(gobbieBoxUsed, 1) and 1 or 0
    local pictlogicaDialUsed = utils.mask.getBit(gobbieBoxUsed, 2) and 1 or 0
    local wantedDialUsed = utils.mask.getBit(gobbieBoxUsed, 3) and 1 or 0
    local holdingItem = player:getCharVar('gobbieBoxHoldingItem')

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

xi.gobbieMysteryBox.onEventUpdate = function(player, csid, option, events)
    local event = events
    local dailyTallyPoints = player:getCurrency('daily_tally')
    local holdingItem = player:getCharVar('gobbieBoxHoldingItem')
    local gobbieBoxUsed = player:getCharVar('gobbieBoxUsed')
    local specialDialUsed = utils.mask.getBit(gobbieBoxUsed, 0) and 1 or 0
    local adoulinDialUsed = utils.mask.getBit(gobbieBoxUsed, 1) and 1 or 0
    local pictlogicaDialUsed = utils.mask.getBit(gobbieBoxUsed, 2) and 1 or 0
    local wantedDialUsed = utils.mask.getBit(gobbieBoxUsed, 3) and 1 or 0
    local itemID = 0

    if csid == event.KEY_TRADE then
        if option == 1 then
            local keyID = player:getLocalVar('gobbieBoxKey')
            player:setLocalVar('gobbieBoxKey', 0)
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

            player:setCharVar('gobbieBoxHoldingItem', itemID)
            player:tradeComplete()
            player:updateEvent(itemID, keyToDial[keyID], 3)
        elseif option == 2 then
            if holdingItem > 0 and npcUtil.giveItem(player, holdingItem) then
                player:setCharVar('gobbieBoxHoldingItem', 0)
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
                        player:setCharVar('gobbieBoxHoldingItem', itemID)
                        player:setCurrency('daily_tally', dailyTallyPoints - dialCost)
                        if dialMask then
                            player:setCharVar('gobbieBoxUsed', utils.mask.setBit(gobbieBoxUsed, dialMask, true))
                        end

                        player:updateEvent(itemID, dial, 0)
                    else
                        player:updateEvent(1, dial, 1) -- not enough points
                    end
                end,

                [2] = function()
                    if player:getFreeSlotsCount() == 0 then
                        player:updateEvent(holdingItem, 0, 0, 1) -- inventory full, exit event
                        player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED + 2) -- generic 'Cannot obtain the item.'
                    end
                end,

                [5] = function()
                    if holdingItem > 0 and npcUtil.giveItem(player, holdingItem) then
                        player:setCharVar('gobbieBoxHoldingItem', 0)
                    end

                    player:updateEvent(specialDialUsed, adoulinDialUsed, pictlogicaDialUsed, wantedDialUsed, 0, 0, hideOptionFlags, dailyTallyPoints)
                end,
            }
        end
    end
end

xi.gobbieMysteryBox.onEventFinish = function(player, csid, option, events)
    local event = events
    if csid == event.INTRO then
        player:setCurrency('daily_tally', 50)
    elseif csid == event.HOLDING_ITEM then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED + 2) -- generic 'Cannot obtain the item.'
        elseif npcUtil.giveItem(player, player:getCharVar('gobbieBoxHoldingItem')) then
            player:setCharVar('gobbieBoxHoldingItem', 0)
        end
    end
end
