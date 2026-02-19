-----------------------------------
-- Area: Norg
--  NPC: Vuliaie
-- Type: Tenshodo Merchant
-- !pos -24.259 0.891 -19.556 252
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60424, 9, 23, 7) then
        player:showText(npc, zones[xi.zone.NORG].text.VULIAIE_SHOP_DIALOG)
    end
end

return entity
