-----------------------------------
-- Area: Norg
--  NPC: Chiyo
-- Type: Tenshodo Merchant
-- !pos 5.801 0.020 -18.739 252
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60422, 9, 23, 7) then
        player:showText(npc, zones[xi.zone.NORG].text.CHIYO_SHOP_DIALOG)
    end
end

return entity
