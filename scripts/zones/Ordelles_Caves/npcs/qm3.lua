-----------------------------------
-- Area: Ordelle's Caves
--  NPC: ??? (qm3)
-- Involved in Quest: A Squire's Test II
-- !pos -139 0.1 264 193
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if os.time() - player:getCharVar("SquiresTestII") <= 60 and not player:hasKeyItem(tpz.ki.STALACTITE_DEW) then
        player:messageSpecial(ID.text.A_SQUIRE_S_TEST_II_DIALOG_II)
        player:addKeyItem(tpz.ki.STALACTITE_DEW)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.STALACTITE_DEW)
        player:setCharVar("SquiresTestII", 0)
    elseif player:hasKeyItem(tpz.ki.STALACTITE_DEW) then
        player:messageSpecial(ID.text.A_SQUIRE_S_TEST_II_DIALOG_III)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        player:setCharVar("SquiresTestII", 0)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
