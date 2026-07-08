-----------------------------------
-- Area: Bhaflau Thickets
--  NPC: Kamih Mapokhalam
-- 20 -30 597 z 52
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_THICKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()

    if
        count == 1 and
        trade:hasItemQty(xi.item.IMPERIAL_SILVER_PIECE, 1)
    then
        player:tradeComplete()
        player:startEvent(121)
    elseif
        count == 3 and
        trade:hasItemQty(xi.item.IMPERIAL_MYTHRIL_PIECE, 3)
    then
        if player:hasKeyItem(xi.ki.MAP_OF_ALZADAAL_RUINS) then
            player:startEvent(147)
        else
            player:startEvent(146)
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() < 597 then
        if player:hasKeyItem(xi.ki.CAPTAIN_WILDCAT_BADGE) then
            player:messageSpecial(ID.text.YOU_HAVE_A_BADGE, xi.ki.CAPTAIN_WILDCAT_BADGE)
            player:startEvent(121)
        else
            player:startEvent(120)
        end
    else
        player:startEvent(122)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 121 then
        player:setPos(325.137, -3.999, -619.968, 0, 72) -- To Alzadaal Undersea Ruins G-8 (R)
    elseif csid == 146 then
        player:tradeComplete()
        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_ALZADAAL_RUINS)
    end
end

return entity
