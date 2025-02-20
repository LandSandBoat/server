-----------------------------------
-- Area: Caedarva Mire
--  NPC: Kwadaaf
-- Type: Entry to Alzadaal Undersea Ruins
-- !pos -639.000 12.323 -260.000 79
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
        player:startEvent(223)
    end
end

entity.onTrigger = function(player, npc)
    if player:getXPos() < -639 then
        if player:hasKeyItem(xi.ki.CAPTAIN_WILDCAT_BADGE) then
            player:messageSpecial(ID.text.YOU_HAVE_A_BADGE, xi.ki.CAPTAIN_WILDCAT_BADGE)
            player:startEvent(223)
        else
            player:startEvent(222)
        end
    else
        player:startEvent(224)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 223 then
        player:setPos(-235, -4, 220, 0, 72)
    end
end

return entity
