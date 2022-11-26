-----------------------------------
-- Abyssea Sturdy Pyxis - Item
-----------------------------------
require('scripts/globals/items')
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.item = {}

---------------------------------
-- drop id's for items
-- use zone id as the key
---------------------------------
-- Containing Ore actually
local commonDrops =
{
    xi.items.CHUNK_OF_FIRE_ORE,
    xi.items.CHUNK_OF_ICE_ORE,
    xi.items.CHUNK_OF_WIND_ORE,
    xi.items.CHUNK_OF_EARTH_ORE,
    xi.items.CHUNK_OF_LIGHTNING_ORE,
    xi.items.CHUNK_OF_WATER_ORE,
    xi.items.CHUNK_OF_LIGHT_ORE,
    xi.items.CHUNK_OF_DARK_ORE,
}

local itemDrops =
{
    [xi.zone.ABYSSEA_KONSCHTAT ] =
    {
        xi.items.HANDFUL_OF_CLOT_PLASMA,
        xi.items.SCROLL_OF_WATER_V,
        xi.items.SLICE_OF_DRAGON_MEAT,
        xi.items.SLICE_OF_BUFFALO_MEAT,
        xi.items.SQUARE_OF_SHAGREEN,
        xi.items.FIENDISH_SKIN,
        xi.items.LARIMAR,
        xi.items.CHUNK_OF_DARK_ORE,
        xi.items.HELIODOR,
        xi.items.IOLITE,
        xi.items.CHUNK_OF_KHROMA_ORE,
        xi.items.CHUNK_OF_LIGHTNING_ORE,
        xi.items.CHUNK_OF_PHRYGIAN_ORE,
        xi.items.CHUNK_OF_WOOTZ_ORE,
        xi.items.SQUARE_OF_DAMASCENE_CLOTH,
        xi.items.SLICE_OF_COEURL_MEAT,
        xi.items.SCROLL_OF_KNIGHTS_MINNE_V,
    },

    [xi.zone.ABYSSEA_TAHRONGI] =
    {
        xi.items.FLOCON_DE_MER,
        xi.items.WATER_SPIDERS_WEB,
        xi.items.CORAL_FRAGMENT,
        xi.items.SCROLL_OF_BARAMNESRA,
        xi.items.SCROLL_OF_STONE_V,
        xi.items.SCROLL_OF_WATER_V,
        xi.items.SCROLL_OF_SHELL_V,
        xi.items.SCROLL_OF_CURE_VI,
        xi.items.SCROLL_OF_FOE_REQUIEM_VII,
        xi.items.SCROLL_OF_KNIGHTS_MINNE_V,
        xi.items.SCROLL_OF_AISHA_ICHI,
        xi.items.CHUNK_OF_DARKSTEEL_ORE,
        xi.items.HANDFUL_OF_CLOT_PLASMA,
        xi.items.DEATHSTONE,
        xi.items.SPINEL,
        xi.items.CHUNK_OF_DURIUM_ORE,
        xi.items.SAPPHIRE,
        xi.items.CHUNK_OF_LIGHTNING_ORE,
        xi.items.EMERALD,
        xi.items.SLICE_OF_DRAGON_MEAT,
        xi.items.TARNISHED_PINCER,
        xi.items.CHUNK_OF_PHRYGIAN_ORE,
        xi.items.RUBY,
        xi.items.PIECE_OF_ANGEL_SKIN,
        xi.items.PHILOSOPHERS_STONE,
        xi.items.CLUMP_OF_ALKALINE_HUMUS,
        xi.items.CLUMP_OF_ACIDIC_HUMUS,
        xi.items.EFT_EGG,
        xi.items.QUIVERING_EFT_EGG,
        xi.items.SHOCKING_WHISKER,
        xi.items.SMOOTH_WHISKER,
        xi.items.RESILIENT_MANE,
        xi.items.CHUNK_OF_COCKATRICE_TAILMEAT,
        xi.items.EXORCISED_SKULL,
    },

    [xi.zone.ABYSSEA_LA_THEINE] =
    {
        xi.items.CHUNK_OF_WATER_ORE,
        xi.items.POT_OF_URUSHI,
        xi.items.WINTER_PUK_EGG,
        xi.items.GIANT_AGARICUS_MUSHROOM,
        xi.items.FILTHY_GNOLE_CLAW,
        xi.items.OVERSIZED_SOCK,
        xi.items.STAR_SAPPHIRE,
        xi.items.CHUNK_OF_PHRYGIAN_ORE,
        xi.items.CHUNK_OF_ORICHALCUM_ORE,
        xi.items.LACQUER_TREE_LOG,
        xi.items.CHUNK_OF_KHROMA_ORE,
        xi.items.SQUARE_OF_GALATEIA,
        xi.items.EBONY_LOG,
        xi.items.CHUNK_OF_EARTH_ORE,
        xi.items.CHUNK_OF_DURIUM_ORE,
        xi.items.SLICE_OF_DRAGON_MEAT,
        xi.items.CLARITE,
        xi.items.SLICE_OF_COEURL_MEAT,
        xi.items.SLICE_OF_BUFFALO_MEAT,
        xi.items.SCROLL_OF_WATER_V,
        xi.items.SCROLL_OF_STONE_V,
        xi.items.SCROLL_OF_PROTECT_V,
        xi.items.SCROLL_OF_KNIGHTS_MINNE_V,
        xi.items.SCROLL_OF_FOE_REQUIEM_VII,
        xi.items.SCROLL_OF_ASPIR_II,
        xi.items.SCROLL_OF_ARMYS_PAEON_VI,
        xi.items.DRAGON_HEART,
        xi.items.SCROLL_OF_AISHA_ICHI,
        xi.items.GARGANTUAN_BLACK_TIGER_FANG,
        xi.items.BUG_EATEN_HAT,
    },

    [xi.zone.ABYSSEA_ATTOHWA] =
    {
        xi.items.AHTAPOT,
        xi.items.CHICKEN_BONE,
        xi.items.CORAL_FRAGMENT,
        xi.items.DARKSTEEL_INGOT,
        xi.items.SLICE_OF_DRAGON_MEAT,
        xi.items.FULMENITE,
        xi.items.GOLD_INGOT,
        xi.items.CHUNK_OF_HYDRA_MEAT,
        xi.items.CHUNK_OF_WOOTZ_ORE,
        xi.items.EARTH_BEAD,
        xi.items.LIGHTNING_BEAD,
        xi.items.DARK_BEAD,
        xi.items.SQUARE_OF_KHROMATED_LEATHER,
        xi.items.BLOODWOOD_LOG,
        xi.items.CLARITE,
        xi.items.BEECH_LOG,
        xi.items.CHUNK_OF_PHRYGIAN_ORE,
        xi.items.IOLITE,
        xi.items.SCROLL_OF_ADDLE,
        xi.items.SCROLL_OF_BOOST_MND,
        xi.items.SCROLL_OF_BOOST_VIT,
        xi.items.SCROLL_OF_EARTH_CAROL_II,
        xi.items.SCROLL_OF_GAIN_MND,
        xi.items.SCROLL_OF_GAIN_VIT,
        xi.items.SCROLL_OF_MYOSHU_ICHI,
        xi.items.SCROLL_OF_STONEJA,
        xi.items.SCROLL_OF_WATER_CAROL_II,
        xi.items.ANIMUS_AUGEO_SCHEMA,
        xi.items.SCROLL_OF_MAGES_BALLAD_III,
        xi.items.SCROLL_OF_REFRESH_II,
        xi.items.SCROLL_OF_WATERJA,
        xi.items.HANDFUL_OF_BONE_CHIPS,
        xi.items.ERUCA_EGG,
        xi.items.EXTENDED_EYESTALK,
        xi.items.MANGLED_COCKATRICE_SKIN,
        xi.items.VIAL_OF_UNDYING_OOZE,
        xi.items.WITHERED_COCOON,
        xi.items.RAVAGERS_CALLIGAE,
        xi.items.TANTRA_GAITERS,
        xi.items.ORISON_DUCKBILLS,
        xi.items.GOETIA_SABOTS,
        xi.items.ESTOQUEURS_HOUSEAUX,
        xi.items.RAIDERS_POULAINES,
    },

    [xi.zone.ABYSSEA_MISAREAUX] =
    {
        xi.items.BEECH_LOG,
        xi.items.WILD_ONION,
        xi.items.OXBLOOD_ORB,
        xi.items.ORICHALCUM_INGOT,
        xi.items.MOLYBDENUM_INGOT,
        xi.items.SQUARE_OF_MARID_LEATHER,
        xi.items.PIECE_OF_LACQUER_TREE_LUMBER,
        xi.items.CHUNK_OF_KHROMA_ORE,
        xi.items.ICE_BEAD,
        xi.items.FLOCON_DE_MER,
        xi.items.FIRE_BEAD,
        xi.items.PIECE_OF_EBONY_LUMBER,
        xi.items.DIVINE_LOG,
        xi.items.DEMON_HORN,
        xi.items.SQUARE_OF_DAMASCENE_CLOTH,
        xi.items.CORAL_FRAGMENT,
        xi.items.SLICE_OF_COEURL_MEAT,
        xi.items.BLACK_PEARL,
        xi.items.SCROLL_OF_ADDLE,
        xi.items.SCROLL_OF_AERO_V,
        xi.items.PLATE_OF_INDI_SLOW,
        xi.items.SCROLL_OF_BREAK,
        xi.items.SCROLL_OF_EARTH_CAROL_II,
        xi.items.SCROLL_OF_ENDARK,
        xi.items.SCROLL_OF_ENLIGHT,
        xi.items.SCROLL_OF_GAIN_MND,
        xi.items.SCROLL_OF_GAIN_VIT,
        xi.items.SCROLL_OF_MAGES_BALLAD_III,
        xi.items.SCROLL_OF_SENTINELS_SCHERZO,
        xi.items.SCROLL_OF_STONEJA,
        xi.items.SCROLL_OF_WATER_CAROL_II,
        xi.items.SCROLL_OF_WATERJA,
        xi.items.AVIAN_REMEX,
        xi.items.BLACK_RABBIT_TAIL,
        xi.items.HARDENED_RAPTOR_SKIN,
        xi.items.MOCKING_BEAK,
        xi.items.SPOTTED_FLYFROND,
        xi.items.CREED_SABATONS,
        xi.items.BALE_SOLLERETS,
        xi.items.FERINE_OCREAE,
        xi.items.AOIDOS_COTHURNES,
        xi.items.SYLVAN_BOTTILLONS,
    },

    [xi.zone.ABYSSEA_VUNKERL] =
    {
        xi.items.ORICHALCUM_INGOT,
        xi.items.SPOOL_OF_PLATINUM_SILK_THREAD,
        xi.items.MOLYBDENUM_INGOT,
        xi.items.SQUARE_OF_KHROMATED_LEATHER,
        xi.items.CHUNK_OF_KHROMA_ORE,
        xi.items.CHUNK_OF_HYDRA_MEAT,
        xi.items.SQUARE_OF_GALATEIA,
        xi.items.WATER_BEAD,
        xi.items.LIGHT_BEAD,
        xi.items.WIND_BEAD,
        xi.items.DARK_BEAD,
        xi.items.FIRE_BEAD,
        xi.items.EARTH_BEAD,
        xi.items.SQUARE_OF_DAMASCENE_CLOTH,
        xi.items.PIECE_OF_ANGEL_SKIN,
        xi.items.SCROLL_OF_ADDLE,
        xi.items.SCROLL_OF_AERO_V,
        xi.items.SCROLL_OF_BOOST_MND,
        xi.items.SCROLL_OF_EARTH_CAROL_II,
        xi.items.SCROLL_OF_ENDARK,
        xi.items.SCROLL_OF_ENLIGHT,
        xi.items.SCROLL_OF_GAIN_MND,
        xi.items.SCROLL_OF_REFRESH_II,
        xi.items.SCROLL_OF_STONEJA,
        xi.items.SCROLL_OF_WATER_CAROL_II,
        xi.items.SCROLL_OF_EARTH_CAROL_II,
        xi.items.SCROLL_OF_WATERJA,
        xi.items.SCROLL_OF_YURIN_ICHI,
        xi.items.SCROLL_OF_MYOSHU_ICHI,
        xi.items.DENTED_SKULL,
        xi.items.CALLERS_PIGACHES,
        xi.items.CHARIS_TOE_SHOES,
        xi.items.CIRQUE_SCARPE,
        xi.items.IGA_KYAHAN,
        xi.items.LANCERS_SCHYNBALDS,
        xi.items.MAVI_BASMAK,
        xi.items.NAVARCHS_BOTTES,
        xi.items.SAVANTS_LOAFERS,
        xi.items.UNKAI_SUNE_ATE,
    },

    [xi.zone.ABYSSEA_ALTEPA    ] = { 0, 0, 0 },
    [xi.zone.ABYSSEA_ULEGUERAND] = { 0, 0, 0 },
    [xi.zone.ABYSSEA_GRAUBERG  ] = { 0, 0, 0 },
}

local itemTierDeductions =
{
    [xi.zone.ABYSSEA_KONSCHTAT ] = {  7,  7,  7, 0, 0 },
    [xi.zone.ABYSSEA_TAHRONGI  ] = { 14, 14, 14, 9, 0 },
    [xi.zone.ABYSSEA_LA_THEINE ] = { 13, 13, 13, 9, 0 },
    [xi.zone.ABYSSEA_ATTOHWA   ] = { 14, 14, 14, 9, 0 },
    [xi.zone.ABYSSEA_MISAREAUX ] = { 14, 14, 14, 5, 0 },
    [xi.zone.ABYSSEA_VUNKERL   ] = { 14, 14, 14, 6, 0 },
    [xi.zone.ABYSSEA_ALTEPA    ] = {  0,  0,  0, 0, 0 },
    [xi.zone.ABYSSEA_ULEGUERAND] = {  0,  0,  0, 0, 0 },
    [xi.zone.ABYSSEA_GRAUBERG  ] = {  0,  0,  0, 0, 0 },
}

local function GetChestItemTable(npc)
    local maxItem = npc:getLocalVar("NB_ITEM")
    local itemTable = {}

    for i = 1, maxItem do
        itemTable[i] = npc:getLocalVar("ITEM" .. i)
    end

    return itemTable
end

local function GetRandItem(zoneId, tier)
    local drops = { unpack(commonDrops), unpack(itemDrops[zoneId]) }
    local rand = math.random(1, #drops - itemTierDeductions[zoneId][tier])

    return drops[rand]
end

local function GetLootTable(player, npc)
    local maxItem = npc:getLocalVar("NB_ITEM")
    local loot = {}

    for i = 1, maxItem do
        table.insert(loot, npc:getLocalVar("ITEM" ..i))
    end

    return loot
end

local function GiveItem(player, npc, itemnum)
    local zoneId  = player:getZoneID()
    local ID      = zones[zoneId]
    local chestid = npc:getLocalVar("CHESTID")
    local chest   = GetNPCByID(chestid)
    local itemList = GetChestItemTable(npc)

    if itemList[itemnum] == 0 then
        player:messageSpecial(ID.text.ITEM_DISAPPEARED)
        return
    else
        if player:getFreeSlotsCount() == 0 then -- NOTE: check a var or somthing for the item
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemList[itemnum])
            return
        else
            player:addItem(itemList[itemnum], 1, 0, 0, 0, 0)
            xi.pyxis.messageChest(player, ID.text.OBTAINS_ITEM, itemList[itemnum], 0, 0, 0, npc)
            chest:setLocalVar("ITEM" .. itemnum, 0)
            itemList[itemnum] = 0
        end
    end

    if xi.pyxis.isChestEmpty(itemList) then
        xi.pyxis.removeChest(player, npc, 0, 3)
    end
end

xi.pyxis.item.setItems = function(npc, tier)
    local itemcount = npc:getLocalVar("NB_ITEM")

    for i = 1, itemcount do
        local item = GetRandItem(npc:getZoneID(), tier)
        npc:setLocalVar("ITEM" .. i, item)
    end
end

xi.pyxis.item.updateEvent = function(player, npc)
    player:updateEvent(unpack(GetChestItemTable(npc)))
end

xi.pyxis.item.giveItem = function(player, npc, option)
    local ID = zones[npc:getZoneID()]
    local loottable = GetLootTable(player, npc)
    local itemSelected = bit.rshift(option, 16)
    if itemSelected > 0 and itemSelected <= 8 then
        GiveItem(player, npc, itemSelected)

    -- Add spoils to treasure
    elseif itemSelected == 9 then
        for _, v in ipairs(loottable) do
            player:addTreasure(v)
        end

        xi.pyxis.messageChest(player, ID.text.ADD_SPOILS_TO_TREASURE, 0, 0, 0, 0, npc)
        xi.pyxis.removeChest(player, npc, 0, 1)
        ---- NOTE: NEED A CHECK HERE TO MAKE SURE ITS UPDATED AND CANT REMOVE THE SAME ITEM AGAIN
    end
end
