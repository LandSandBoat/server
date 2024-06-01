-----------------------------------
-- Area: Boneyard Gully
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- ENM: Sheep in Antlion's Clothing
    [674] =
    {
        {
            { itemid = xi.item.SQUARE_OF_GALATEIA,     droprate = 268 },  -- Square of Galateia (26.8% Drop Rate)
            { itemid = xi.item.SQUARE_OF_KEJUSU_SATIN, droprate = 266 },  -- Kejusu Satin
            { itemid = xi.item.POT_OF_VIRIDIAN_URUSHI, droprate = 342 },  -- Viridian Urushi
        },

        {
            { itemid = xi.item.NONE,         droprate = 944 }, -- nothing
            { itemid = xi.item.CLOUD_EVOKER, droprate =  56 }, -- Cloud Evoker
        },

        {
            { itemid = xi.item.HAGUN,            droprate =  82 }, -- Hagun
            { itemid = xi.item.MARTIAL_AXE,      droprate =  92 }, -- Martial Axe
            { itemid = xi.item.MARTIAL_WAND,     droprate =  63 }, -- Martial Wand
            { itemid = xi.item.FORAGERS_MANTLE,  droprate = 105 }, -- Forager's Mantle
            { itemid = xi.item.HARMONIAS_TORQUE, droprate = 121 }, -- Harmonia's Torque
        },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        xi.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
