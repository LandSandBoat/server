-----------------------------------
-- Area: Windurst_Woods
--  NPC: Nhobi Zalkia
-- Only sells when Windurst controlls Kuzotz Region
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.KUZOTZ) == xi.nation.WINDURST then
        local stock =
        {
            { xi.item.THUNDERMELON,   341 },
            { xi.item.CACTUAR_NEEDLE, 976 },
            { xi.item.WATERMELON,     210 },
        }

        player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.NHOBI_ZALKIA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    else
        player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.NHOBI_ZALKIA_CLOSED_DIALOG)
    end
end

return entity
