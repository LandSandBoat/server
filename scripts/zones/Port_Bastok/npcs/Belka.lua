-----------------------------------
-- Area: Port Bastok
--  NPC: Belka
-- Derfland Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.DERFLAND) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.BELKA_CLOSED_DIALOG)
    else
        local stock =
        {
            4352,  128,    -- Derfland Pear
            617,   142,    -- Ginger
            4545,   62,    -- Gysahl Greens
            1412, 1656,    -- Olive Flower
            633,    14,    -- Olive Oil
            951,   110,    -- Wijnruit
        }

        player:showText(npc, ID.text.BELKA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
