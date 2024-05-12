-----------------------------------
-- Area: Chamber of Oracles
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- KSNM Eye of the Storm
    [198] =
    {
        {
            { itemid = xi.item.WYVERN_WING, droprate = 1000 }, -- Wyvern Wing
        },

        {
            { itemid = xi.item.WYVERN_SKIN, droprate = 1000 }, -- Wyvern Skin
        },

        {
            { itemid = xi.item.GIL, droprate = 1000, amount = 24000 }, -- gil

        },

        {
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate = 216 }, -- Damascene Cloth
            { itemid = xi.item.DAMASCUS_INGOT,             droprate = 295 }, -- Damascus Ingot
            { itemid = xi.item.WOODVILLES_AXE,             droprate = 239 }, -- Woodville's Axe
            { itemid = xi.item.THANATOS_BASELARD,          droprate = 231 }, -- Thanatos Baselard
            { itemid = xi.item.WYVERN_PERCH,               droprate = 231 }, -- Wyvern Perch
            { itemid = xi.item.BALINS_SWORD,               droprate = 231 }, -- Balin's Sword
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate = 231 }, -- Beetle Blood
        },

        {
            { itemid = xi.item.BOURDONASSE,    droprate = 104 }, -- Bourdonasse
            { itemid = xi.item.VILE_ELIXIR_P1, droprate =  86 }, -- Vile Elixir +1
            { itemid = xi.item.VILE_ELIXIR,    droprate =  22 }, -- Vile Elixir
            { itemid = xi.item.POLE_GRIP,      droprate = 146 }, -- Pole Grip
            { itemid = xi.item.SWORD_STRAP,    droprate = 240 }, -- Sword Strap
        },

        {
            { itemid = xi.item.ZISKAS_CROSSBOW,       droprate = 287 }, -- Ziska's Crossbow
            { itemid = xi.item.UNJI,                  droprate = 216 }, -- Unji
            { itemid = xi.item.TAILLEFERS_DAGGER,     droprate = 198 }, -- Taillifer's Dagger
            { itemid = xi.item.SCHILTRON_SPEAR,       droprate = 287 }, -- Schiltron Spear
            { itemid = xi.item.SCROLL_OF_THUNDER_III, droprate = 287 }, -- Thunder III
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,          droprate =  52 }, -- Coral Fragment
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,  droprate =  56 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.DEMON_HORN,              droprate =  41 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,               droprate =  63 }, -- Ebony Log
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,       droprate =  52 }, -- Chunk Of Gold Ore
            { itemid = xi.item.SPOOL_OF_GOLD_THREAD,    droprate =  26 }, -- Spool Of Gold Thread
            { itemid = xi.item.SLAB_OF_GRANITE,         droprate =  11 }, -- Slab Of Granite
            { itemid = xi.item.HI_RERAISER,             droprate =  37 }, -- Hi-reraiser
            { itemid = xi.item.MAHOGANY_LOG,            droprate = 101 }, -- Mahogany Log
            { itemid = xi.item.MYTHRIL_INGOT,           droprate =  30 }, -- Mythril Ingot
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,    droprate =  52 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.PETRIFIED_LOG,           droprate = 116 }, -- Petrified Log
            { itemid = xi.item.PHOENIX_FEATHER,         droprate =  15 }, -- Phoenix Feather
            { itemid = xi.item.PHILOSOPHERS_STONE,      droprate =  56 }, -- Philosophers Stone
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,   droprate =  45 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH, droprate =  22 }, -- Square Of Rainbow Cloth
            { itemid = xi.item.RAM_HORN,                droprate =  67 }, -- Ram Horn
            { itemid = xi.item.SQUARE_OF_RAXA,          droprate = 119 }, -- Square Of Raxa
            { itemid = xi.item.RERAISER,                droprate =  45 }, -- Reraiser
            { itemid = xi.item.NONE,                    droprate = 400 }, -- Nothing
        },

        {
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH, droprate =  56 }, -- Square Of Damascene Cloth
            { itemid = xi.item.DAMASCUS_INGOT,            droprate =  93 }, -- Damascus Ingot
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,    droprate =  56 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.PHILOSOPHERS_STONE,        droprate = 157 }, -- Philosophers Stone
            { itemid = xi.item.PHOENIX_FEATHER,           droprate = 176 }, -- Phoenix Feather
            { itemid = xi.item.SQUARE_OF_RAXA,            droprate = 109 }, -- Square Of Raxa
            { itemid = xi.item.NONE,                      droprate = 500 }, -- Nothing
        }
    }

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
