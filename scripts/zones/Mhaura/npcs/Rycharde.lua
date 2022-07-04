-----------------------------------
-- Area: Mhaura
--  NPC: Rycharde
-----------------------------------
-- Used in: scripts/quests/otherAreas/Rycharde_the_Chef.lua
-- Used in: scripts/quests/otherAreas/Way_of_the_Cook.lua
-- Used in: scripts/quests/otherAreas/Unending_Chase.lua
-- Used in: scripts/quests/otherAreas/His_Name_is_Valgeir.lua
-- Used in: scripts/quests/otherAreas/The_Clue.lua
-- Used in: scripts/quests/otherAreas/The_Basics.lua
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require('scripts/globals/items')
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- player:startEvent(69) -- POSIBLE default dialog
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
