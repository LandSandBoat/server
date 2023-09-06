-----------------------------------
-- Area: Bastok Markets
--  NPC: Umberto
-- Involved in Quest: Too Many Chefs
-- !pos -56.896 -5 -134.267 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('TOO_MANY_CHEFS') == 5 then -- end Quest Too Many Chefs
        player:startEvent(473)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 473 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.AILEENS_DELIGHT)
        else
            player:addItem(xi.item.AILEENS_DELIGHT)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.AILEENS_DELIGHT)
            player:addFame(xi.quest.fame_area.BASTOK, 30)
            player:setCharVar('TOO_MANY_CHEFS', 0)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TOO_MANY_CHEFS)
        end
    end
end

return entity
