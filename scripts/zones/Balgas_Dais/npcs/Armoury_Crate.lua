-----------------------------------
-- Area: Balgas Dais
--  NPC: Armoury Crate
-- Balgas Dais Burning Circle Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Divine Punishers
    [98] =
    {
        {
            { itemid = xi.item.FORSETIS_AXE, droprate = 250 }, -- forsetis_axe
            { itemid = xi.item.ARAMISS_RAPIER, droprate = 250 }, -- aramiss_rapier
            { itemid = xi.item.SPARTAN_CESTI, droprate = 250 }, -- spartan_cesti
            { itemid = xi.item.DOMINION_MACE, droprate = 250 }, -- dominion_mace
        },

        {
            { itemid = xi.item.NONE,             droprate = 250 }, -- nothing
            { itemid = xi.item.FUMA_KYAHAN,      droprate = 100 }, -- fuma_kyahan
            { itemid = xi.item.PEACE_RING,       droprate = 200 }, -- peace_ring
            { itemid = xi.item.ENHANCING_MANTLE, droprate = 200 }, -- enhancing_mantle
            { itemid = xi.item.MASTER_BELT,      droprate = 150 }, -- master_belt
            { itemid = xi.item.OCHIUDOS_KOTE,    droprate = 100 }, -- ochiudos_kote
        },

        {
            { itemid = xi.item.NONE,           droprate = 850 }, -- nothing
            { itemid = xi.item.HI_RERAISER,    droprate = 100 }, -- hi-reraiser
            { itemid = xi.item.VILE_ELIXIR_P1, droprate =  50 }, -- vile_elixir_+1
        },

        {
            { itemid = xi.item.PURPLE_ROCK,      droprate = 166 }, -- purple_rock
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate = 166 }, -- translucent_rock
            { itemid = xi.item.RED_ROCK,         droprate = 167 }, -- red_rock
            { itemid = xi.item.BLACK_ROCK,       droprate = 167 }, -- black_rock
            { itemid = xi.item.YELLOW_ROCK,      droprate = 167 }, -- yellow_rock
            { itemid = xi.item.WHITE_ROCK,       droprate = 167 }, -- white_rock
        },

        {
            { itemid = xi.item.PAINITE,     droprate = 125 }, -- painite
            { itemid = xi.item.AQUAMARINE,  droprate = 125 }, -- aquamarine
            { itemid = xi.item.FLUORITE,    droprate = 125 }, -- fluorite
            { itemid = xi.item.ZIRCON,      droprate = 125 }, -- zircon
            { itemid = xi.item.SUNSTONE,    droprate = 125 }, -- sunstone
            { itemid = xi.item.CHRYSOBERYL, droprate = 125 }, -- chrysoberyl
            { itemid = xi.item.MOONSTONE,   droprate = 125 }, -- moonstone
            { itemid = xi.item.JADEITE,     droprate = 125 }, -- jadeite
        },

        {
            { itemid = xi.item.NONE,         droprate = 517 }, -- nothing
            { itemid = xi.item.MAHOGANY_LOG, droprate = 333 }, -- mahogany_log
            { itemid = xi.item.EBONY_LOG,    droprate = 150 }, -- ebony_log
        },

        {
            { itemid = xi.item.STEEL_INGOT,     droprate = 350 }, -- steel_ingot
            { itemid = xi.item.MYTHRIL_INGOT,   droprate = 150 }, -- mythril_ingot
            { itemid = xi.item.DARKSTEEL_INGOT, droprate = 150 }, -- darksteel_ingot
            { itemid = xi.item.GOLD_INGOT,      droprate = 350 }, -- gold_ingot
        },
    },

    -- BCNM Treasure and Tribulations
    [100] =
    {
        {
            { itemid = xi.item.GUARDIANS_RING, droprate =  75 }, -- Guardians Ring
            { itemid = xi.item.KAMPFER_RING,   droprate =  32 }, -- Kampfer Ring
            { itemid = xi.item.CONJURERS_RING, droprate =  54 }, -- Conjurers Ring
            { itemid = xi.item.SHINOBI_RING,   droprate =  32 }, -- Shinobi Ring
            { itemid = xi.item.SLAYERS_RING,   droprate =  97 }, -- Slayers Ring
            { itemid = xi.item.SORCERERS_RING, droprate =  75 }, -- Sorcerers Ring
            { itemid = xi.item.SOLDIERS_RING,  droprate = 108 }, -- Soldiers Ring
            { itemid = xi.item.TAMERS_RING,    droprate =  22 }, -- Tamers Ring
            { itemid = xi.item.TRACKERS_RING,  droprate =  65 }, -- Trackers Ring
            { itemid = xi.item.DRAKE_RING,     droprate =  32 }, -- Drake Ring
            { itemid = xi.item.FENCERS_RING,   droprate =  32 }, -- Fencers Ring
            { itemid = xi.item.MINSTRELS_RING, droprate =  86 }, -- Minstrels Ring
            { itemid = xi.item.MEDICINE_RING,  droprate =  86 }, -- Medicine Ring
            { itemid = xi.item.ROGUES_RING,    droprate =  75 }, -- Rogues Ring
            { itemid = xi.item.RONIN_RING,     droprate =  11 }, -- Ronin Ring
            { itemid = xi.item.PLATINUM_RING,  droprate =  32 }, -- Platinum Ring
        },

        {
            { itemid = xi.item.ASTRAL_RING,              droprate = 376 }, -- Astral Ring
            { itemid = xi.item.PLATINUM_RING,            droprate =  22 }, -- Platinum Ring
            { itemid = xi.item.SCROLL_OF_QUAKE,          droprate =  65 }, -- Scroll Of Quake
            { itemid = xi.item.RAM_SKIN,                 droprate =  10 }, -- Ram Skin
            { itemid = xi.item.RERAISER,                 droprate =  11 }, -- Reraiser
            { itemid = xi.item.MYTHRIL_INGOT,            droprate =  22 }, -- Mythril Ingot
            { itemid = xi.item.LIGHT_SPIRIT_PACT,        droprate =  10 }, -- Light Spirit Pact
            { itemid = xi.item.SCROLL_OF_FREEZE,         droprate =  32 }, -- Scroll Of Freeze
            { itemid = xi.item.SCROLL_OF_REGEN_III,      droprate =  43 }, -- Scroll Of Regen Iii
            { itemid = xi.item.SCROLL_OF_RAISE_II,       droprate =  32 }, -- Scroll Of Raise Ii
            { itemid = xi.item.PETRIFIED_LOG,            droprate =  11 }, -- Petrified Log
            { itemid = xi.item.CORAL_FRAGMENT,           droprate =  11 }, -- Coral Fragment
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  11 }, -- Mahogany Log
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  43 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate = 108 }, -- Chunk Of Gold Ore
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  32 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  65 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.GOLD_INGOT,               droprate =  10 }, -- Gold Ingot
            { itemid = xi.item.DARKSTEEL_INGOT,          droprate =  11 }, -- Darksteel Ingot
            { itemid = xi.item.PLATINUM_INGOT,           droprate =  11 }, -- Platinum Ingot
            { itemid = xi.item.EBONY_LOG,                droprate =  11 }, -- Ebony Log
            { itemid = xi.item.RAM_HORN,                 droprate =  11 }, -- Ram Horn
            { itemid = xi.item.DEMON_HORN,               droprate =  11 }, -- Demon Horn
            { itemid = xi.item.MANTICORE_HIDE,           droprate =   9 }, -- Manticore Hide
            { itemid = xi.item.WYVERN_SKIN,              droprate =  11 }, -- Wyvern Skin
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  11 }, -- Handful Of Wyvern Scales
        },
    },

    -- BCNM Harem Scarem
    [106] =
    {
        {
            { itemid = xi.item.DHALMEL_HIDE, droprate = 1000 }, -- dhalmel_hide
        },

        {
            { itemid = xi.item.NONE,        droprate =  500 }, -- nothing
            { itemid = xi.item.GIANT_FEMUR, droprate =  500 }, -- giant_femur
        },

        {
            { itemid = xi.item.NONE,                  droprate = 500 }, -- nothing
            { itemid = xi.item.SLICE_OF_DHALMEL_MEAT, droprate = 500 }, -- slice_of_dhalmel_meat
        },

        {
            { itemid = xi.item.NONE,             droprate = 400 }, -- nothing
            { itemid = xi.item.MERCENARY_MANTLE, droprate = 150 }, -- mercenary_mantle
            { itemid = xi.item.BEATERS_MANTLE,   droprate = 150 }, -- beaters_mantle
            { itemid = xi.item.ESQUIRES_MANTLE,  droprate = 150 }, -- esquires_mantle
            { itemid = xi.item.HEALERS_MANTLE,   droprate = 150 }, -- healers_mantle
        },

        {
            { itemid = xi.item.NONE,           droprate = 400 }, -- nothing
            { itemid = xi.item.WIZARDS_SHIELD, droprate = 200 }, -- wizards_shield
            { itemid = xi.item.TRIMMERS_ASPIS, droprate = 200 }, -- trimmers_aspis
            { itemid = xi.item.WYVERN_TARGE,   droprate = 200 }, -- wyvern_targe
        },

        {
            { itemid = xi.item.NONE,                   droprate = 200 }, -- nothing
            { itemid = xi.item.SCROLL_OF_ERASE,        droprate = 200 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_DISPEL,       droprate = 200 }, -- scroll_of_dispel
            { itemid = xi.item.SCROLL_OF_MAGIC_FINALE, droprate = 200 }, -- scroll_of_magic_finale
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,  droprate = 200 }, -- scroll_of_utsusemi_ni
        },

        {
            { itemid = xi.item.NONE,                   droprate = 250 }, -- nothing
            { itemid = xi.item.SQUARE_OF_VELVET_CLOTH, droprate = 250 }, -- square_of_velvet_cloth
            { itemid = xi.item.SQUARE_OF_LINEN_CLOTH,  droprate = 250 }, -- square_of_linen_cloth
            { itemid = xi.item.SQUARE_OF_WOOL_CLOTH,   droprate = 250 }, -- square_of_wool_cloth
        },

        {
            { itemid = xi.item.NONE,            droprate = 600 }, -- nothing
            { itemid = xi.item.MANNEQUIN_HEAD,  droprate = 200 }, -- mannequin_head
            { itemid = xi.item.MANNEQUIN_HANDS, droprate = 200 }, -- mannequin_hands
        },
    },

    -- BCNM Royal Succession
    [108] =
    {
        {
            { itemid = xi.item.BUNCH_OF_WILD_PAMAMAS, droprate = 1000 }, -- bunch_of_wild_pamamas
        },

        {
            { itemid = xi.item.NONE,             droprate = 300 }, -- nothing
            { itemid = xi.item.DUSKY_STAFF,      droprate = 100 }, -- dusky_staff
            { itemid = xi.item.JONGLEURS_DAGGER, droprate = 100 }, -- jongleurs_dagger
            { itemid = xi.item.CALVELEYS_DAGGER, droprate = 100 }, -- calveleys_dagger
            { itemid = xi.item.SEALED_MACE,      droprate = 100 }, -- sealed_mace
            { itemid = xi.item.HIMMEL_STOCK,     droprate = 100 }, -- himmel_stock
            { itemid = xi.item.KAGEHIDE,         droprate = 100 }, -- kagehide
            { itemid = xi.item.OHAGURO,          droprate = 100 }, -- ohaguro
        },

        {
            { itemid =     xi.item.NONE, droprate = 100 }, -- nothing
            { itemid = xi.item.GENIN_EARRING, droprate = 300 }, -- genin_earring
            { itemid = xi.item.AGILE_GORGET, droprate = 300 }, -- agile_gorget
            { itemid = xi.item.JAGD_GORGET, droprate = 300 }, -- jagd_gorget
        },

        {
            { itemid =    xi.item.NONE, droprate = 370 }, -- nothing
            { itemid =  xi.item.TURQUOISE, droprate = 100 }, -- turquoise
            { itemid = xi.item.BUNCH_OF_PAMAMAS, droprate = 100 }, -- bunch_of_pamamas
            { itemid =  xi.item.SQUARE_OF_SILK_CLOTH, droprate = 110 }, -- square_of_silk_cloth
            { itemid =  xi.item.ROSEWOOD_LOG, droprate = 140 }, -- rosewood_log
            { itemid =  xi.item.PEARL, droprate = 180 }, -- pearl
        },

        {
            { itemid = xi.item.SCROLL_OF_PHALANX, droprate = 250 }, -- scroll_of_phalanx
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 250 }, -- scroll_of_absorb
            { itemid = xi.item.SCROLL_OF_REFRESH, droprate = 250 }, -- scroll_of_refresh
            { itemid = xi.item.SCROLL_OF_ERASE, droprate = 250 }, -- scroll_of_erase
        },

        {
            { itemid =   xi.item.NONE, droprate = 600 }, -- nothing
            { itemid = xi.item.GOLD_BEASTCOIN, droprate = 400 }, -- gold_beastcoin
        },
    },

    -- BCNM Wild Wild Whiskers
    [110] =
    {
        {
            { itemid = xi.item.HIGH_QUALITY_COEURL_HIDE, droprate = 1000 }, -- high-quality_coeurl_hide
        },

        {
            { itemid = xi.item.HIGH_QUALITY_COEURL_HIDE, droprate = 1000 }, -- high-quality_coeurl_hide
        },

        {
            { itemid = xi.item.HIGH_QUALITY_COEURL_HIDE, droprate = 1000 }, -- high-quality_coeurl_hide
        },

        {
            { itemid = xi.item.CHUNK_OF_ADAMAN_ORE, droprate = 1000 }, -- chunk_of_adaman_ore
        },

        {
            { itemid = xi.item.HERMES_QUENCHER, droprate = 1000 }, -- hermes_quencher
        },

        {
            { itemid = xi.item.ICARUS_WING, droprate = 1000 }, -- icarus_wing
        },

        {
            { itemid = xi.item.GLEEMANS_BELT,  droprate = 365 }, -- gleemans_belt
            { itemid = xi.item.PENITENTS_ROPE, droprate = 635 }, -- penitents_rope
        },

        {
            { itemid = xi.item.TELEPORT_RING_MEA,   droprate = 426 }, -- teleport_ring_mea
            { itemid = xi.item.TELEPORT_RING_YHOAT, droprate = 574 }, -- teleport_ring_yhoat
        },

        {
            { itemid = xi.item.NONE,         droprate = 848 }, -- nothing
            { itemid = xi.item.WALKURE_MASK, droprate =  58 }, -- walkure_mask
            { itemid = xi.item.HI_RERAISER,  droprate =  78 }, -- hi-reraiser
            { itemid = xi.item.EBONY_LOG,    droprate =  16 }, -- ebony_log
        },

        {
            { itemid = xi.item.YELLOW_ROCK,      droprate =  9 }, -- yellow_rock
            { itemid = xi.item.BLACK_ROCK,       droprate =  9 }, -- black_rock
            { itemid = xi.item.AQUAMARINE,       droprate = 16 }, -- aquamarine
            { itemid = xi.item.RED_ROCK,         droprate = 16 }, -- red_rock
            { itemid = xi.item.BLUE_ROCK,        droprate = 16 }, -- blue_rock
            { itemid = xi.item.PURPLE_ROCK,      droprate = 16 }, -- purple_rock
            { itemid = xi.item.MAHOGANY_LOG,     droprate = 33 }, -- mahogany_log
            { itemid = xi.item.CHRYSOBERYL,      droprate = 33 }, -- chrysoberyl
            { itemid = xi.item.ZIRCON,           droprate = 33 }, -- zircon
            { itemid = xi.item.STEEL_INGOT,      droprate = 49 }, -- steel_ingot
            { itemid = xi.item.DARKSTEEL_INGOT,  droprate = 49 }, -- darksteel_ingot
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate = 49 }, -- translucent_rock
            { itemid = xi.item.SUNSTONE,         droprate = 49 }, -- sunstone
            { itemid = xi.item.MOONSTONE,        droprate = 66 }, -- moonstone
            { itemid = xi.item.MYTHRIL_INGOT,    droprate = 82 }, -- mythril_ingot
            { itemid = xi.item.FLUORITE,         droprate = 82 }, -- fluorite
            { itemid = xi.item.GOLD_INGOT,       droprate = 98 }, -- gold_ingot
            { itemid = xi.item.JADEITE,          droprate = 98 }, -- jadeite
            { itemid = xi.item.PAINITE,          droprate = 98 }, -- painite
            { itemid = xi.item.VILE_ELIXIR_P1,   droprate = 99 }, -- vile_elixir_+1
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
