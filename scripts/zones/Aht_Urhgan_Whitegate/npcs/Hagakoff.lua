-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Hagakoff
-- TODO: Stock needs to be modified based on
--       status of Astral Candescence
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.KATARS,            15448, }, -- (Requires Astral Candescence)
        { xi.item.DARKSTEEL_KATARS,  67760, },
        { xi.item.PATAS,             45760, }, -- (Requires Astral Candescence)
        { xi.item.BRONZE_DAGGER,       156, },
        { xi.item.DAGGER,             2030, },
        { xi.item.SAPARA,              776, },
        { xi.item.SCIMITAR,           4525, },
        { xi.item.TULWAR,            38800, }, -- (Requires Astral Candescence)
        { xi.item.TABAR,              6600, },
        { xi.item.DARKSTEEL_TABAR,  124305, }, -- (Requires Astral Candescence)
        { xi.item.BUTTERFLY_AXE,       672, },
        { xi.item.GREATAXE,           4550, }, -- (Requires Astral Candescence)
        { xi.item.BRONZE_ZAGHNAL,      344, },
        { xi.item.ZAGHNAL,           12540, }, -- (Requires Astral Candescence)
        { xi.item.ASH_CLUB,             72, },
        { xi.item.CHESTNUT_CLUB,      1740, }, -- (Requires Astral Candescence)
        { xi.item.ANGON,               238, },
    }

    player:showText(npc, ID.text.HAGAKOFF_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
