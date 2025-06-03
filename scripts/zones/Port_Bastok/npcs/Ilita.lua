-----------------------------------
-- Area: Port Bastok
--  NPC: Ilita
-- Linkshell Merchant
--   !pos -142 -1 -25 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60432, 12, 20, 0) then
        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.ILITA_SHOP_DIALOG, xi.item.LINKSHELL)
    end
end

return entity
