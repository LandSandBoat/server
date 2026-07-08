-----------------------------------
-- Area: Al Zahbi
--  NPC: Kahah Hobichai
-- TODO: Stock needs to be modified based on
--       status of Astral Candescence
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.RUSTY_BUCKET,  200, },
        { xi.item.PICKAXE,       200, }, -- (Requires Astral Candescence)
        { xi.item.SICKLE,        300, }, -- (Requires Astral Candescence)
        { xi.item.HATCHET,       500, }, -- (Requires Astral Candescence)
        { xi.item.BRONZE_KNIFE,  164, },
        { xi.item.KNIFE,        2425, },
    }

    player:showText(npc, ID.text.KAHAHHOBICHAI_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
