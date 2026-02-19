-----------------------------------
-- Area: Al Zahbi
--  NPC: Taten-Bilten
--  Guild Merchant NPC: Clothcraft Guild
-- !pos 71.598 -6.000 -56.930 48
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60430, 6, 21, 0) then
        player:showText(npc, ID.text.TATEN_BILTEN_SHOP_DIALOG)
    end
end

return entity
