-----------------------------------
-- Area: Al Zahbi
--  NPC: Dehbi Moshal
--  Guild Merchant NPC: Woodworking Guild
-- !pos -71.563 -5.999 -57.544 48
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60428, 6, 21, 0) then
        player:showText(npc, ID.text.DEHBI_MOSHAL_SHOP_DIALOG)
    end
end

return entity
