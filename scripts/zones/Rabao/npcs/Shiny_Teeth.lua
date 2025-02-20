-----------------------------------
-- Area: Rabao
--  NPC: Shiny Teeth
-- !pos -30 8 99 247
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        16450,   1867,    -- Dagger
        16460,  11128,    -- Kris
        16466,   2231,    -- Knife
        16552,   4163,    -- Scimitar
        16553,  35308,    -- Tulwar
        16558,  62560,    -- Falchion
        17060,   2439,    -- Rod
        16401, 103803,    -- Jamadhars
        17155,  23887,    -- Composite Bow
        17298,    294,    -- Tathlum
        17320,      7,    -- Iron Arrow
        17340,     92,    -- Bullet
        17315,   5460,    -- Riot Grenade
        17284,   8996,    -- Chakram
    }

    player:showText(npc, ID.text.SHINY_TEETH_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
