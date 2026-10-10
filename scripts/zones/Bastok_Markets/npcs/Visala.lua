-----------------------------------
-- Area: Bastok Markets
--  NPC: Visala
--  Guild Merchant NPC: Goldsmithing Guild
-- !pos -202.000 -7.814 -56.823 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.VISALA_SHOP_DIALOG)
    end
end

return entity
