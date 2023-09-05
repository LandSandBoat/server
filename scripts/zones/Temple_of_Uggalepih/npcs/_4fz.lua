-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Granite Door
-- Leads to painbrush room @ F-7
-- !pos 60 0.1 8 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 1136) and player:getZPos() < 11 then -- Uggalepih key
        player:startEvent(46)
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() < 11 then
        player:messageSpecial(ID.text.THE_DOOR_IS_LOCKED, 1136)
    else
        player:startEvent(47)
    end

    return 0
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 46 then
        player:confirmTrade()
        player:messageSpecial(ID.text.YOUR_KEY_BREAKS, 0, 1136)
    end
end

return entity
