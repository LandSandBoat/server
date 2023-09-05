-----------------------------------
-- Area: Mhaura
--  NPC: Celestina
-- Finish Quest: The Sand Charm
-- Involved in Quest: Riding on the Clouds
-- Guild Merchant NPC: Goldsmithing Guild
-- !pos -37.624 -16.050 75.681 249
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/shop")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(528, 8, 23, 4) then
        player:showText(npc, ID.text.GOLDSMITHING_GUILD)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
