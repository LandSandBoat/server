-----------------------------------
-- Area: Western Adoulin
--  NPC: Minnifi Delqabba
-- Type: Shop NPC
-- !pos 77 4 -125 256
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:showText(npc, ID.text.MINNIFI_DIALOGUE)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
