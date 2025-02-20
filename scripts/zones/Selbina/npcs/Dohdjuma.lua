-----------------------------------
-- Area: Selbina
--  NPC: Dohdjuma
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        611,    36,    -- Rye Flour
        5011,  233,    -- Scroll of Sheepfoe Mambo
        4150, 2335,    -- Eye Drops
        4148,  284,    -- Antidote
        4509,   10,    -- Distilled Water
        4112,  819,    -- Potion
        17395,  10,    -- Lugworm
        4378,   54,    -- Selbina Milk
        4490,  432,    -- Pickled Herring
        4559, 4485,    -- Herb Quus
        2866, 9200,    -- Selbina Waystone
    }

    player:showText(npc, ID.text.DOHDJUMA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
