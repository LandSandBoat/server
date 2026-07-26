-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Saluhwa
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.MAPLE_SHIELD,      605, astralCandescence = false },
        { xi.item.ELM_SHIELD,       1815, astralCandescence = false },
        { xi.item.MAHOGANY_SHIELD,  4980, astralCandescence = false },
        { xi.item.OAK_SHIELD,      15600, astralCandescence = false },
        { xi.item.ROUND_SHIELD,    64791, astralCandescence = true  },
    }

    player:showText(npc, ID.text.SALUHWA_SHOP_DIALOG)
    xi.besieged.shop(player, stock)
end

return entity
