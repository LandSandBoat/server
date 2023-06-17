-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm17 (???)
-- Notes: Used to obtain Pouch of Weighted Stones
-- !pos -354 0 262 200
-----------------------------------
require('scripts/globals/npc_util')
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.POUCH_OF_WEIGHTED_STONES) then
        player:startEvent(23) -- Key Item name hardcoded in the event.
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 23 and option == 1 then
        npcUtil.giveKeyItem(player, xi.ki.POUCH_OF_WEIGHTED_STONES)
    end
end

return entity
