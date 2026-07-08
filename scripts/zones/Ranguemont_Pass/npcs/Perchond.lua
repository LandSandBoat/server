-----------------------------------
-- Area: Ranguemont Pass
--  NPC: Perchond
-- !pos -182.844 4 -164.948 166
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(xi.item.PINCH_OF_GLITTERSAND, 1) and
        trade:getItemCount() == 1
    then
        local sinHunting = player:getCharVar('sinHunting')    -- RNG AF1

        if sinHunting == 2 then
            player:startEvent(5)
        end
    end
end

entity.onTrigger = function(player, npc)
    local sinHunting = player:getCharVar('sinHunting')    -- RNG AF1

    if sinHunting == 1 then
        player:startEvent(3, 0, xi.item.PINCH_OF_GLITTERSAND)
    else
        player:startEvent(2)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 3 then
        player:setCharVar('sinHunting', 2)
    elseif csid == 5 then
        player:tradeComplete()
        npcUtil.giveKeyItem(player, xi.ki.PERCHONDS_ENVELOPE)
        player:setCharVar('sinHunting', 3)
    end
end

return entity
