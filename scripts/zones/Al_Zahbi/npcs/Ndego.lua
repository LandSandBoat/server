-----------------------------------
-- Area: Al Zahbi
--  NPC: Ndego
--  Guild Merchant NPC: Smithing Guild
-- !pos -37.192 0.000 -33.949 48
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60427, 8, 23, 2) then
        player:showText(npc, ID.text.NDEGO_SHOP_DIALOG)
    end
end

return entity
