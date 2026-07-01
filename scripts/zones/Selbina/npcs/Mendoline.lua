-----------------------------------
-- Area: Selbina
--  NPC: Mendoline
-- Guild Merchant NPC: Fishing Guild
-- !pos -13.603 -7.287 10.916 248
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.SELBINA].text.FISHING_SHOP_DIALOG)
    end
end

return entity
