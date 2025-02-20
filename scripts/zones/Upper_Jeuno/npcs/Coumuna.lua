-----------------------------------
-- Area: Upper Jeuno
--  NPC: Coumuna
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        16705,  4550,    -- Greataxe
        16518, 31000,    -- Mythril Degen
        16460, 12096,    -- Kris
        16467, 14560,    -- Mythril Knife
        16399, 15488,    -- Katars
        16589, 13962,    -- Two-Handed Sword
        16412, 29760,    -- Mythril Claws
        16567, 85250,    -- Knight's Sword
        16644, 48600,    -- Mythril Axe
        17061,  6256,    -- Mythril Rod
        17027, 11232,    -- Oak Cudgel
        17036, 18048,    -- Mythril Mace
        17044,  6558,    -- Warhammer
        17098, 37440,    -- Oak Pole
        16836, 44550,    -- Halberd
        16774, 10596,    -- Scythe
        17320,     8,    -- Iron Arrow
    }

    player:showText(npc, ID.text.VIETTES_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
