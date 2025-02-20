-----------------------------------
-- Area: Bibiki Bay
--  NPC: Pohka Chichiyowahl
-- !pos -415 -2 -430 4
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        17388,  1238, 3,    -- Fastwater F. Rod
        17382, 11845, 3,    -- S.H. Fishing Rod
        4148,    290, 3,    -- Antidote
    }

    player:showText(npc, ID.text.POHKA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
