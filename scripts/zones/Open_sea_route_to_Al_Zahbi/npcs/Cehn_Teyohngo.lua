-----------------------------------
-- Area: Open sea route to Al Zahbi
--  NPC: Cehn Teyohngo
-- Guild Merchant NPC: Fishing Guild
-- !pos 4.986 -2.101 -12.026 46
-----------------------------------
local ID = zones[xi.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(522, 1, 23, 5) then
        player:showText(npc, ID.text.CEHN_TEYOHNGO_SHOP_DIALOG)
    end
end

return entity
