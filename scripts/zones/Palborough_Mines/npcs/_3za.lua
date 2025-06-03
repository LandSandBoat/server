-----------------------------------
-- Area: Palborough Mines
--  NPC: Refiner Lid
-- Involved In Mission: Journey Abroad
-- !pos 180 -32 167 143
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local gravelQty = trade:getItemQty(xi.item.CHUNK_OF_MINE_GRAVEL)
    local alreadyIn = player:getCharVar('refiner_input')

    if alreadyIn + gravelQty > 10 then
        player:startEvent(20)
    elseif trade:getItemCount() == gravelQty then
        player:tradeComplete()
        player:setCharVar('refiner_input', alreadyIn + gravelQty)
        player:startEvent(19, 597, gravelQty)
    else
        player:startEvent(21)
    end
end

return entity
