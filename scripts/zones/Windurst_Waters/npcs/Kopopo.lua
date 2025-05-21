-----------------------------------
-- Area: Windurst Waters
--  NPC: Kopopo
-- Guild Merchant NPC: Cooking Guild
-- !pos -103.935 -2.875 74.304 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(530, 5, 20, 7) then
        player:showText(npc, ID.text.KOPOPO_SHOP_DIALOG)
    end
end

return entity
