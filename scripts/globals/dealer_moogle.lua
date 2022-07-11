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

-- These items cannot be customised, and must be in the order
-- they appear in the in-game menus!
local itemList =
{
    -- Kupon A-DBcd: Dynamis - Beaucedine
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

    -- Kupon A-DXar: Dynamis - Xarcabard
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

    -- Kupon AW-Abs: Absolute Virtue
    [3] =
    {

    },

    -- Kupon AW-Pan: Pandemonium Warden
    [4] =
    {

    },

    -- Kupon A-Lum: Sea NM System
    [5] =
    {

    },

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

}

-- These items cannot be customised!
local kuponLookup =
{
    -- [coupon item id] = { related key item id, index of items in itemList (above) }
    [xi.items.MOG_KUPON_A_DBCD] = { xi.ki.MOG_KUPON_A_DBCD, 1 },
    [xi.items.MOG_KUPON_A_DXAR] = { xi.ki.MOG_KUPON_A_DXAR, 2 },

    --[xi.items.MOG_KUPON_W_PULSE] = { xi.keyItem.MOG_KUPON_W_PULSE, 35 },
}

local hasAKuponKeyItem = function(player)
    for k, _ in pairs(kuponLookup) do
        if player:hasKeyItem(kuponLookup[k][1]) then
            return true
        end
    end
    return false
end

xi.dealerMoogle.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
    local zoneID = player:getZoneID()
    local csid = csidLookup[zoneID][2]
    local kiID = kuponLookup[itemID][1]
    local listID = kuponLookup[itemID][2]

    local unknown1 = 0
    local unknown2 = 0
    local unknown3 = 0
    local unknown4 = 0

    -- Get Vars
    player:setLocalVar("ITEMID", itemID)

    -- TODO: Make sure the player has the item
    trade:confirmItem(itemID, 1)

    player:startEvent(csid, itemID, kiID, listID, unknown1, unknown2, unknown3, unknown4)
end

xi.dealerMoogle.onTrigger = function(player, npc)
    local zoneID = player:getZoneID()
    if hasAKuponKeyItem(player) then
        player:startEvent(csidLookup[zoneID][2])
    else
        player:startEvent(csidLookup[zoneID][1])
    end
end

xi.dealerMoogle.onEventUpdate = function(player, csid, option)
end

xi.dealerMoogle.onEventFinish = function(player, csid, option)
    local zoneID = player:getZoneID()
    -- local introCsid = csidLookup[zoneID][1]
    local itemCsid = csidLookup[zoneID][2]

    if itemCsid then
        -- TODO: Make sure the player has the item, even now

        local selectionIdx = bit.rshift(option, 8)
        local itemID = player:getLocalVar("ITEMID")
        if selectionIdx == 0 then
            local kiID = kuponLookup[itemID][1]
            player:addKeyItem(kiID)
            player:confirmTrade()
        else
            local list =  kuponLookup[itemID][2]
            if type(list) == "number" then -- Single item
                if npcUtil.giveItem(player, itemList[list][selectionIdx]) then
                    player:confirmTrade()
                end
            elseif type(list) == "table" then -- Multiple items
                -- TODO: Check the player can recieve all items
                for _, v in pairs(list) do
                    -- TODO: give the items
                end
                player:confirmTrade()
            end
        end
    end

    -- Clear vars
    player:setLocalVar("ITEMID", 0)
end
