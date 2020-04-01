-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: qm9 (??? - Ancient Papyrus Shreds)
-- Involved in Quest: In Defiant Challenge
-- !pos 92.272 -32 -64.676 195
-----------------------------------
local func = require("scripts/zones/The_Eldieme_Necropolis/globals")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    func.papyrusQmOnTrigger(player, tpz.ki.ANCIENT_PAPYRUS_SHRED3)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
