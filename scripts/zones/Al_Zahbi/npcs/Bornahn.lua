-----------------------------------
-- Area: Al Zahbi
--  NPC: Bornahn
--  Guild Merchant NPC: Goldsmithing Guild
-- !pos 46.011 0.000 -42.713 48
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60429, 8, 23, 4) then
        player:showText(npc, ID.text.BORNAHN_SHOP_DIALOG)
    end
end

return entity
