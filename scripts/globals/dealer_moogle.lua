-----------------------------------
-- Dealer Moogles & Kupon Global
-- https://www.bg-wiki.com/ffxi/Category:Mog_Bonanza
-----------------------------------
require("scripts/globals/items")
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

-- WARNING!!! These items cannot be customised!
-- Everything is dictacted by the client!
local kuponLookup =
{
    -- [coupon item id] = { related key item id, index of items in itemList (table below) }
    [xi.items.MOG_KUPON_A_DBCD   ] = { xi.ki.MOG_KUPON_A_DBCD,    1 },
    [xi.items.MOG_KUPON_A_DXAR   ] = { xi.ki.MOG_KUPON_A_DXAR,    2 },
    [xi.items.MOG_KUPON_AW_ABS   ] = { xi.ki.MOG_KUPON_AW_ABS,    3 },
    [xi.items.MOG_KUPON_AW_PAN   ] = { xi.ki.MOG_KUPON_AW_PAN,    4 },
    [xi.items.MOG_KUPON_A_LUM    ] = { xi.ki.MOG_KUPON_A_LUM,     5 },
    [xi.items.MOG_KUPON_W_E85    ] = { xi.ki.MOG_KUPON_W_E85,     6 },
    [xi.items.MOG_KUPON_A_RJOB   ] = { xi.ki.MOG_KUPON_A_RJOB,    7 },
    [xi.items.MOG_KUPON_W_R90    ] = { xi.ki.MOG_KUPON_W_R90,     8 },
    [xi.items.MOG_KUPON_W_M90    ] = { xi.ki.MOG_KUPON_W_M90,     9 },
    [xi.items.MOG_KUPON_W_E90    ] = { xi.ki.MOG_KUPON_W_E90,    10 },
    [xi.items.MOG_KUPON_A_E2     ] = { xi.ki.MOG_KUPON_A_E2,     11 },
    [xi.items.MOG_KUPON_I_SEAL   ] = { xi.ki.MOG_KUPON_I_SEAL,   12 },
    [xi.items.MOG_KUPON_A_DEII   ] = { xi.ki.MOG_KUPON_A_DEII,   13 },
    [xi.items.MOG_KUPON_A_DE     ] = { xi.ki.MOG_KUPON_A_DE,     14 },
    [xi.items.MOG_KUPON_A_SAL    ] = { xi.ki.MOG_KUPON_A_SAL,    15 },
    [xi.items.MOG_KUPON_A_NYZ    ] = { xi.ki.MOG_KUPON_A_NYZ,    16 },
    [xi.items.MOG_KUPON_I_S5     ] = { xi.ki.MOG_KUPON_I_S5,     17 },
    [xi.items.MOG_KUPON_I_S2     ] = { xi.ki.MOG_KUPON_I_S2,     18 },
    [xi.items.MOG_KUPON_I_ORCHE  ] = { xi.ki.MOG_KUPON_I_ORCHE,  19 },
    [xi.items.MOG_KUPON_I_AF109  ] = { xi.ki.MOG_KUPON_I_AF109,  20 },
    [xi.items.MOG_KUPON_W_EWS    ] = { xi.ki.MOG_KUPON_W_EWS,    21 },
    [xi.items.MOG_KUPON_AW_WK    ] = { xi.ki.MOG_KUPON_AW_WK,    22 },
    [xi.items.MOG_KUPON_I_S3     ] = { xi.ki.MOG_KUPON_I_S3,     23 },
    [xi.items.MOG_KUPON_A_PK109  ] = { xi.ki.MOG_KUPON_A_PK109,  24 },
    [xi.items.MOG_KUPON_I_S1     ] = { xi.ki.MOG_KUPON_I_S1,     25 },
    [xi.items.MOG_KUPON_I_SKILL  ] = { xi.ki.MOG_KUPON_I_SKILL,  26 },
    [xi.items.MOG_KUPON_I_RME    ] = { xi.ki.MOG_KUPON_I_RME,    27 },
--  [xi.items.NOT_IN_USE         ] = { xi.ki.MOG_KUPON_I,        28 },
    [xi.items.MOG_KUPON_W_JOB    ] = { xi.ki.MOG_KUPON_W_JOB,    29 },
    [xi.items.MOG_KUPON_I_MAT    ] = { xi.ki.MOG_KUPON_I_MAT,    30 },
    [xi.items.MOG_KUPON_W_DEIII  ] = { xi.ki.MOG_KUPON_W_DEIII,  31 },
    [xi.items.MOG_KUPON_AW_MIS   ] = { xi.ki.MOG_KUPON_AW_MIS,   32 },
    [xi.items.MOG_KUPON_AW_VGR   ] = { xi.ki.MOG_KUPON_AW_VGR,   33 },
    [xi.items.MOG_KUPON_AW_VGRII ] = { xi.ki.MOG_KUPON_AW_VGRII, 34 },
    [xi.items.MOG_KUPON_W_PULSE  ] = { xi.ki.MOG_KUPON_W_PULSE,  35 },
    [xi.items.MOG_KUPON_I_STONE  ] = { xi.ki.MOG_KUPON_I_STONE,  36 },
    [xi.items.MOG_KUPON_AW_GFIII ] = { xi.ki.MOG_KUPON_AW_GFIII, 37 },
    [xi.items.MOG_KUPON_AW_GFII  ] = { xi.ki.MOG_KUPON_AW_GFII,  38 },
    [xi.items.MOG_KUPON_AW_GF    ] = { xi.ki.MOG_KUPON_AW_GF,    39 },
    [xi.items.MOG_KUPON_AW_UWIII ] = { xi.ki.MOG_KUPON_AW_UWIII, 40 },
    [xi.items.MOG_KUPON_AW_UWII  ] = { xi.ki.MOG_KUPON_AW_UWII,  41 },
    [xi.items.MOG_KUPON_AW_UW    ] = { xi.ki.MOG_KUPON_AW_UW,    42 },
    [xi.items.MOG_KUPON_A_AB     ] = { xi.ki.MOG_KUPON_A_AB,     43 },
    [xi.items.MOG_KUPON_AW_COS   ] = { xi.ki.MOG_KUPON_AW_COS,   44 },
    [xi.items.MOG_KUPON_AW_KUPO  ] = { xi.ki.MOG_KUPON_AW_KUPO,  45 },
    [xi.items.MOG_KUPON_W_EMI    ] = { xi.ki.MOG_KUPON_W_EMI,    46 },
    [xi.items.MOG_KUPON_A_EMI    ] = { xi.ki.MOG_KUPON_A_EMI,    47 },
    [xi.items.MOG_KUPON_W_SRW    ] = { xi.ki.MOG_KUPON_W_SRW,    48 },
    [xi.items.MOG_KUPON_W_SCC    ] = { xi.ki.MOG_KUPON_W_SCC,    49 },
    [xi.items.MOG_KUPON_A_SYW    ] = { xi.ki.MOG_KUPON_A_SYW,    50 },
    [xi.items.MOG_KUPON_W_ASRW   ] = { xi.ki.MOG_KUPON_W_ASRW,   51 },
    [xi.items.MOG_KUPON_W_ASCC   ] = { xi.ki.MOG_KUPON_W_ASCC,   52 },
    [xi.items.MOG_KUPON_A_ASYW   ] = { xi.ki.MOG_KUPON_A_ASYW,   53 },
    [xi.items.MOG_KUPON_W_R119   ] = { xi.ki.MOG_KUPON_W_R119,   54 },
    [xi.items.MOG_KUPON_W_M119   ] = { xi.ki.MOG_KUPON_W_M119,   55 },
    [xi.items.MOG_KUPON_W_E119   ] = { xi.ki.MOG_KUPON_W_E119,   56 },
    [xi.items.MOG_KUPON_W_A119   ] = { xi.ki.MOG_KUPON_W_A119,   57 },
    [xi.items.MOG_KUPON_AW_GEIV  ] = { xi.ki.MOG_KUPON_AW_GEIV,  58 },
    [xi.items.MOG_KUPON_A_OMII   ] = { xi.ki.MOG_KUPON_A_OMII,   59 },
    [xi.items.MOG_KUPON_I_AF119  ] = { xi.ki.MOG_KUPON_I_AF119,  60 },
    [xi.items.MOG_KUPON_AW_OM    ] = { xi.ki.MOG_KUPON_AW_OM,    61 },
    [xi.items.MOG_KUPON_W_RMEA   ] = { xi.ki.MOG_KUPON_W_RMEA,   62 },
--  [xi.items.NEXT_POTENTIAL_ID  ] = { xi.ki.NEXT_POTENTIAL_ID,  63 },

}

-- WARNING!!! These items cannot be customised, and must be in the order
-- they appear in the in-game menus! Everything is dictated by the client!
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

    -- Kupon W-E85: Lv85 Empyrean Weapons (MOG_KUPON_W_E85 = 2958)
    [6] =
    {
        xi.items.VERETHRAGNA_85,
        xi.items.TWASHTAR_85,
        xi.items.ALMACE_85,
        xi.items.CALADBOLG_85,
        xi.items.FARSHA_85,
        xi.items.UKONVASARA_85,
        xi.items.REDEMPTION_85,
        xi.items.KANNAGI_85,
        xi.items.MASAMUNE_85,
        xi.items.GAMBANTEINN_85,
        xi.items.HVERGELMIR_85,
        xi.items.GANDIVA_85,
        xi.items.ARMAGEDDON_85,
    },

    -- Kupon A-RJob: Lv70 Relic Armor Accessories (deprecated)
    [7] =
    {
        xi.items.WARRIORS_STONE,
        xi.items.MELEE_CAPE,
        xi.items.CLERICS_BELT,
        xi.items.SORCERERS_BELT,
        xi.items.DUELISTS_BELT,
        xi.items.ASSASSINS_CAPE,
        xi.items.VALOR_CAPE,
        xi.items.ABYSS_CAPE,
        xi.items.MONSTER_BELT,
        xi.items.BARDS_CAPE,
        xi.items.SCOUTS_BELT,
        xi.items.SAOTOME_KOSHI_ATE,
        xi.items.KOGA_SARASHI,
        xi.items.WYRM_BELT,
        xi.items.SUMMONERS_CAPE,
        xi.items.MIRAGE_MANTLE,
        xi.items.COMMODORE_BELT,
        xi.items.PANTIN_CAPE,
        xi.items.ETOILE_CAPE,
        xi.items.ARGUTE_BELT,
    },
    --[[
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

local buildMask = function(player, shift)
    local mask = 0
    local kiID = 0
    for k, v in pairs (kuponLookup) do
        if shift == 2 then
            if v[2] >= 32 and v[2] <= 62 then -- Mask 1 contains index 32 -> 62
                if player:hasKeyItem(v[1]) then
                    mask = mask + bit.lshift(shift, v[2])
                    kiID = v[2] -- Store the Key Item Index ID, used if there is only one KI found
                end
            end
        else
            if v[2] >= 1 and v[2] <= 31 then -- Mask 2 contains index 1 -> 31
                if player:hasKeyItem(v[1]) then
                    mask = mask + bit.lshift(shift, v[2])
                    kiID = v[2]
                end
            end
        end
    end

    return { mask, kiID } -- return both the completed mask and the kiID
end

xi.dealerMoogle.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
    if trade:getItemCount() > 1 then
        return -- Prevent accidental trade of stacks (first vana'diel problems, kupo!)
    end

    if not kuponLookup[itemID] then
        return
    end

    local zoneID = player:getZoneID()
    local csid   = csidLookup[zoneID][2]
    local kiID   = kuponLookup[itemID][1]
    local listID = kuponLookup[itemID][2]

    -- Trade Item (itemID) will only be consumed if the player does not yet have the corresponding KI. It will be replaced with a
    -- key item version! No need to tell the player, the CS handles all of the messaging. If the Player already has the Key Item
    -- (kiID), the itemID will not be consumed, but the kiID will be consumed upon completing a successful transaction.

    -- Scenario 1:  Player trades the item, but does NOT already have the corresponding Key Item. The trade is consumed. Player will
    --              either receive the item(s) of their choice or they will receive the corresponding Key Item if they back out of
    --              the menu without completing a transaction.

    -- Scenario 2:  Player trades the item and DOES already have the corresponding Key Item. The CS menu will present as if the player
    --              triggered the dealer while in posession of the Key Item. If the player completes the transaction, they will receive
    --              the item(s) of their choice, the Key Item will be consumed, the traded item will not be consumed. If the player does
    --              not complete the transaction, they will retain both the traded Item and Key Item.

    if player:hasItem(itemID) then
        if player:hasKeyItem(kiID) then -- Player already has the KI for the traded item. Present the KI version of the CS, consume the KI only if transaction completes.
            player:startEvent(csid, itemID, kiID, listID, 1)
        else -- Player doesn't have the KI corresponding to the item. Consume the item on trade and convert to Key Item.
            trade:confirmItem(itemID, 1)
            player:confirmTrade()
            player:addKeyItem(kiID)

            player:startEvent(csid, itemID, kiID, listID)
        end
    end
end

xi.dealerMoogle.onTrigger = function(player, npc)
    local zoneID = player:getZoneID()
    local cs     = csidLookup[zoneID][2]
    local numKIs = countKeyItems(player)
    local mask1  = buildMask(player, 2)[1]
    local mask2  = buildMask(player, 1)[1]
    local kiID   = buildMask(player, 2)[2] + buildMask(player, 1)[2]

    if numKIs < 1 then -- Found a KI (or more)
        cs = csidLookup[zoneID][1]
    end

    -- Capture of multiple stored KIs: CS2: 0, 0, 51, 4, 0, 0, 1843200, 0

    player:startEvent(cs, 0, 0, kiID, numKIs, 0, 0, mask1, mask2)
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
