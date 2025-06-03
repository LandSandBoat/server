-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Doggomehr
--  Guild Merchant NPC: Blacksmithing Guild
-- !pos -193.920 3.999 162.027 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(531, 8, 23, 2) then
        player:showText(npc, ID.text.DOGGOMEHR_SHOP_DIALOG)
    end
end

return entity
