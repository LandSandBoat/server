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

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.POUCH_OF_WEIGHTED_STONES) == false) then
        player:addKeyItem(tpz.ki.POUCH_OF_WEIGHTED_STONES)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.POUCH_OF_WEIGHTED_STONES)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
