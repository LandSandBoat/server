-----------------------------------
-- Area: Silver Sea route to Al Zahbi
--  NPC: Yahliq
-- Type: Guild Merchant: Fishing Guild
-- !pos 4.986 -2.101 -12.026 59
-----------------------------------
local ID = zones[xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(525, 1, 23, 5) then
        player:showText(npc, ID.text.YAHLIQ_SHOP_DIALOG)
    end
end

return entity
