-----------------------------------
-- Area: Bibiki Bay
--  NPC: Pohka Chichiyowahl
-- !pos -415 -2 -430 4
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FASTWATER_FISHING_ROD,    1238, 3 },
        { xi.item.SINGLE_HOOK_FISHING_ROD, 11845, 3 },
        { xi.item.ANTIDOTE,                  290, 3 },
    }

    player:showText(npc, zones[xi.zone.BIBIKI_BAY].text.POHKA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
