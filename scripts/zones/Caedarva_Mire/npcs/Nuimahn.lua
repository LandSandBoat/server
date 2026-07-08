-----------------------------------
-- Area: Caedarva Mire
--  NPC: Nuimahn
-- Type: Alzadaal Undersea Ruins
-- !pos  -380 0 -381 79
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.IMPERIAL_SILVER_PIECE, 1)
    then
        player:tradeComplete()
        player:startEvent(203)
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() < -281 then
        player:startEvent(204) -- leaving
    else
        if player:hasKeyItem(xi.ki.CAPTAIN_WILDCAT_BADGE) then -- entering
            player:messageSpecial(ID.text.YOU_HAVE_A_BADGE, xi.ki.CAPTAIN_WILDCAT_BADGE)
            player:startEvent(203)
        else
            player:startEvent(202)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 203 then
        player:setPos(-515, -6.5, 740, 0, 72)
    end
end

return entity
