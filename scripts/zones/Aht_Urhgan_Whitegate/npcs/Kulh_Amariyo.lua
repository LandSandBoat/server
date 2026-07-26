-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kulh Amariyo
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.CRAYFISH_1,     38, astralCandescence = false },
        { xi.item.YILANBALIGI,  1200, astralCandescence = true  },
        { xi.item.SAZANBALIGI,  1800, astralCandescence = true  },
        { xi.item.KAYABALIGI,   4650, astralCandescence = true  },
        { xi.item.ALABALIGI,     130, astralCandescence = true  },
    }

    player:showText(npc, ID.text.KULHAMARIYO_SHOP_DIALOG)
    xi.besieged.shop(player, stock)
end

return entity
