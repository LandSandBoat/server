-----------------------------------
-- Area: Lower Jeuno
--  NPC: Creepstix
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        5023,   8160, -- Scroll of Goblin Gavotte
        4734,   7074, -- Scroll of Protectra II
        4738,   1700, -- Scroll of Shellra
        5089,  73740, -- Scroll of Gain-VIT
        5092,  77500, -- Scroll of Gain-MND
        5090,  85680, -- Scroll of Gain-AGI
        5093,  81900, -- Scroll of Gain-CHR
        5096,  73740, -- Scroll of Boost-VIT
        5099,  77500, -- Scroll of Boost-MND
        5097,  85680, -- Scroll of Boost-AGI
        5100,  81900, -- Scroll of Boost-CHR
        4849, 130378, -- Scroll of Addle
    }

    player:showText(npc, ID.text.JUNK_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
