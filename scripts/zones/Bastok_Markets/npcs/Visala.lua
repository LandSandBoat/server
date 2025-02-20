-----------------------------------
-- Area: Bastok Markets
--  NPC: Visala
--  Guild Merchant NPC: Goldsmithing Guild
-- !pos -202.000 -7.814 -56.823 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(5272, 8, 23, 4) then
        player:showText(npc, ID.text.VISALA_SHOP_DIALOG)
    end
end

return entity
