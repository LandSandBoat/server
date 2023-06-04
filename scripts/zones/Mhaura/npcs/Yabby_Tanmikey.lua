-----------------------------------
-- Area: Mhaura
--  NPC: Yabby Tanmikey
--  Guild Merchant NPC: Goldsmithing Guild
-- !pos -36.459 -16.000 76.840 249
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Mhaura/IDs")
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
