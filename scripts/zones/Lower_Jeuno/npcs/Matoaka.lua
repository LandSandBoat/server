-----------------------------------
-- Area: Lower Jeuno
--  NPC: Matoaka
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        13327, 1250, -- Silver Earring
        13456, 1250, -- Silver Ring
        13328, 4140, -- Mythril Earring
    }

    player:showText(npc, ID.text.GEMS_BY_KSHAMA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
