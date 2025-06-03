-----------------------------------
-- Area: Oldton Movalpolos
--  NPC: Twinkbrix
-- Type: Warp NPC
-- !pos -292.779 6.999 -263.153 11
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Trigger is only ever informative events about key item and cooldown status
    local operatingLeverCD = player:getCharVar('[ENM]OperatingLever')
    local operatingLeverWaiting = operatingLeverCD > VanadielTime()
    local operatingLeverHas = player:hasKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER)

    local gateDialCD = player:getCharVar('[ENM]GateDial')
    local gateDialWaiting = gateDialCD > VanadielTime()
    local gateDialHas = player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)

    if
        operatingLeverHas and
        gateDialHas
    then
        player:startEvent(50)

    -- lever on cooldown
    else
        -- generic messages about how to obtain both items
        -- player:startEvent(52, xi.item.SYLVAN_STONE)

        local eventID = (gateDialHas and operatingLeverWaiting) and 53 or 52
        local operatingLeverParam = operatingLeverWaiting and operatingLeverCD or 432000
        local gateDialParam = gateDialWaiting and gateDialCD or 432000
        local keyItemFlag = 0 -- This event param passes whether the player has/can get both key items
        keyItemFlag = utils.mask.setBit(keyItemFlag, 0, operatingLeverWaiting)
        keyItemFlag = utils.mask.setBit(keyItemFlag, 1, gateDialWaiting)
        keyItemFlag = utils.mask.setBit(keyItemFlag, 2, operatingLeverHas)
        keyItemFlag = utils.mask.setBit(keyItemFlag, 3, gateDialHas)

        player:startEvent(eventID, xi.item.SYLVAN_STONE, operatingLeverParam, 2964, gateDialParam, keyItemFlag)
    end
end

entity.onTrade = function(player, npc, trade)
    local operatingLeverCD = player:getCharVar('[ENM]OperatingLever')
    local gateDialCD = player:getCharVar('[ENM]GateDial')
    local specialGilTrade = 2716
    local mineShaftWarpCost = 2000
    local tradeGil = trade:getGil()

    if
        player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL) and
        npcUtil.tradeHasExactly(trade, { { 'gil', mineShaftWarpCost } })
    then
        -- teleport for mineShaftWarpCost relies on having SHAFT_GATE_OPERATING_DIAL
        -- but consumes SHAFT_2716_OPERATING_LEVER (after confirming with you)
        if player:hasKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER) then
            player:startEvent(56, xi.item.SYLVAN_STONE, 23) -- capture contained these additional, unimportant items:, 1757, 177552692, 8, 17407, 15, 0)
        else
            player:startEvent(56)
        end

    elseif
        not player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL) and
        tradeGil > 0 and tradeGil <= 10000 and
        gateDialCD < VanadielTime() and
        npcUtil.tradeHasExactly(trade, { { 'gil', tradeGil } })
    then
        local maxToWin = math.floor(tradeGil / 200)
        local maxRoll = 100
        -- SE unveiled that trading a specific amount of gil on a specific day will improve chances of a win.
        -- This number has been proven to be 2,716 (referring to Mine Shaft #2716), as the dialogue will change
        -- and the correct day is Lightsday ('confirmed' via player reports).
        if
            tradeGil == specialGilTrade and
            VanadielDayElement() == xi.element.LIGHT
        then
            -- trading 2716 gives a special message in the client, but
            -- specifically for Lightsday we change the max random number to heavily weight winning the roll
            maxRoll = 20 -- TODO confirm this value via a lot of data
        end

        local diceRoll = math.random(2, maxRoll)
        player:tradeComplete() -- Completing trade here prevents exploiting this system
        player:startEvent(55, tradeGil, maxToWin, diceRoll, mineShaftWarpCost)

    elseif
        operatingLeverCD < VanadielTime() and
        npcUtil.tradeHasExactly(trade, { xi.item.SYLVAN_STONE })
    then
        player:startEvent(51, xi.item.SYLVAN_STONE)
    elseif
        (tradeGil > 0 and tradeGil <= 10000) or
        trade:hasItemQty(xi.item.SYLVAN_STONE, 1)
    then
        -- Trying to trade for a key item, but didn't match anything above. Give generic onTrigger message from logic above
        entity.onTrigger(player, npc)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 51 then
        -- TODO entering battle sets the cooldown (extra important here as using the teleport consumes this key item, and it should be possible to immediately get another)
        player:setCharVar('[ENM]OperatingLever', VanadielTime() + (xi.settings.main.ENM_COOLDOWN * 3600))
        npcUtil.giveKeyItem(player, xi.ki.SHAFT_2716_OPERATING_LEVER)
        player:tradeComplete()

    elseif csid == 55 and option == 1 then
        -- TODO entering battle sets the cooldown
        player:setCharVar('[ENM]GateDial', VanadielTime() + (xi.settings.main.ENM_COOLDOWN * 3600))
        npcUtil.giveKeyItem(player, xi.ki.SHAFT_GATE_OPERATING_DIAL)

    elseif csid == 56 and option == 1 then
        player:delKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER)
        player:tradeComplete()
        xi.teleport.to(player, xi.teleport.id.MINESHAFT)
    end
end

return entity
