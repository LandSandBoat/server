-----------------------------------
-- Area: Port Bastok
--  NPC: Ilita
-- Linkshell Merchant
--   !pos -142 -1 -25 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.NEW_LINKSHELL,   6000 },
        { xi.item.PENDANT_COMPASS,  375 },
    }

    -- TODO: This shop is only open from 12 to 20.
    player:showText(npc, zones[xi.zone.PORT_BASTOK].text.ILITA_SHOP_DIALOG, xi.item.LINKSHELL)
    xi.shop.general(player, stock)
end

return entity
