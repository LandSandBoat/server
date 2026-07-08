-----------------------------------
-- Area: Newton Movalpolos
--  NPC: Sleakachiq
-- !pos 162.504 14.999 136.901 12
-----------------------------------
local ID = zones[xi.zone.NEWTON_MOVALPOLOS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local yPos = player:getYPos()

    if yPos <= 16.5 then
        if npcUtil.tradeHas(trade, { { 'gil', 800 } }) then
            player:startEvent(28)
        end
    elseif yPos >= 19.5 then
        player:messageSpecial(ID.text.COME_CLOSER)
    end
end

entity.onTrigger = function(player, npc)
    local yPos = player:getYPos()

    if yPos <= 16.5 then
        player:startEvent(27)
    elseif yPos >= 19.5 then
        player:startEvent(26)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 28 then
        if option == 1 then
            player:confirmTrade()
            player:setPos(447.99, -4.092, 729.791, 96, 106) -- To North Gustaberg (R)
        elseif option == 2 then
            player:confirmTrade()
            player:setPos(-93.657, -119.999, -583.561, 232, 13) -- To Mine Shaft Entrance (R)
        end
    end
end

return entity
