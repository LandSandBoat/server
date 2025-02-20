-----------------------------------
-- Area: Port Jeuno
--  NPC: Gekko
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4150,  2387,    -- Eye Drops
        4148,   290,    -- Antidote
        4151,   367,    -- Echo Drops
        4112,   837,    -- Potion
        4128,  4445,    -- Ether
        4365,   120,    -- Rolanberry
        189,  36000,    -- Autumn's End
        188,  31224,    -- Acolyte's Grief
        5085, 50400,    -- Scroll of Regen IV
    }

    player:showText(npc, ID.text.DUTY_FREE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
