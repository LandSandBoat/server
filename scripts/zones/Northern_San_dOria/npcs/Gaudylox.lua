-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Gaudylox
-- Standard merchant, though he acts like a guild merchant
-- !pos -147.593 11.999 222.550 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(60418, 11, 22, 0) then
        player:showText(npc, ID.text.GAUDYLOX_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
