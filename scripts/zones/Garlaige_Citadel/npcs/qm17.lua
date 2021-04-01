-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm17 (???)
-- Notes: Used to obtain Pouch of Weighted Stones
-- !pos -354 0 262 200
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:hasKeyItem(xi.ki.POUCH_OF_WEIGHTED_STONES) == false) then
        player:addKeyItem(xi.ki.POUCH_OF_WEIGHTED_STONES)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.POUCH_OF_WEIGHTED_STONES)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
