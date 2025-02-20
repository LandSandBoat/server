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
        90,     200,    -- Rusty Bucket
        605,    200,    -- Pickaxe (Requires Astral Candescence)
        1020,   300,    -- Sickle (Requires Astral Candescence)
        1021,   500,    -- Hatchet (Requires Astral Candescence)
        16465,  164,    -- Bronze Knife
        16466, 2425     -- Knife
    }

    player:showText(npc, ID.text.KAHAHHOBICHAI_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
