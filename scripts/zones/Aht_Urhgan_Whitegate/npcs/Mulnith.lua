-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mulnith
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.ROAST_MUSHROOM,  344, astralCandescence = false },
        { xi.item.SIS_KEBABI,     2000, astralCandescence = true  },
        { xi.item.BALIK_SIS,      3000, astralCandescence = true  },
    }

    player:showText(npc, ID.text.MULNITH_SHOP_DIALOG)
    xi.besieged.shop(player, stock)
end

return entity
