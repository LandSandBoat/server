-----------------------------------
-- Area: Selbina
--  NPC: Quelpia
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4610,   585,    -- Scroll of Cure II
        4611,  3261,    -- Scroll of Cure III
        4616, 10080,    -- Scroll of Curaga II
        4620,  5178,    -- Scroll of Raise
        4629, 31500,    -- Scroll of Holy
        4632, 10080,    -- Scroll of Dia II
        4637,  8100,    -- Scroll of Banish II
        4652,  6366,    -- Scroll of Protect II
        4657, 15840,    -- Scroll of Shell II
        4665, 18000,    -- Scroll of Haste
        4708,  4644,    -- Scroll of Enfire
        4709,  3688,    -- Scroll of Enblizzard
        4710,  2250,    -- Scroll of Enaero
        4711,  1827,    -- Scroll of Enstone
        4712,  1363,    -- Scroll of Enthunder
        4713,  6366,    -- Scroll of Enwater
    }

    player:showText(npc, ID.text.QUELPIA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
