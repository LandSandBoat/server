-----------------------------------
-- Abyssea Sturdy Pyxis - Item
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.item = {}

-----------------------------------
-- drop id's for items
-- use zone id as the key
-----------------------------------
-- Containing Ore actually
local commonDrops =
{
    xi.item.CHUNK_OF_FIRE_ORE,
    xi.item.CHUNK_OF_ICE_ORE,
    xi.item.CHUNK_OF_WIND_ORE,
    xi.item.CHUNK_OF_EARTH_ORE,
    xi.item.CHUNK_OF_LIGHTNING_ORE,
    xi.item.CHUNK_OF_WATER_ORE,
    xi.item.CHUNK_OF_LIGHT_ORE,
    xi.item.CHUNK_OF_DARK_ORE,
}

local itemDrops =
{
    [xi.zone.ABYSSEA_KONSCHTAT ] =
    {
        xi.item.HANDFUL_OF_CLOT_PLASMA,
        xi.item.SCROLL_OF_WATER_V,
        xi.item.SLICE_OF_DRAGON_MEAT,
        xi.item.SLICE_OF_BUFFALO_MEAT,
        xi.item.SQUARE_OF_SHAGREEN,
        xi.item.FIENDISH_SKIN,
        xi.item.LARIMAR,
        xi.item.CHUNK_OF_DARK_ORE,
        xi.item.HELIODOR,
        xi.item.IOLITE,
        xi.item.CHUNK_OF_KHROMA_ORE,
        xi.item.CHUNK_OF_LIGHTNING_ORE,
        xi.item.CHUNK_OF_PHRYGIAN_ORE,
        xi.item.CHUNK_OF_WOOTZ_ORE,
        xi.item.SQUARE_OF_DAMASCENE_CLOTH,
        xi.item.SLICE_OF_COEURL_MEAT,
        xi.item.SCROLL_OF_KNIGHTS_MINNE_V,
    },

    [xi.zone.ABYSSEA_TAHRONGI] =
    {
        xi.item.FLOCON_DE_MER,
        xi.item.WATER_SPIDERS_WEB,
        xi.item.CORAL_FRAGMENT,
        xi.item.SCROLL_OF_BARAMNESRA,
        xi.item.SCROLL_OF_STONE_V,
        xi.item.SCROLL_OF_WATER_V,
        xi.item.SCROLL_OF_SHELL_V,
        xi.item.SCROLL_OF_CURE_VI,
        xi.item.SCROLL_OF_FOE_REQUIEM_VII,
        xi.item.SCROLL_OF_KNIGHTS_MINNE_V,
        xi.item.SCROLL_OF_AISHA_ICHI,
        xi.item.CHUNK_OF_DARKSTEEL_ORE,
        xi.item.HANDFUL_OF_CLOT_PLASMA,
        xi.item.DEATHSTONE,
        xi.item.SPINEL,
        xi.item.CHUNK_OF_DURIUM_ORE,
        xi.item.SAPPHIRE,
        xi.item.CHUNK_OF_LIGHTNING_ORE,
        xi.item.EMERALD,
        xi.item.SLICE_OF_DRAGON_MEAT,
        xi.item.TARNISHED_PINCER,
        xi.item.CHUNK_OF_PHRYGIAN_ORE,
        xi.item.RUBY,
        xi.item.PIECE_OF_ANGEL_SKIN,
        xi.item.PHILOSOPHERS_STONE,
        xi.item.CLUMP_OF_ALKALINE_HUMUS,
        xi.item.CLUMP_OF_ACIDIC_HUMUS,
        xi.item.EFT_EGG,
        xi.item.QUIVERING_EFT_EGG,
        xi.item.SHOCKING_WHISKER,
        xi.item.SMOOTH_WHISKER,
        xi.item.RESILIENT_MANE,
        xi.item.CHUNK_OF_COCKATRICE_TAILMEAT,
        xi.item.EXORCISED_SKULL,
    },

    [xi.zone.ABYSSEA_LA_THEINE] =
    {
        xi.item.CHUNK_OF_WATER_ORE,
        xi.item.POT_OF_URUSHI,
        xi.item.WINTER_PUK_EGG,
        xi.item.GIANT_AGARICUS_MUSHROOM,
        xi.item.FILTHY_GNOLE_CLAW,
        xi.item.OVERSIZED_SOCK,
        xi.item.STAR_SAPPHIRE,
        xi.item.CHUNK_OF_PHRYGIAN_ORE,
        xi.item.CHUNK_OF_ORICHALCUM_ORE,
        xi.item.LACQUER_TREE_LOG,
        xi.item.CHUNK_OF_KHROMA_ORE,
        xi.item.SQUARE_OF_GALATEIA,
        xi.item.EBONY_LOG,
        xi.item.CHUNK_OF_EARTH_ORE,
        xi.item.CHUNK_OF_DURIUM_ORE,
        xi.item.SLICE_OF_DRAGON_MEAT,
        xi.item.CLARITE,
        xi.item.SLICE_OF_COEURL_MEAT,
        xi.item.SLICE_OF_BUFFALO_MEAT,
        xi.item.SCROLL_OF_WATER_V,
        xi.item.SCROLL_OF_STONE_V,
        xi.item.SCROLL_OF_PROTECT_V,
        xi.item.SCROLL_OF_KNIGHTS_MINNE_V,
        xi.item.SCROLL_OF_FOE_REQUIEM_VII,
        xi.item.SCROLL_OF_ASPIR_II,
        xi.item.SCROLL_OF_ARMYS_PAEON_VI,
        xi.item.DRAGON_HEART,
        xi.item.SCROLL_OF_AISHA_ICHI,
        xi.item.GARGANTUAN_BLACK_TIGER_FANG,
        xi.item.BUG_EATEN_HAT,
    },

    [xi.zone.ABYSSEA_ATTOHWA] =
    {
        xi.item.AHTAPOT,
        xi.item.CHICKEN_BONE,
        xi.item.CORAL_FRAGMENT,
        xi.item.DARKSTEEL_INGOT,
        xi.item.SLICE_OF_DRAGON_MEAT,
        xi.item.FULMENITE,
        xi.item.GOLD_INGOT,
        xi.item.CHUNK_OF_HYDRA_MEAT,
        xi.item.CHUNK_OF_WOOTZ_ORE,
        xi.item.EARTH_BEAD,
        xi.item.LIGHTNING_BEAD,
        xi.item.DARK_BEAD,
        xi.item.SQUARE_OF_KHROMATED_LEATHER,
        xi.item.BLOODWOOD_LOG,
        xi.item.CLARITE,
        xi.item.BEECH_LOG,
        xi.item.CHUNK_OF_PHRYGIAN_ORE,
        xi.item.IOLITE,
        xi.item.SCROLL_OF_ADDLE,
        xi.item.SCROLL_OF_BOOST_MND,
        xi.item.SCROLL_OF_BOOST_VIT,
        xi.item.SCROLL_OF_EARTH_CAROL_II,
        xi.item.SCROLL_OF_GAIN_MND,
        xi.item.SCROLL_OF_GAIN_VIT,
        xi.item.SCROLL_OF_MYOSHU_ICHI,
        xi.item.SCROLL_OF_STONEJA,
        xi.item.SCROLL_OF_WATER_CAROL_II,
        xi.item.ANIMUS_AUGEO_SCHEMA,
        xi.item.SCROLL_OF_MAGES_BALLAD_III,
        xi.item.SCROLL_OF_REFRESH_II,
        xi.item.SCROLL_OF_WATERJA,
        xi.item.HANDFUL_OF_BONE_CHIPS,
        xi.item.ERUCA_EGG,
        xi.item.EXTENDED_EYESTALK,
        xi.item.MANGLED_COCKATRICE_SKIN,
        xi.item.VIAL_OF_UNDYING_OOZE,
        xi.item.WITHERED_COCOON,
        xi.item.RAVAGERS_CALLIGAE,
        xi.item.TANTRA_GAITERS,
        xi.item.ORISON_DUCKBILLS,
        xi.item.GOETIA_SABOTS,
        xi.item.ESTOQUEURS_HOUSEAUX,
        xi.item.RAIDERS_POULAINES,
    },

    [xi.zone.ABYSSEA_MISAREAUX] =
    {
        xi.item.BEECH_LOG,
        xi.item.WILD_ONION,
        xi.item.OXBLOOD_ORB,
        xi.item.ORICHALCUM_INGOT,
        xi.item.MOLYBDENUM_INGOT,
        xi.item.SQUARE_OF_MARID_LEATHER,
        xi.item.PIECE_OF_LACQUER_TREE_LUMBER,
        xi.item.CHUNK_OF_KHROMA_ORE,
        xi.item.ICE_BEAD,
        xi.item.FLOCON_DE_MER,
        xi.item.FIRE_BEAD,
        xi.item.PIECE_OF_EBONY_LUMBER,
        xi.item.DIVINE_LOG,
        xi.item.DEMON_HORN,
        xi.item.SQUARE_OF_DAMASCENE_CLOTH,
        xi.item.CORAL_FRAGMENT,
        xi.item.SLICE_OF_COEURL_MEAT,
        xi.item.BLACK_PEARL,
        xi.item.SCROLL_OF_ADDLE,
        xi.item.SCROLL_OF_AERO_V,
        xi.item.PLATE_OF_INDI_SLOW,
        xi.item.SCROLL_OF_BREAK,
        xi.item.SCROLL_OF_EARTH_CAROL_II,
        xi.item.SCROLL_OF_ENDARK,
        xi.item.SCROLL_OF_ENLIGHT,
        xi.item.SCROLL_OF_GAIN_MND,
        xi.item.SCROLL_OF_GAIN_VIT,
        xi.item.SCROLL_OF_MAGES_BALLAD_III,
        xi.item.SCROLL_OF_SENTINELS_SCHERZO,
        xi.item.SCROLL_OF_STONEJA,
        xi.item.SCROLL_OF_WATER_CAROL_II,
        xi.item.SCROLL_OF_WATERJA,
        xi.item.AVIAN_REMEX,
        xi.item.BLACK_RABBIT_TAIL,
        xi.item.HARDENED_RAPTOR_SKIN,
        xi.item.MOCKING_BEAK,
        xi.item.SPOTTED_FLYFROND,
        xi.item.CREED_SABATONS,
        xi.item.BALE_SOLLERETS,
        xi.item.FERINE_OCREAE,
        xi.item.AOIDOS_COTHURNES,
        xi.item.SYLVAN_BOTTILLONS,
    },

    [xi.zone.ABYSSEA_VUNKERL] =
    {
        xi.item.ORICHALCUM_INGOT,
        xi.item.SPOOL_OF_PLATINUM_SILK_THREAD,
        xi.item.MOLYBDENUM_INGOT,
        xi.item.SQUARE_OF_KHROMATED_LEATHER,
        xi.item.CHUNK_OF_KHROMA_ORE,
        xi.item.CHUNK_OF_HYDRA_MEAT,
        xi.item.SQUARE_OF_GALATEIA,
        xi.item.WATER_BEAD,
        xi.item.LIGHT_BEAD,
        xi.item.WIND_BEAD,
        xi.item.DARK_BEAD,
        xi.item.FIRE_BEAD,
        xi.item.EARTH_BEAD,
        xi.item.SQUARE_OF_DAMASCENE_CLOTH,
        xi.item.PIECE_OF_ANGEL_SKIN,
        xi.item.SCROLL_OF_ADDLE,
        xi.item.SCROLL_OF_AERO_V,
        xi.item.SCROLL_OF_BOOST_MND,
        xi.item.SCROLL_OF_EARTH_CAROL_II,
        xi.item.SCROLL_OF_ENDARK,
        xi.item.SCROLL_OF_ENLIGHT,
        xi.item.SCROLL_OF_GAIN_MND,
        xi.item.SCROLL_OF_REFRESH_II,
        xi.item.SCROLL_OF_STONEJA,
        xi.item.SCROLL_OF_WATER_CAROL_II,
        xi.item.SCROLL_OF_EARTH_CAROL_II,
        xi.item.SCROLL_OF_WATERJA,
        xi.item.SCROLL_OF_YURIN_ICHI,
        xi.item.SCROLL_OF_MYOSHU_ICHI,
        xi.item.DENTED_SKULL,
        xi.item.CALLERS_PIGACHES,
        xi.item.CHARIS_TOE_SHOES,
        xi.item.CIRQUE_SCARPE,
        xi.item.IGA_KYAHAN,
        xi.item.LANCERS_SCHYNBALDS,
        xi.item.MAVI_BASMAK,
        xi.item.NAVARCHS_BOTTES,
        xi.item.SAVANTS_LOAFERS,
        xi.item.UNKAI_SUNE_ATE,
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
    local maxItem = npc:getLocalVar('NB_ITEM')
    local itemTable = {}

    for i = 1, maxItem do
        itemTable[i] = npc:getLocalVar('ITEM' .. i)
    end

    return itemTable
end

local function GetRandItem(zoneId, tier)
    local drops = { unpack(commonDrops), unpack(itemDrops[zoneId]) }
    local rand = math.random(1, #drops - itemTierDeductions[zoneId][tier])

    return drops[rand]
end

local function GetLootTable(player, npc)
    local maxItem = npc:getLocalVar('NB_ITEM')
    local loot = {}

    for i = 1, maxItem do
        table.insert(loot, npc:getLocalVar('ITEM' ..i))
    end

    return loot
end

local function GiveItem(player, npc, itemnum)
    local zoneId  = player:getZoneID()
    local ID      = zones[zoneId]
    local chestid = npc:getLocalVar('CHESTID')
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
            chest:setLocalVar('ITEM' .. itemnum, 0)
            itemList[itemnum] = 0
        end
    end

    if xi.pyxis.isChestEmpty(itemList) then
        xi.pyxis.removeChest(player, npc, 0, 3)
    end
end

xi.pyxis.item.setItems = function(npc, tier)
    local itemcount = npc:getLocalVar('NB_ITEM')

    for i = 1, itemcount do
        local item = GetRandItem(npc:getZoneID(), tier)
        npc:setLocalVar('ITEM' .. i, item)
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
