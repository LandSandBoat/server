-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Hagakoff
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.ANGON,               248, astralCandescence = false },
        { xi.item.DARKSTEEL_KATARS,  67760, astralCandescence = false },
        { xi.item.PATAS,             45760, astralCandescence = true  },
        { xi.item.BRONZE_DAGGER,       156, astralCandescence = false },
        { xi.item.DAGGER,             2030, astralCandescence = false },
        { xi.item.SAPARA,              776, astralCandescence = false },
        { xi.item.SCIMITAR,           4525, astralCandescence = false },
        { xi.item.TULWAR,            38800, astralCandescence = true  },
        { xi.item.TABAR,             66000, astralCandescence = false },
        { xi.item.DARKSTEEL_TABAR,  124305, astralCandescence = true  },
        { xi.item.BUTTERFLY_AXE,       672, astralCandescence = false },
        { xi.item.GREATAXE,           4550, astralCandescence = true  },
        { xi.item.BRONZE_ZAGHNAL,      344, astralCandescence = false },
        { xi.item.ZAGHNAL,           12540, astralCandescence = true  },
        { xi.item.ASH_CLUB,             72, astralCandescence = false },
        { xi.item.CHESTNUT_CLUB,      1740, astralCandescence = true  },
    }

    player:showText(npc, ID.text.HAGAKOFF_SHOP_DIALOG)
    xi.besieged.shop(player, stock)
end

return entity
