-----------------------------------
-- Area: Hall of Transference
--  NPC: Large Apparatus (Right) - Mea
-- !pos 290.253 -81.849 -42.381 14
-----------------------------------
local ID = zones[xi.zone.HALL_OF_TRANSFERENCE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('MeaChipRegistration') == 0 and
        player:getCharVar('skyShortcut') == 1 and
        trade:hasItemQty(xi.item.CLEAR_CHIP, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(164)
    end
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('MeaChipRegistration') == 1 then
        player:messageSpecial(ID.text.NO_RESPONSE_OFFSET + 6) -- Device seems to be functioning correctly.
    elseif player:checkDistance(npc) <= 2.71 then
        player:startEvent(167) -- Hexagonal Cones
    else
        player:messageSpecial(ID.text.YOU_MUST_MOVE_CLOSER)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 164 then
        player:messageSpecial(ID.text.NO_RESPONSE_OFFSET + 4, xi.item.CLEAR_CHIP) -- You fit..
        player:messageSpecial(ID.text.NO_RESPONSE_OFFSET + 5)     -- Device has been repaired
        player:setCharVar('MeaChipRegistration', 1)
        player:tradeComplete()
    end
end

return entity
