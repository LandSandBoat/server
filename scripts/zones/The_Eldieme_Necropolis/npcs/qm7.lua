-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: qm7 (??? - Ancient Papyrus Shreds)
-- Involved in Quest: In Defiant Challenge
-- !pos 252.824 -32.000 -64.803 195
-----------------------------------
local func = require("scripts/zones/The_Eldieme_Necropolis/globals")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.papyrusQmOnTrigger(player, xi.ki.ANCIENT_PAPYRUS_SHRED1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
