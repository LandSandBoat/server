-----------------------------------
-- Area: Al Zahbi
--  NPC: Kahah Hobichai
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.RUSTY_BUCKET,  200, astralCandescence = false },
        { xi.item.PICKAXE,       200, astralCandescence = true  },
        { xi.item.SICKLE,        300, astralCandescence = true  },
        { xi.item.HATCHET,       500, astralCandescence = true  },
        { xi.item.BRONZE_KNIFE,  164, astralCandescence = false },
        { xi.item.KNIFE,        2425, astralCandescence = false },
    }

    player:showText(npc, ID.text.KAHAHHOBICHAI_SHOP_DIALOG)
    xi.besieged.shop(player, stock)
end

return entity
