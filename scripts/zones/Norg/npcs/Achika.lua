-----------------------------------
-- Area: Norg
--  NPC: Achika
-- Type: Tenshodo Merchant
-- !pos 1.300 0.000 19.259 252
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60421, 9, 23, 7) then
        player:showText(npc, zones[xi.zone.NORG].text.ACHIKA_SHOP_DIALOG)
    end
end

return entity
