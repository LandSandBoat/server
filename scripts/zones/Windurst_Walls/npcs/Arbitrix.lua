-----------------------------------
-- Area: Windurst Woods
--  NPC: Arbitrix
-- Gobbie Mystery Box
-- !pos -215.5 0.0 -147.3
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/settings")
-----------------------------------
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

function onTrigger(player, npc)
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
        player:startEvent(519)
    elseif playerAgeDays >= GOBBIE_BOX_MIN_AGE then
        if holdingItem ~= 0 then
            player:startEvent(521)
        else
            player:startEvent(520, specialDialUsed, adoulinDialUsed, pictlogicaDialUsed, wantedDialUsed, 0, 0, hideOptionFlags, dailyTallyPoints)
        end
    else
        player:messageSpecial(ID.text.YOU_MUST_WAIT_ANOTHER_N_DAYS, GOBBIE_BOX_MIN_AGE - playerAgeDays)
    end
end

function onEventUpdate(player, csid, option)
    local dailyTallyPoints = player:getCurrency("daily_tally")
    local holdingItem = player:getCharVar("gobbieBoxHoldingItem")
    local gobbieBoxUsed = player:getCharVar("gobbieBoxUsed")
    local specialDialUsed = player:getMaskBit(gobbieBoxUsed, 0) and 1 or 0
    local adoulinDialUsed = player:getMaskBit(gobbieBoxUsed, 1) and 1 or 0
    local pictlogicaDialUsed = player:getMaskBit(gobbieBoxUsed, 2) and 1 or 0
    local wantedDialUsed = player:getMaskBit(gobbieBoxUsed, 3) and 1 or 0
    local itemid = 0

    if csid == 520 then
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
                        itemid = SelectDailyItem(player, dial)
                        player:setCharVar("gobbieBoxHoldingItem", itemid)
                        player:setCurrency("daily_tally", dailyTallyPoints - dial_cost)
                        if dial_mask then
                            player:setMaskBit(gobbieBoxUsed, "gobbieBoxUsed", dial_mask, true)
                        end
                        player:updateEvent(itemid, dial, 0)
                    else
                        player:updateEvent(1, dial, 1) -- not enough points
                    end
                end,
                [2] = function()
                    if player:getFreeSlotsCount() == 0 then
                        player:updateEvent(holdingItem, 0, 0, 1) -- inventory full, exit event
                        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED + 2) -- generic "Cannot obtain the item."
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

function onEventFinish(player, csid, option)
    if csid == 519 then
        player:setCurrency("daily_tally", 50)
    elseif csid == 521 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED + 2) -- generic "Cannot obtain the item."
        elseif npcUtil.giveItem(player, player:getCharVar("gobbieBoxHoldingItem")) then
            player:setCharVar("gobbieBoxHoldingItem", 0)
        end
    end
end
