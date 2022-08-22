-----------------------------------
-- Area: Oldton Movalpolos
--  NPC: Twinkbrix
-- Type: Warp NPC
-- !pos -292.779 6.999 -263.153 11
-----------------------------------
local ID = require("scripts/zones/Oldton_Movalpolos/IDs")
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local operatingLeverCD = player:getCharVar("[ENM]OperatingLever")
    local gateDialCD = player:getCharVar("[ENM]GateDial")
    local mineShaftWarpCost = 2000
    local tradeGil = trade:getGil()

    if
        player:hasKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER) and
        npcUtil.tradeHas(trade, {{"gil", mineShaftWarpCost}})
    then
        player:startEvent(56, 1781, 23, 1757, 177552692, 8, 17407, 15, 0)

    elseif
        player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL) and
        npcUtil.tradeHas(trade, {{"gil", mineShaftWarpCost}})
    then
        player:startEvent(56)

    elseif
        not player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL) and
        tradeGil > 0 and tradeGil <= 10000 and
        npcUtil.tradeHas(trade, {{"gil", tradeGil}}) and
        gateDialCD < os.time()
    then
        local maxRoll = tradeGil / 200
        local diceRoll = math.random(2, 100)
        player:startEvent(55, tradeGil, maxRoll, diceRoll, mineShaftWarpCost)

    elseif
        trade:hasItemQty(1781, 1) and
        trade:getItemCount() == 1 and
        operatingLeverCD < os.time()
    then
        player:startEvent(51, 1781)
    end
end

entity.onTrigger = function(player, npc)
    local operatingLeverCD = player:getCharVar("[ENM]OperatingLever")
    local gateDialCD = player:getCharVar("[ENM]GateDial")

    if player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL) or player:hasKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER) then
        player:startEvent(50)

    elseif operatingLeverCD > os.time() then
        player:startEvent(53, 1781, VanadielTime() + (operatingLeverCD - os.time()))

    elseif gateDialCD > os.time() then
        player:startEvent(52, 1781, 432000, 10, VanadielTime() + (gateDialCD - os.time()), 2, 209, 209, 0)

    else
        player:startEvent(52, 1781)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    print(option)

    if csid == 51 then
        player:setCharVar("[ENM]OperatingLever", os.time() + (xi.settings.main.ENM_COOLDOWN * 3600))
        npcUtil.giveKeyItem(player, xi.ki.SHAFT_2716_OPERATING_LEVER)
        player:confirmTrade()

    elseif csid == 55 and option == 1 then
        player:setCharVar("[ENM]GateDial", os.time() + (xi.settings.main.ENM_COOLDOWN * 3600))
        npcUtil.giveKeyItem(player, xi.ki.SHAFT_GATE_OPERATING_DIAL)
        player:confirmTrade()

    elseif csid == 55 and option == 0 then
        player:confirmTrade()

    elseif csid == 56 and option == 1 then
            player:delKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER)
            player:confirmTrade()
            xi.teleport.to(player, xi.teleport.id.MINESHAFT)
    end
end

return entity
