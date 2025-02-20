-----------------------------------
-- Area: Selbina
--  NPC: Torapiont
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        16411, 11491,    -- Claws
        16451,  7727,    -- Mythril Dagger
        16513, 11588,    -- Tuck
        16584, 37800,    -- Mythril Claymore
        16643, 11040,    -- Battleaxe
        16705,  4095,    -- Greataxe
        17050,   333,    -- Willow Wand
        17051,  1409,    -- Yew Wand
        17089,   571,    -- Holly Staff
        17307,     9,    -- Dart
        17336,     5,    -- Crossbow Bolt
        17318,     3,    -- Wooden Arrow
        17320,     7,    -- Iron Arrow
    }

    player:showText(npc, ID.text.TORAPIONT_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
