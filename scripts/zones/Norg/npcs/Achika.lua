-----------------------------------
-- Area: Norg
--  NPC: Achika
-- Type: Tenshodo Merchant
-- !pos 1.300 0.000 19.259 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        if player:sendGuild(60421, 9, 23, 7) then
            player:showText(npc, ID.text.ACHIKA_SHOP_DIALOG)
        end
    else
        -- player:startEvent(150)
    end
end

return entity
