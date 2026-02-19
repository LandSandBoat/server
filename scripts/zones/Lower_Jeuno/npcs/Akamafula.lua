-----------------------------------
-- Area: Lower Jeuno
--  NPC: Akamafula
-- Type: Tenshodo Merchant
-- !pos 28.465 2.899 -46.699 245
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        return -- Anti-Cheat.
    end

    if player:sendGuild(60417, 1, 23, 1) then
        player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.AKAMAFULA_SHOP_DIALOG)
    end
end

return entity
