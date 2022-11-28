-----------------------------------
-- Dealer Moogles & Kupon Global
-- https://www.bg-wiki.com/ffxi/Category:Mog_Bonanza
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.dealerMoogle = xi.dealerMoogle or {}

local csidLookup =
{
    [xi.zone.CHOCOBO_CIRCUIT] = { 416, 417 },
    [xi.zone.PORT_SAN_DORIA]  = { 790, 791 },
    [xi.zone.PORT_BASTOK]     = { 398, 399 },
    [xi.zone.PORT_WINDURST]   = { 856, 857 },
}

-- TODO: Where is Kupon A-E +2
-- TODO: Where is Kupon AW-GeIV
-- TODO: Where is Kupon AW-UWIII

-- WARNING!
-- These items cannot be customised!
-- Everything is dictacted by the client!
local kuponLookup =
{
    -- [coupon item id] = { related key item id, index of items in itemList (table below) }
    [xi.items.MOG_KUPON_A_DBCD] = { xi.ki.MOG_KUPON_A_DBCD, 1 },
    [xi.items.MOG_KUPON_A_DXAR] = { xi.ki.MOG_KUPON_A_DXAR, 2 },
    [xi.items.MOG_KUPON_AW_ABS] = { xi.ki.MOG_KUPON_AW_ABS, 3 },
    [xi.items.MOG_KUPON_AW_PAN] = { xi.ki.MOG_KUPON_AW_PAN, 4 },
    [xi.items.MOG_KUPON_A_LUM ] = { xi.ki.MOG_KUPON_A_LUM,  5 },

    --[xi.items.MOG_KUPON_W_PULSE] = { xi.keyItem.MOG_KUPON_W_PULSE, 35 },
}

-- WARNING!
-- These items cannot be customised, and must be in the order
-- they appear in the in-game menus!
-- Everything is dictacted by the client!
local itemList =
{
    -- Kupon A-DBcd: Dynamis - Beaucedine (MOG_KUPON_A_DBCD = 2745)
    [1] =
    {
        xi.items.WARRIORS_CUISSES,
        xi.items.MELEE_CYCLAS,
        xi.items.CLERICS_BRIAULT,
        xi.items.SORCERERS_COAT,
        xi.items.DUELISTS_TABARD,
        xi.items.ASSASSINS_CULOTTES,
        xi.items.VALOR_BREECHES,
        xi.items.ABYSS_CUIRASS,
        xi.items.MONSTER_GAITERS,
        xi.items.BARDS_JUSTAUCORPS,
        xi.items.SCOUTS_SOCKS,
        xi.items.SAOTOME_DOMARU,
        xi.items.KOGA_CHAINMAIL,
        xi.items.WYRM_MAIL,
        xi.items.SUMMONERS_DOUBLET,
        xi.items.MIRAGE_JUBBAH,
        xi.items.COMMODORE_FRAC,
        xi.items.PANTIN_TOBE,
        xi.items.ETOILE_TIGHTS,
        xi.items.ARGUTE_GOWN,
    },

    -- Kupon A-DXar: Dynamis - Xarcabard (MOG_KUPON_A_DXAR = 2746)
    [2] =
    {
        xi.items.WARRIORS_LORICA,
        xi.items.MELEE_CROWN,
        xi.items.CLERICS_MITTS,
        xi.items.SORCERERS_PETASOS,
        xi.items.DUELISTS_CHAPEAU,
        xi.items.ASSASSINS_ARMLETS,
        xi.items.VALOR_SURCOAT,
        xi.items.ABYSS_BURGEONET,
        xi.items.MONSTER_GLOVES,
        xi.items.BARDS_CANNIONS,
        xi.items.SCOUTS_JERKIN,
        xi.items.SAOTOME_KABUTO,
        xi.items.KOGA_TEKKO,
        xi.items.WYRM_ARMET,
        xi.items.SUMMONERS_HORN,
        xi.items.MIRAGE_KEFFIYEH,
        xi.items.COMMODORE_TRICORNE,
        xi.items.PANTIN_TAJ,
        xi.items.ETOILE_CASAQUE,
        xi.items.ARGUTE_MORTARBOARD,
    },

    -- Kupon AW-Abs: Absolute Virtue (MOG_KUPON_AW_ABS = 2802)
    [3] =
    {
        xi.items.NINURTAS_SASH,
        xi.items.MARSS_RING,
        xi.items.BELLONAS_RING,
        xi.items.MINERVAS_RING,
        xi.items.FUTSUNO_MITAMA,
        xi.items.AUREOLE,
        xi.items.RAPHAELS_ROD,
    },

    -- Kupon AW-Pan: Pandemonium Warden (MOG_KUPON_AW_PAN = 2801)
    [4] =
    {
        xi.items.HACHIRYU_HARAMAKI,
        xi.items.NANATSUSAYA,
        xi.items.DORJE,
        xi.items.SHENLONGS_BAGHNAKHS,
    },

    -- Kupon A-Lum: Sea NM System (MOG_KUPON_A_LUM = 2736)
    [5] =
    {
        xi.items.JUSTICE_TORQUE,
        xi.items.HOPE_TORQUE,
        xi.items.PRUDENCE_TORQUE,
        xi.items.FORTITUDE_TORQUE,
        xi.items.FAITH_TORQUE,
        xi.items.TEMPERANCE_TORQUE,
        xi.items.LOVE_TORQUE,
        xi.items.MERCIFUL_CAPE,
        xi.items.ALTRUISTIC_CAPE,
        xi.items.ASTUTE_CAPE,
    },

    --[[
    -- Kupon W-E85: Lv85 Empyrean Weapons (deprecated)
    [6] =
    {

    },

    -- Kupon A-RJob: Lv70 Relic Armor Accessories (deprecated)
    [7] =
    {

    },

    -- Kupon W-R90: Lv90 Relic Weapons and upgrade materials (deprecated)
    [8] =
    {

    },

    -- Kupon W-M90: Lv90 Mythic Weapons (deprecated)
    [9] =
    {

    },

    -- Kupon W-E90: Lv90 Empyrean Weapons (deprecated)
    [11] =
    {

    },

    -- Kupon I-Seal: 8 to 10 of any Empyrean Armor upgrade seals
    [12] =
    {

    },

    -- Kupon A-DeII: Delve boss armor pieces
    [13] =
    {

    },

    -- Kupon A-De: Delve boss armor pieces (deprecated)
    [14] =
    {

    },

    -- Kupon A-Sal: Salvage II (deprecated)
    [15] =
    {

    },

    -- Kupon A-Nyz: Nyzul Isle Uncharted Area Survey (deprecated)
    [16] =
    {

    },

    -- Kupon I-S5: Skirmish Rank V Simulacrum Segments
    [17] =
    {

    },

    -- Kupon I-S2: Skirmish Rank II Simulacrum Segments
    [18] =
    {

    },

    -- Kupon I-Orche: Orchestrion music
    [19] =
    {

    },

    -- Kupon I-AF109: 12 of each REM's Tale Chapters 1-10
    [20] =
    {

    },

    -- Kupon W-EWS: Walk of Echoes Weapons (deprecated)
    [21] =
    {

    },

    -- Kupon AW-WK: Weapon or Armor from Wildskeeper Reives
    [22] =
    {

    },

    -- Kupon I-S3: Skirmish Rank III Simulacrum Segments
    [23] =
    {

    },

    -- Kupon A-PK109: iLevel 109 Peacekeeper Coalition Armor
    [24] =
    {

    },

    -- Kupon I-S1: Skirmish Rank I Simulacrum Segments
    [25] =
    {

    },

    -- Kupon I-Skill: Skill books (deprecated)
    [26] =
    {

    },

    -- Kupon I-RME: RME Upgrade Materials x300
    [27] =
    {

    },

    -- 28: blank menu

    -- Kupon W-Job: JSE Oboro Weapons
    [29] =
    {

    },

    -- Kupon I-Mat: One type of special material (deprecated)
    [30] =
    {

    },

    -- Kupon W-DeIII: Delve boss weapons
    [31] =
    {

    },

    -- Kupon AW-Mis: Equipment or a weapon from High-Tier Mission Battlefields
    [32] =
    {

    },

    -- Kupon AW-Vgr: Equipment from Vagary Notorious Monsters Perfiden and Plouton
    [33] =
    {

    },

    -- Kupon AW-VgrII: Equipment from Vagary NMs Palloritus, Putraxia and Rancibus
    [34] =
    {

    },

    -- Mog Kupon W-Pulse: Pulse weapons
    [35] =
    {
        xi.items.GIRRU,
    },

    -- Kupon AW-GFII: Geas Fete (Content Level 119+) (deprecated)
    [37] =
    {

    },

    -- Kupon I-Stone: Augment stones (deprecated)
    [38] =
    {

    },

    -- Kupon AW-GF: Geas Fete (Content Level 119) (deprecated)
    [39] =
    {

    },

    -- Kupon AW-UWII: Level 119-128 Unity Wanted Battles
    [40] =
    {

    },

    -- Kupon AW-UW: Level 119 Unity Wanted Battles
    [41] =
    {

    },

    -- Kupon A-Ab: iLevel 119 +1 Abjuration Armor pieces
    [43] =
    {

    },

    -- Kupon AW-Cos: Various Costumes
    [44] =
    {

    },

    -- Kupon AW-Kupo: All four Kupo items
    [45] =
    {
        {
            -- TODO: Move to items.lua
            21074, -- Kupo Rod
            25645, -- Kupo Masque
            25726, -- Kupo Suit
            26406, -- Kupo Shield
        },
    },

    -- Kupon W-EMI: iLevel 117 Sparks of Eminence Weapons
    [46] =
    {

    },

    -- Kupon A-EMI: iLevel 117 Records of Eminence armor
    [47] =
    {

    },

    -- Kupon W-SRW: Rala Waterways Skirmish Weapons +2
    [48] =
    {

    },

    -- Kupon W-SCC: Cirdas Caverns Skirmish Weapons +2
    [49] =
    {

    },

    -- Kupon A-SYW: Yorcia Weald Skirmish Armor +1
    [50] =
    {

    },

    -- Kupon W-ASRW: Rala Waterways Alluvion Skirmish Weapons
    [51] =
    {

    },

    -- Kupon W-ASCC: Cirdas Caverns Alluvion Skirmish Weapons
    [52] =
    {

    },

    -- Kupon A-ASYW: Yorcia Weald Alluvion Skirmish Armor
    [53] =
    {

    },

    -- Kupon W-R119: iLevel 119 III Relic Weapons (deprecated)
    [54] =
    {

    },

    -- Kupon W-M119: iLevel 119 III Mythic Weapons and Ergon Weapons (deprecated)
    [55] =
    {

    },

    -- Kupon W-E119: iLevel 119 III Empyrean Weapons (deprecated)
    [56] =
    {

    },

    -- Kupon W-A119: Aeonic Weapons (deprecated)
    [57] =
    {

    },

    -- Kupon A-OmII: Body pieces from Omen bosses
    [59] =
    {

    },

    -- Kupon I-AF119: Scale needed for the Reforged Artifact Armor +3 process
    [60] =
    {

    },

    -- Kupon AW-Om: Equipment pieces from Omen mid-bosses
    [61] =
    {

    },

    -- Kupon W-RMEA: iLevel 119 III Relic, Mythic, Empyrean or Aeonic Weapon
    [62] =
    {

    },
    ]]
}

local countKeyItems = function(player)
    local count = 0
    for _, v in pairs (kuponLookup) do
        local ki = v[1]
        if player:hasKeyItem(ki) then
            count = count + 1
        end
    end

    return count
end

local listToKeyItem = function(listID)
    for k, v in pairs (kuponLookup) do
        if v[2] == listID then
            return v[1]
        end
    end

    return nil
end

local buildMask1 = function(player)
    return 0
end

local buildMask2 = function(player)
    local mask = 0
    for k, v in pairs (kuponLookup) do
        if k > 32 then
            return mask
        end

        if player:hasKeyItem(v[1]) then
            mask = mask + bit.lshift(1, v[2])
        end
    end

    return mask
end

xi.dealerMoogle.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
    if not kuponLookup[itemID] then
        return
    end

    local zoneID = player:getZoneID()
    local csid   = csidLookup[zoneID][2]
    local kiID   = kuponLookup[itemID][1]
    local listID = kuponLookup[itemID][2]

    -- Whatever happens, the item is gone now. It will be replaced with a key item version!
    -- No need to tell the player, the CS handles all of the messaging.
    if player:hasItem(itemID) then
        trade:confirmItem(itemID, 1)
        player:confirmTrade()
        player:addKeyItem(kiID)

        player:startEvent(csid, itemID, kiID, listID)
    end
end

xi.dealerMoogle.onTrigger = function(player, npc)
    local zoneID = player:getZoneID()

    -- Found a KI (or more)
    local cs     = csidLookup[zoneID][1]
    local numKIs = countKeyItems(player)
    local mask1  = 0
    local mask2  = 0

    if numKIs > 0 then
        numKIs = 2 -- NOTE: This forces the multiple-choice menu
        cs     = csidLookup[zoneID][2]
        mask1  = buildMask1(player)
        mask2  = buildMask2(player)
    end

    -- mask1:
    -- 1: Set menu to blank

    -- mask2:
    -- 1: Set menu to blank
    -- 2: Kupon A-DBcd
    -- 4: Kupon A-DXar
    -- 8: Kupon AW-Abs
    -- ...

    -- Capture of multiple stored KIs: CS2: 0, 0, 51, 4, 0, 0, 1843200, 0

    player:startEvent(cs, 0, 0, 0, numKIs, 0, 0, mask1, mask2)
end

xi.dealerMoogle.onEventUpdate = function(player, csid, option)
    -- print("update", csid, option)
end

xi.dealerMoogle.onEventFinish = function(player, csid, option)
    -- print("finish", csid, option)
    if option == 0 then
        return
    end

    local zoneID = player:getZoneID()
    local itemCsid = csidLookup[zoneID][2]

    if csid == itemCsid then
        local list = bit.band(option, 0xFF)
        local idx = bit.rshift(option, 8)

        -- DEBUG:
        -- print(string.format("list: %u, idx: %u", list, idx))

        if list > 0 and idx == 0 then
            player:addKeyItem(listToKeyItem(list))
        elseif list > 0 and idx > 0 then
            local item = itemList[list][idx]
            if npcUtil.giveItem(player, item) then
                player:delKeyItem(listToKeyItem(list))
            else
                -- TODO: Messaging that getting the item has failed
            end
        end
    end
end
