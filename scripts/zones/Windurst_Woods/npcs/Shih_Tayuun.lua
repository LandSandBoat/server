-----------------------------------
-- Area: Windurst Woods
--  NPC: Shih Tayuun
-- Guild Merchant NPC: Bonecrafting Guild
-- !pos -3.064 -6.25 -131.374 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(514, 8, 23, 3) then
        player:showText(npc, ID.text.SHIH_TAYUUN_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
