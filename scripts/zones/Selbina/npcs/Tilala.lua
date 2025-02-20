-----------------------------------
-- Area: Selbina
--  NPC: Tilala
-- Guild Merchant NPC: Clothcrafting Guild
-- !pos 14.344 -7.912 10.276 248
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(516, 6, 21, 0) then
        player:showText(npc, ID.text.CLOTHCRAFT_SHOP_DIALOG)
    end
end

return entity
