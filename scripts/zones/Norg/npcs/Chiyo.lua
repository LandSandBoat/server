-----------------------------------
-- Area: Norg
--  NPC: Chiyo
-- Type: Tenshodo Merchant
-- !pos 5.801 0.020 -18.739 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        if player:sendGuild(60422, 9, 23, 7) then
            player:showText(npc, ID.text.CHIYO_SHOP_DIALOG)
        end
    end
end

return entity
