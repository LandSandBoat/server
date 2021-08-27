-----------------------------------
-- Area: Upper Delkfutt's Tower
--  NPC: Elevator
-- !pos -294 -143 27 158
-----------------------------------
local ID = require("scripts/zones/Upper_Delkfutts_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 549) then -- Delkfutt Key
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 6 then
        if not player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
            player:confirmTrade()
            npcUtil.giveKeyItem(player, xi.ki.DELKFUTT_KEY)
        end
    end
end

return entity
