-----------------------------------
-- Area: Port Windurst
--  NPC: Khel Pahlhama
--  Linkshell Merchant
-- !pos 21 -2 -20 240
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        512,  8000,    -- Linkshell
        16285, 375,    -- Pendant Compass
    }

    player:showText(npc, ID.text.KHEL_PAHLHAMA_SHOP_DIALOG, 513)
    xi.shop.general(player, stock)
end

return entity
