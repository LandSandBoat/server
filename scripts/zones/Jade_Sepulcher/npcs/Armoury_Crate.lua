-----------------------------------
-- Area: Jade Sepulcher
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- ISNM Shadows of the Mind
    [1153] =
    {
        {
            { itemid = xi.item.ICARUS_WING,         droprate = 250 },
            { itemid = xi.item.INTELLIGENCE_POTION, droprate = 250 },
            { itemid = xi.item.MIND_POTION,         droprate = 250 },
            { itemid = xi.item.CHARISMA_POTION,     droprate = 250 },
        },

        {
            { itemid = xi.item.AHRIMAN_WING,              droprate = 250 },
            { itemid = xi.item.BRASS_TANK,                droprate = 250 },
            { itemid = xi.item.MERROW_SCALE,              droprate = 250 },
            { itemid = xi.item.BOTTLE_OF_SIEGLINDE_PUTTY, droprate = 250 },
        },

        {
            { itemid = xi.item.SCROLL_OF_RERAISE_III,  droprate = 125 },
            { itemid = xi.item.SCROLL_OF_ERASE,        droprate = 125 },
            { itemid = xi.item.SCROLL_OF_PROTECT_IV,   droprate = 125 },
            { itemid = xi.item.SCROLL_OF_PROTECTRA_IV, droprate = 125 },
            { itemid = xi.item.SCROLL_OF_QUAKE,        droprate = 125 },
            { itemid = xi.item.SCROLL_OF_WATER_IV,     droprate = 125 },
            { itemid = xi.item.SCROLL_OF_BLIZZARD_IV,  droprate = 125 },
            { itemid = xi.item.SCROLL_OF_DISPEL,       droprate = 125 },
        },

        {
            { itemid = xi.item.CHOCOBO_EGG_SOMEWHAT_WARM, droprate = 1000 },
        },

        {
            { itemid = xi.item.PUK_WING, droprate = 1000 },
        },

        {
            { itemid = xi.item.NONE,             droprate = 600 },
            { itemid = xi.item.COMPANY_FLEURET,  droprate = 100 },
            { itemid = xi.item.MAGNET_KNIFE,     droprate = 100 },
            { itemid = xi.item.SACRIFICE_TORQUE, droprate = 100 },
            { itemid = xi.item.TOURNAMENT_LANCE, droprate = 100 },
        },

        {
            { itemid = xi.item.NONE,                      droprate = 760 },
            { itemid = xi.item.BUFFALO_HORN,              droprate =  30 },
            { itemid = xi.item.PIECE_OF_HABU_SKIN,        droprate =  30 },
            { itemid = xi.item.SQUARE_OF_KARAKUL_CLOTH,   droprate =  30 },
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH,   droprate =  30 },
            { itemid = xi.item.SQUARE_OF_RAXA,            droprate =  30 },
            { itemid = xi.item.SQUARE_OF_RED_GRASS_CLOTH, droprate =  30 },
            { itemid = xi.item.POT_OF_URUSHI,             droprate =  30 },
            { itemid = xi.item.SQUARE_OF_WAMOURA_CLOTH,   droprate =  30 },
        },

        {
            { itemid = xi.item.BEHEMOTH_HORN,         droprate = 200 },
            { itemid = xi.item.DRAGON_TALON,          droprate = 200 },
            { itemid = xi.item.CHUNK_OF_KHROMA_ORE,   droprate = 175 },
            { itemid = xi.item.CHUNK_OF_LUMINIUM_ORE, droprate = 425 },
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
