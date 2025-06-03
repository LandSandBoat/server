-----------------------------------
-- Area: Port Bastok
--  NPC: Zoby Quhyo
-- Elshimo Lowlands Regional Merchant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ELSHIMO_LOWLANDS) ~= xi.nation.BASTOK then
        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.ZOBYQUHYO_CLOSED_DIALOG)
    else
        local stock =
        {
            { 626,   234 }, -- Black Pepper
            { 612,    55 }, -- Kazham Peppers
            { 4432,   55 }, -- Kazham Pineapple
            { 632,   110 }, -- Kukuru Bean
            { 4390,   36 }, -- Mithran Tomato
            { 630,    88 }, -- Ogre Pumpkin
            { 1411, 1656 }, -- Phalaenopsis
        }

        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.ZOBYQUHYO_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
