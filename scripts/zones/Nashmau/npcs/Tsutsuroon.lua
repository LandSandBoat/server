-----------------------------------
-- Area: Nashmau
--  NPC: Tsutsuroon
-- Type: Tenshodo Merchant
-- !pos -15.193 0.000 31.356 53
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        if player:sendGuild(60431, 1, 23, 7) then
            player:showText(npc, ID.text.TSUTSUROON_SHOP_DIALOG)
        end
    end
end

return entity
