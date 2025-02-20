-----------------------------------
-- Area: Nashmau
--  NPC: Pipiroon
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        17313, 1204,    -- Grenade
        17315, 6000,    -- Riot Grenade
        928,    515,    -- Bomb Ash
        2873, 10000,     -- Nashmau Waystone
    }

    player:showText(npc, ID.text.PIPIROON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
