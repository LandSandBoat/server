-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Rubahah
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.EAR_OF_MILLIONCORN,     48, astralCandescence = false },
        { xi.item.BAG_OF_IMPERIAL_FLOUR,  60, astralCandescence = true  },
        { xi.item.BAG_OF_IMPERIAL_RICE,   68, astralCandescence = true  },
        { xi.item.BAG_OF_COFFEE_BEANS,   316, astralCandescence = true  },
    }

    player:showText(npc, ID.text.RUBAHAH_SHOP_DIALOG)
    xi.besieged.shop(player, stock)
end

return entity
