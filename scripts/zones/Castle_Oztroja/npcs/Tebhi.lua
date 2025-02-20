-----------------------------------
-- Area: Castle Oztroja
--  NPC: Tebhi
-- !pos -136 24 -21 151
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(xi.item.BEAST_COLLAR, 1) and
        trade:getItemCount() == 1
    then
        player:tradeComplete()
        -- TODO: Tebhi disappears for 15min
        player:setCharVar('scatIntoShadowCS', 2)
    end
end

return entity
