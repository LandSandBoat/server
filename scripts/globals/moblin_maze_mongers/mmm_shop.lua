-----------------------------------
-- Moblin Maze Mongers: Shop
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
xi = xi or {}
xi.mmm = xi.mmm or {}
-----------------------------------

-- Maze voucher (1) menu.   -->  262
-- Maze voucher (100) menu. -->  518
-- Maze rune (100) menu.    -->  258
-- Maze rune (200) menu.    -->  514
-- Maze rune (300) menu.    -->  770
-- Maze rune (400) menu.    --> 1026
-- Maze rune (500) menu.    --> 1282
-- "Take my gil" menu.      -->    7

local optionTable =
{
    [35009] = { xi.item.MAZE_VOUCHER_02, 1, 100, 'moblin_marble' },
    [ 2241] = { xi.item.MAZE_VOUCHER_09, 1, 100, 'moblin_marble' },
}

xi.mmm.shopOnTrigger = function(player)
    if player:hasKeyItem(xi.ki.TATTERED_MAZE_MONGER_POUCH) then
        local marbles  = player:getCurrency('moblin_marble')
        local ccPoints = xi.mmm.calculateCCPoints(player)

        player:startEvent(10095, 0, marbles, 0, ccPoints, 0, 0, 0, 0)
    -- else
        -- Find text.
    end
end

xi.mmm.shopOnEventUpdate = function(player, csid, option)
    local entry = optionTable[option]

    -- Handle buying.
    if entry then
        local prizeId        = entry[1]
        local spaceNeeded    = entry[2]
        local currencyNeeded = entry[3]
        local currencyType   = entry[4]
        local currencyHeld   = player:getCurrency('moblin_marble')

        if currencyType == 'gil' then
            currencyHeld = player:getGil()
        end

        if
            currencyHeld >= currencyNeeded and
            player:getFreeSlotsCount() >= spaceNeeded
        then
            -- Handle item/title.
            if spaceNeeded == 1 then
                npcUtil.giveItem(player, prizeId)
            else
                player:addTitle(prizeId)
            end

            -- Handle currency.
            if currencyType == 'gil' then
                player:delGil(currencyNeeded)
            else
                player:delCurrency('moblin_marble', currencyNeeded)
            end
        end
    end

    local param1         = 0 -- Bitmask. Possibly checks what vouchers/runes you have "learnt" to remove them from the lists.
    local param2         = 1 -- ?
    local param3         = 0 -- ?
    local completedMazes = player:getCharVar('[MMM]CompletedMazes') -- Determines what titles can be bought. They all appear in the list anyway?

    -- Update event.
    player:updateEvent(param1, param2, param3, completedMazes, 0, 0, 0, 0)
end
