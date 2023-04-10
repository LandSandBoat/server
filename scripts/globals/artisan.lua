-----------------------------------
--
--  Artisan Moogles
--
-----------------------------------
require('scripts/globals/zone')
require('scripts/globals/status')
-----------------------------------

xi = xi or {}
xi.artisan = xi.artisan or {}

local event =
{
    [xi.zone.BASTOK_MARKETS] = 544,
    [xi.zone.WINDURST_WOODS] = 833,
    [xi.zone.RULUDE_GARDENS] = 10162,
    [xi.zone.SOUTHERN_SAN_DORIA] = 960
}

local menuFlags =
{
    expand = 0x8,
    abags = 0x4,
    aexpand = 0x2,
}

xi.artisan.moogleOnTrigger = function(player, npc)
    local csid = event[player:getZoneID()]
    local menuMask = 0
    local sackSize = player:getContainerSize(xi.inv.MOGSACK)
    local mogVisited = (sackSize > 0 or player:getCharVar("[artisan]visited") > 0) and 1 or 0
    if mogVisited == 0 then
        player:setCharVar("[artisan]visited", 1)
    end

    if sackSize > 0 then
        sackSize = sackSize + 1
    else
        menuMask = menuFlags.expand + menuFlags.aexpand
    end

    player:startEvent(csid, 0, 0, 0, sackSize, 0, 0, menuMask, mogVisited)
end

xi.artisan.moogleOnUpdate = function(player, csid, option)
    if option == 1 then -- Buy sack
        if player:getGil() >= 9980 and player:getContainerSize(xi.inv.MOGSACK) == 0 then
            player:delGil(9980)
            player:changeContainerSize(xi.inv.MOGSACK, 30)
            player:setCharVar("[artisan]visited", 0)
            player:updateEvent(0, 0, 0, 30 + 1, 0, 0, 0, 2)
        end

    elseif option == 2 then -- Expand sack
        local sackSize = player:getContainerSize(xi.inv.MOGSACK)
        local gobbieSize = player:getContainerSize(xi.inv.INVENTORY)
        local gobbieCanUpgrade = gobbieSize < 80 and 1 or 0
        if sackSize < gobbieSize and sackSize > 0 then
            player:changeContainerSize(xi.inv.MOGSACK, gobbieSize - sackSize)
            player:updateEvent((gobbieSize - 30) / 5, 0, 0, player:getContainerSize(xi.inv.MOGSACK) + 1, 0, 0, 2, 0)
        else
            player:updateEvent(0, 0, 0, 0, 0, 0, gobbieCanUpgrade, 0)
        end

    elseif option == 3 then -- Client requests sack + scroll status
        local scrollAvail = player:getCharVar("[artisan]nextScroll") < getMidnight() and 1 or 0
        local sackSize = player:getContainerSize(xi.inv.MOGSACK)
        if sackSize > 0 then
            sackSize = sackSize + 1
        end

        player:updateEvent(0, 0, 0, sackSize, 0, 0, 0, scrollAvail)

    elseif option == 4 then -- Main dialogue
        local scrollAvail = player:getCharVar("[artisan]nextScroll") < getMidnight() and 1 or 0
        local sackSize = player:getContainerSize(xi.inv.MOGSACK)
        if sackSize > 0 then
            sackSize = sackSize + 1
        end

        player:updateEvent(0, 0, player:getGil(), sackSize, 0, 0, 0, scrollAvail)
    end
end

xi.artisan.moogleOnFinish = function(player, csid, option)
    local zone = zones[player:getZoneID()]

    if option == 99 then -- Get Scroll
        if player:getCharVar("[artisan]nextScroll") < getMidnight() then
            if player:addItem(4181) then
                player:messageSpecial(zone.text.ITEM_OBTAINED, 4181)
                player:setCharVar("[artisan]nextScroll", getMidnight())
            else
                player:messageSpecial(zone.text.ITEM_CANNOT_BE_OBTAINED, 4181)
            end
        end
    end
end
