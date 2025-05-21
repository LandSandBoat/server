-----------------------------------
-- Area: Bastok Mines
--  NPC: Galdeo
--  Li'Telor Regional Merchant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.LITELOR) ~= xi.nation.BASTOK then
        player:showText(npc, zones[xi.zone.BASTOK_MINES].text.GALDEO_CLOSED_DIALOG)
    else
        local stock =
        {
            { 623,   119 }, -- Bay Leaves
            { 4154, 6440 }, -- Holy Water
        }

        player:showText(npc, zones[xi.zone.BASTOK_MINES].text.GALDEO_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
