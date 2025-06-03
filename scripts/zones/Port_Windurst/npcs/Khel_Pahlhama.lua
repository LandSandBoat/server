-----------------------------------
-- Area: Port Windurst
--  NPC: Khel Pahlhama
--  Linkshell Merchant
-- !pos 21 -2 -20 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60432, 12, 20, 0) then
        player:showText(npc, zones[xi.zone.PORT_WINDURST].text.KHEL_PAHLHAMA_SHOP_DIALOG, xi.item.LINKSHELL)
    end
end

return entity
