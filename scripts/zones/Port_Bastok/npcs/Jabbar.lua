-----------------------------------
-- Area: Port Bastok
--  NPC: Jabbar
-- Type: Tenshodo Merchant
-- Involved in Quests: Tenshodo Menbership
-- !pos -99.718 -2.299 26.027 236
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        if player:sendGuild(60419, 1, 23, 4) then
            player:showText(npc, ID.text.TENSHODO_SHOP_OPEN_DIALOG)
        end
    end
end

return entity
