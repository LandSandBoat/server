-----------------------------------
-- Area: Silver Sea route to Nashmau
--  NPC: Jidwahn
-- Guild Merchant NPC: Fishing Guild
-- !pos 4.986 -2.101 -12.026 58
-----------------------------------
local ID = zones[xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(524, 1, 23, 5) then
        player:showText(npc, ID.text.JIDWAHN_SHOP_DIALOG)
    end
end

return entity
