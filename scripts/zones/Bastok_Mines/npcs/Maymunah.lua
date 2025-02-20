-----------------------------------
-- Area: Bastok Mines
--  NPC: Maymunah
-- Guild Merchant NPC: Alchemy Guild
-- !pos 108.738 5.017 -3.129 234
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(5262, 8, 23, 6) then
        player:showText(npc, ID.text.MAYMUNAH_SHOP_DIALOG)
    end
end

return entity
