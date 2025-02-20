-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Dabih Jajalioh

-- TODO: Add support for occasional stock.
-----------------------------------
local ID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        948,      60,    -- Carnation
        636,     119,    -- Chamomile
        958,     120,    -- Marguerite
        949,      96,    -- Rain Lily
        941,      80,    -- Red Rose
        951,     110,    -- Wijnruit
        --[[
        957,     120,    -- Amaryllis (Occasionally)
        574,     900,    -- Fruit Seeds (Occasionally)
        1239,    490,    -- Goblin Doll (Occasionally)
        1240,    165,    -- Koma (Occasionally)
        956,     120,    -- Lilac (Occasionally)
        1446,  50000,    -- Lacquer Tree Log (Occasionally)
        1441, 250000,    -- Libation Abjuration (Occasionally)
        630,      88,    -- Ogre Pumpkin (Occasionally)
        4750, 500000,    -- Scroll of Reraise III (Occasionally)
        1241,    354,    -- Twinkle Powder (Occasionally)
        2312,   1040,    -- Chocobo Egg (Occasionally)
        --]]
    }

    player:showText(npc, ID.text.DABIHJAJALIOH_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.JEUNO)
end

return entity
