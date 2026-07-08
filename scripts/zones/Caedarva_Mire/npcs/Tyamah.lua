-----------------------------------
-- Area: Caedarva Mire
--  NPC: Tyamah
-- Type: Alzadaal Undersea Ruins
-- !pos 320.003 0.124 -700.011 79
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
        player:startEvent(163)
    end
end

entity.onTrigger = function(player, npc)
    if player:getXPos() > 320 then
        player:startEvent(164)
    else
        if player:hasKeyItem(xi.ki.CAPTAIN_WILDCAT_BADGE) then
            player:messageSpecial(ID.text.YOU_HAVE_A_BADGE, xi.ki.CAPTAIN_WILDCAT_BADGE)
            player:startEvent(163)
        else
            player:startEvent(162)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 163 then
        player:setPos(-20, -4, 835, 64, 72)
    end
end

return entity
