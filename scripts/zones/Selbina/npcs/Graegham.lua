-----------------------------------
-- Area: Selbina
--  NPC: Graegham
-- Guild Merchant NPC: Fishing Guild
-- !pos -12.423 -7.287 8.665 248
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(5182, 3, 18, 5) then
        player:showText(npc, ID.text.FISHING_SHOP_DIALOG)
    end
end

return entity
