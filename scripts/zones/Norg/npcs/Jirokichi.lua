-----------------------------------
-- Area: Norg
--  NPC: Jirokichi
-- Type: Tenshodo Merchant
-- !pos -1.463 0.000 18.846 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        if player:sendGuild(60423, 9, 23, 7) then
            player:showText(npc, ID.text.JIROKICHI_SHOP_DIALOG)
        end
    end
end

return entity
