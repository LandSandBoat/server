-----------------------------------
-- Area: Port Windurst
--  NPC: Hohbiba-Mubiba
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        17051,  1440, 1,    -- Yew Wand
        17090,  3642, 1,    -- Elm Staff
        17097, 18422, 1,    -- Elm Pole
        17026,  4945, 2,    -- Bone Cudgel
        17096,  4669, 2,    -- Holly Pole
        17049,    47, 3,    -- Maple Wand
        17050,   340, 3,    -- Willow Wand
        17059,    91, 3,    -- Bronze Rod
        17024,    66, 3,    -- Ash Club
        17025,  1600, 3,    -- Chestnut Club
        17088,    58, 3,    -- Ash Staff
        17089,   584, 3,    -- Holly Staff
        17095,   386, 3,    -- Ash Pole
    }

    player:showText(npc, ID.text.HOHBIBAMUBIBA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
