-----------------------------------
-- Area: Port Windurst
--  NPC: Babubu
-- Guild Merchant NPC: Fishing Guild
-- !pos -175.185 -3.324 70.445 240
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, ID.text.BABUBU_SHOP_DIALOG)
    end
end

return entity
