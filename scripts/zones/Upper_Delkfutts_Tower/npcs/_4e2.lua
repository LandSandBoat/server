-----------------------------------
-- Area: Upper Delkfutt's Tower
--  NPC: Elevator
-- !pos -294 -143 27 158
-----------------------------------
local ID = zones[xi.zone.UPPER_DELKFUTTS_TOWER]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.DELKFUTT_KEY) then -- Delkfutt Key
        player:startEvent(6)
    end
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
        player:startEvent(6)
    else
        player:messageSpecial(ID.text.THIS_ELEVATOR_GOES_DOWN)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 6 then
        if not player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
            player:confirmTrade()
            npcUtil.giveKeyItem(player, xi.ki.DELKFUTT_KEY)
            -- Different message here: You receive <keyitem>!
            -- Trading does not consume Key
        end
    end
end

return entity
