-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Paunelie
--  Linkshell Merchant
-- !pos -144.659 -2.999 1.443 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.PAUNELIE_SHOP_DIALOG, xi.item.LINKSHELL)
    end
end

return entity
