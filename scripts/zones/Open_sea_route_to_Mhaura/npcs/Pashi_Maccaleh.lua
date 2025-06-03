-----------------------------------
-- Area: Open sea route to Mhaura
--  NPC: Pashi Maccaleh
-- Guild Merchant NPC: Fishing Guild
-- !pos 4.986 -2.101 -12.026 47
-----------------------------------
local ID = zones[xi.zone.OPEN_SEA_ROUTE_TO_MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(523, 1, 23, 5) then
        player:showText(npc, ID.text.PASHI_MACCALEH_SHOP_DIALOG)
    end
end

return entity
