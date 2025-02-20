-----------------------------------
-- Area: Bastok Mines
--  NPC: Tibelda
-- Valdeaunia Regional Merchant
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.VALDEAUNIA) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.TIBELDA_CLOSED_DIALOG)
    else
        local stock =
        {
            4382,  29, --Frost Turnip
            638,  170, --Sage
        }

        player:showText(npc, ID.text.TIBELDA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
