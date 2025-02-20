-----------------------------------
-- Area: Rabao
--  NPC: Brave Wolf
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        12301, 31201,    -- Buckler
        12302, 60260,    -- Darksteel Buckler
        13979, 24373,    -- Silver Bangles
        12554, 66066,    -- Banded Mail
        12682, 35285,    -- Mufflers
        12810, 52552,    -- Breeches
        12938, 32382,    -- Sollerets
        12609,  9423,    -- Black Tunic
        12737,  4395,    -- White Mitts
        12865,  6279,    -- Black Slacks
        12993,  4084,    -- Sandals
        12578, 28654,    -- Padded Armor
        12706, 15724,    -- Iron Mittens
        12836, 23063,    -- Iron Subligar
        12962, 14327,    -- Leggins
    }

    player:showText(npc, ID.text.BRAVEWOLF_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
