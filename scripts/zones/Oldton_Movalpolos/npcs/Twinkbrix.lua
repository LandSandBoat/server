-----------------------------------
-- Area: Oldton Movalpolos
--  NPC: Twinkbrix
-- Type: Warp NPC
-- !pos -292.779 6.999 -263.153 11
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local mineShaftWarpCost = 2000
    local tradeGil = trade:getGil()

    if
        player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL) and
        npcUtil.tradeHas(trade, { { 'gil', mineShaftWarpCost } })
    then
        player:startEvent(56)
    elseif
        not player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL) and
        tradeGil > 0 and
        tradeGil <= 10000 and
        npcUtil.tradeHas(trade, { { 'gil', tradeGil } })
    then
        local maxRoll = tradeGil / 200
        local diceRoll = math.random(2, 100)
        player:startEvent(55, tradeGil, maxRoll, diceRoll, mineShaftWarpCost)
    end
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL) then
        player:startEvent(50)
    else
        player:startEvent(52)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 55 and option == 1 then
        npcUtil.giveKeyItem(player, xi.ki.SHAFT_GATE_OPERATING_DIAL)
        player:confirmTrade()
    elseif csid == 55 and option == 0 then
        player:confirmTrade()
    elseif csid == 56 and option == 1 then
        player:confirmTrade()
        xi.teleport.to(player, xi.teleport.id.MINESHAFT)
    end
end

return entity
