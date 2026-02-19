-----------------------------------
-- Area: Port Bastok
--  NPC: Jabbar
-- Type: Tenshodo Merchant
-- Involved in Quests: Tenshodo Menbership
-- !pos -99.718 -2.299 26.027 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        if player:sendGuild(60419, 1, 23, 4) then
            player:showText(npc, zones[xi.zone.PORT_BASTOK].text.TENSHODO_SHOP_OPEN_DIALOG)
        end
    else
        player:startEvent(150)
    end
end

return entity
