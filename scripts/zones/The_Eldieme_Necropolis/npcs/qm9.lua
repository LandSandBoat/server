-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: qm9 (??? - Ancient Papyrus Shreds)
-- Involved in Quest: In Defiant Challenge
-- !pos 92.272 -32 -64.676 195
-----------------------------------
local func = require("scripts/zones/The_Eldieme_Necropolis/globals")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.papyrusQmOnTrigger(player, tpz.ki.ANCIENT_PAPYRUS_SHRED3)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
