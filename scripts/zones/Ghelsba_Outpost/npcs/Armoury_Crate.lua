-----------------------------------
-- Area: Ghelsba_Outpost
--  NPC: Armoury Crate
-- Ghelsba_Outpost Armoury_Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Wings of Fury
    [34] =
    {
        {
            { itemid = xi.item.BAT_FANG, droprate = 1000 }, -- Bat Fang
        },

        {
            { itemid = xi.item.THUNDER_SPIRIT_PACT, droprate = 306 }, -- Thunder Spirit Pact
            { itemid = xi.item.SCROLL_OF_INVISIBLE, droprate = 319 }, -- Scroll Of Invisible
            { itemid = xi.item.SCROLL_OF_SNEAK,     droprate = 125 }, -- Scroll Of Sneak
            { itemid = xi.item.SCROLL_OF_DEODORIZE, droprate = 222 }, -- Scroll Of Deodorize
        },

        {
            { itemid = xi.item.GANKO,             droprate = 153 }, -- Ganko
            { itemid = xi.item.PLATOON_EDGE,      droprate = 139 }, -- Platoon Edge
            { itemid = xi.item.PLATOON_AXE,       droprate =  83 }, -- Platoon Axe
            { itemid = xi.item.PLATOON_POLE,      droprate =  97 }, -- Platoon Pole
            { itemid = xi.item.PLATOON_DAGGER,    droprate = 125 }, -- Platoon Dagger
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 444 }, -- Mythril Beastcoin
            { itemid = xi.item.TRANSLUCENT_ROCK,  droprate =  56 }, -- Translucent Rock
        },

        {
            { itemid = xi.item.GUNROMARU,      droprate = 111 }, -- Gunromaru
            { itemid = xi.item.PLATOON_DAGGER, droprate = 139 }, -- Platoon Dagger
            { itemid = xi.item.PLATOON_EDGE,   droprate = 139 }, -- Platoon Edge
            { itemid = xi.item.PLATOON_LANCE,  droprate =  42 }, -- Platoon Lance
            { itemid = xi.item.PLATOON_SWORD,  droprate = 181 }, -- Platoon Sword
            { itemid = xi.item.PURPLE_ROCK,    droprate =  97 }, -- Purple Rock
            { itemid = xi.item.RED_ROCK,       droprate =  69 }, -- Red Rock
            { itemid = xi.item.WHITE_ROCK,     droprate =  14 }, -- White Rock
            { itemid = xi.item.BLACK_ROCK,     droprate =  28 }, -- Black Rock
            { itemid = xi.item.GREEN_ROCK,     droprate =  28 }, -- Green Rock
            { itemid = xi.item.YELLOW_ROCK,    droprate =  14 }, -- Yellow Rock
            { itemid = xi.item.BLUE_ROCK,      droprate =  69 }, -- Blue Rock
        },

        {
            { itemid = xi.item.NONE,        droprate = 389 }, -- nothing
            { itemid = xi.item.ASTRAL_RING, droprate = 167 }, -- astral_ring
            { itemid = xi.item.BAT_WING,    droprate = 444 }, -- bat_wing
        },
    },

    -- BCNM Petrifying Pair
    [35] =
    {
        {
            { itemid = xi.item.LIZARD_SKIN, droprate = 1000 }, -- Lizard Skin
        },

        {
            { itemid = xi.item.NONE,          droprate = 900 }, -- nothing
            { itemid = xi.item.LEAPING_BOOTS, droprate = 100 }, -- leaping_boots
        },

        {
            { itemid = xi.item.KATANA_OBI,   droprate =  50 }, -- Katana Obi
            { itemid = xi.item.RAPIER_BELT,  droprate =  75 }, -- Rapier Belt
            { itemid = xi.item.SCYTHE_BELT,  droprate = 175 }, -- Scythe Belt
            { itemid = xi.item.CHESTNUT_LOG, droprate = 175 }, -- Chestnut Log
            { itemid = xi.item.ELM_LOG,      droprate = 350 }, -- Elm Log
            { itemid = xi.item.STEEL_INGOT,  droprate = 100 }, -- Steel Ingot
        },

        {
            { itemid = xi.item.NONE,         droprate = 925 }, -- nothing (50%)
            { itemid = xi.item.KATANA_OBI,   droprate =  50 }, -- Katana Obi
            { itemid = xi.item.RAPIER_BELT,  droprate =  75 }, -- Rapier Belt
            { itemid = xi.item.SCYTHE_BELT,  droprate = 175 }, -- Scythe Belt
            { itemid = xi.item.CHESTNUT_LOG, droprate = 175 }, -- Chestnut Log
            { itemid = xi.item.ELM_LOG,      droprate = 350 }, -- Elm Log
            { itemid = xi.item.STEEL_INGOT,  droprate = 100 }, -- Steel Ingot
        },

        {
            { itemid = xi.item.AVATAR_BELT,          droprate = 105 }, -- Avatar Belt
            { itemid = xi.item.PICK_BELT,            droprate = 105 }, -- Pick Belt
            { itemid = xi.item.IRON_INGOT,           droprate = 131 }, -- Iron Ingot
            { itemid = xi.item.CHUNK_OF_IRON_ORE,    droprate = 131 }, -- Chunk Of Iron Ore
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE, droprate =  79 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.CHUNK_OF_SILVER_ORE,  droprate =  79 }, -- Chunk Of Silver Ore
            { itemid = xi.item.LAPIS_LAZULI,         droprate = 131 }, -- Lapis Lazuli
        },

        {
            { itemid = xi.item.JUG_OF_COLD_CARRION_BROTH, droprate = 552 }, -- Jug Of Cold Carrion Broth
            { itemid = xi.item.SCROLL_OF_ABSORB_AGI,      droprate = 263 }, -- Scroll Of Absorb-agi
            { itemid = xi.item.SCROLL_OF_ABSORB_INT,      droprate = 210 }, -- Scroll Of Absorb-int
            { itemid = xi.item.SCROLL_OF_ABSORB_VIT,      droprate = 289 }, -- Scroll Of Absorb-vit
            { itemid = xi.item.SCROLL_OF_DISPEL,          droprate = 105 }, -- Scroll Of Dispel
            { itemid = xi.item.SCROLL_OF_ERASE,           droprate =  79 }, -- Scroll Of Erase
            { itemid = xi.item.SCROLL_OF_MAGIC_FINALE,    droprate = 421 }, -- Scroll Of Magic Finale
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,     droprate =  79 }, -- Scroll Of Utsusemi Ni
        },

        {
            { itemid = xi.item.NONE,                   droprate = 736 }, -- nothing (25%)
            { itemid = xi.item.AXE_BELT,               droprate = 200 }, -- Axe Belt
            { itemid = xi.item.CESTUS_BELT,            droprate = 125 }, -- Cestus Belt
            { itemid = xi.item.CLEAR_TOPAZ,            droprate =  10 }, -- Clear Topaz
            { itemid = xi.item.DAGGER_BELT,            droprate =  75 }, -- Dagger Belt
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE, droprate = 100 }, -- Darksteel Ore
            { itemid = xi.item.GUN_BELT,               droprate =  25 }, -- Gun Belt
            { itemid = xi.item.HI_ETHER,               droprate = 175 }, -- Hi-ether
            { itemid = xi.item.LANCE_BELT,             droprate = 200 }, -- Lance Belt
            { itemid = xi.item.LIGHT_OPAL,             droprate =  75 }, -- Light Opal
            { itemid = xi.item.MACE_BELT,              droprate = 175 }, -- Mace Belt
            { itemid = xi.item.MYTHRIL_INGOT,          droprate = 200 }, -- Mythril Ingot
            { itemid = xi.item.ONYX,                   droprate =  25 }, -- Onyx
            { itemid = xi.item.SARASHI,                droprate = 250 }, -- Sarashi
            { itemid = xi.item.SHIELD_BELT,            droprate = 100 }, -- Shield Belt
            { itemid = xi.item.SONG_BELT,              droprate = 100 }, -- Song Belt
            { itemid = xi.item.STAFF_BELT,             droprate = 150 }, -- Staff Belt
            { itemid = xi.item.SILVER_INGOT,           droprate = 100 }, -- Silver Ingot
            { itemid = xi.item.TOURMALINE,             droprate = 125 }, -- Tourmaline
        },

        {
            { itemid = xi.item.NONE,                   droprate = 2210 }, -- nothing (50%)
            { itemid = xi.item.AXE_BELT,               droprate =  200 }, -- Axe Belt
            { itemid = xi.item.CESTUS_BELT,            droprate =  125 }, -- Cestus Belt
            { itemid = xi.item.CLEAR_TOPAZ,            droprate =   10 }, -- Clear Topaz
            { itemid = xi.item.DAGGER_BELT,            droprate =   75 }, -- Dagger Belt
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE, droprate =  100 }, -- Darksteel Ore
            { itemid = xi.item.GUN_BELT,               droprate =   25 }, -- Gun Belt
            { itemid = xi.item.HI_ETHER,               droprate =  175 }, -- Hi-ether
            { itemid = xi.item.LANCE_BELT,             droprate =  200 }, -- Lance Belt
            { itemid = xi.item.LIGHT_OPAL,             droprate =   75 }, -- Light Opal
            { itemid = xi.item.MACE_BELT,              droprate =  175 }, -- Mace Belt
            { itemid = xi.item.MYTHRIL_INGOT,          droprate =  200 }, -- Mythril Ingot
            { itemid = xi.item.ONYX,                   droprate =   25 }, -- Onyx
            { itemid = xi.item.SARASHI,                droprate =  250 }, -- Sarashi
            { itemid = xi.item.SHIELD_BELT,            droprate =  100 }, -- Shield Belt
            { itemid = xi.item.SONG_BELT,              droprate =  100 }, -- Song Belt
            { itemid = xi.item.STAFF_BELT,             droprate =  150 }, -- Staff Belt
            { itemid = xi.item.SILVER_INGOT,           droprate =  100 }, -- Silver Ingot
            { itemid = xi.item.TOURMALINE,             droprate =  125 }, -- Tourmaline
        },
    },

    -- BCNM Toadal Recall
    [36] =
    {
        {
            { itemid = xi.item.KING_TRUFFLE, droprate = 1000 }, -- king_truffle
        },

        {
            { itemid = xi.item.JUG_OF_SEEDBED_SOIL, droprate = 1000 }, -- jug_of_seedbed_soil
        },

        {
            { itemid = xi.item.NONE,             droprate = 200 }, -- nothing
            { itemid = xi.item.MAGICIANS_SHIELD, droprate = 200 }, -- magicians_shield
            { itemid = xi.item.MERCENARYS_TARGE, droprate = 200 }, -- mercenarys_targe
            { itemid = xi.item.BEATERS_ASPIS,    droprate = 200 }, -- beaters_aspis
            { itemid = xi.item.PILFERERS_ASPIS,  droprate = 200 }, -- pilferers_aspis
        },

        {
            { itemid = xi.item.NONE,            droprate = 250 }, -- nothing
            { itemid = xi.item.TRIMMERS_MANTLE, droprate = 250 }, -- trimmers_mantle
            { itemid = xi.item.GENIN_MANTLE,    droprate = 250 }, -- genin_mantle
            { itemid = xi.item.WARLOCKS_MANTLE, droprate = 250 }, -- warlocks_mantle
        },

        {
            { itemid = xi.item.NONE,                  droprate = 625 }, -- nothing
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_PHALANX,     droprate = 125 }, -- scroll_of_phalanx
            { itemid = xi.item.SCROLL_OF_ERASE,       droprate = 125 }, -- scroll_of_erase
        },

        {
            { itemid = xi.item.NONE,            droprate = 250 }, -- nothing
            { itemid = xi.item.MANNEQUIN_HEAD,  droprate = 250 }, -- mannequin_head
            { itemid = xi.item.MANNEQUIN_BODY,  droprate = 250 }, -- mannequin_body
            { itemid = xi.item.MANNEQUIN_HANDS, droprate = 250 }, -- mannequin_hands
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
