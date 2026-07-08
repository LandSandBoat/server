-----------------------------------
-- Area: Caedarva Mire
--  NPC: Nasheefa
-- Type: Alzadaal Undersea Ruins
-- !pos -440.998 0.107 -740.015 79
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
        player:startEvent(183)
    end
end

entity.onTrigger = function(player, npc)
    if player:getXPos() < -440 then
        player:startEvent(184)
    else
        if player:hasKeyItem(xi.ki.CAPTAIN_WILDCAT_BADGE) then
            player:messageSpecial(ID.text.YOU_HAVE_A_BADGE, xi.ki.CAPTAIN_WILDCAT_BADGE)
            player:startEvent(183)
        else
            player:startEvent(182)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 183 then
        player:setPos(-219.977, -4, 474.522, 64, 72) -- To Alzadaal Undersea Ruins (R)
    end
end

return entity
