-----------------------------------
-- Campaign global
-----------------------------------
require('scripts/globals/teleports')
-----------------------------------
xi = xi or {}
xi.campaign = {}

xi.campaign.control =
{
    Sandoria = 2,
    Bastok   = 4,
    Windurst = 6,
    Beastman = 8,
}

xi.campaign.union =
{
    Adder  = 1,
    Bison  = 2,
    Coyote = 3,
    Dhole  = 4,
    Eland  = 5,
}

xi.campaign.army =
{
    Sandoria = 0,
    Bastok   = 1,
    Windurst = 2,
    Orcish   = 3,
    Quadav   = 4,
    Yagudo   = 5,
    Kindred  = 6,
}

xi.campaign.zone =
{
    SouthernSandOria     = 80,
    EastRonfaure         = 81,
    JugnerForest         = 82,
    VunkerlInlet         = 83,
    BatalliaDowns        = 84,
    LaVaule              = 85,
    TheEldiemeNecropolis = 175,
    BastokMarkets        = 87,
    NorthGustaberg       = 88,
    Grauberg             = 89,
    PashhowMarshlands    = 90,
    RolanberryFields     = 91,
    Beadeaux             = 92,
    CrawlersNest         = 171,
    WindurstWaters       = 94,
    WestSarutabaruta     = 95,
    FortKarugoNarugo     = 96,
    MeriphataudMountains = 97,
    SauromugueChampaign  = 98,
    CastleOztroja        = 99,
    GarlaigeCitadel      = 164,
    BeaucedineGlacier    = 136,
    Xarcabard            = 137,
    CastleZvahlBaileys   = 138,
    CastleZvahlKeep      = 155,
    ThroneRoom           = 156,
}

xi.campaign.getMedalRank = function(player)
    local rank = 0

    for keyItemId = xi.ki.BRONZE_RIBBON_OF_SERVICE, xi.ki.MEDAL_OF_ALTANA do
        if player:hasKeyItem(keyItemId) then
            rank = rank + 1
        else
            break
        end
    end

    return rank
end

-- First nibble: 2, Second Nibble: Page, rshift 8: entry
local noteRewardItems =
{
    [xi.zone.SOUTHERN_SAN_DORIA_S] =
    {
        [0] = -- Common
        {
            -- BitPos = { itemId, basePrice (allied), isAdjusted },
            [0] = { xi.item.SPRINTERS_SHOES,                  980, false },
            [1] = { xi.item.SCROLL_OF_INSTANT_RETRACE,         10, false },
            [2] = { xi.item.IRON_RAM_JACK_COAT,              1000, true  },
            [3] = { xi.item.PILGRIM_TUNICA,                  1000, true  },
            [4] = { xi.item.IRON_RAM_SHIELD,                 3000, true  },
            [5] = { xi.item.RECALL_RING_JUGNER,              5000, false },
            [6] = { xi.item.RECALL_RING_PASHHOW,             5000, false },
            [7] = { xi.item.RECALL_RING_MERIPHATAUD,         5000, false },
            [8] = { xi.item.CIPHER_OF_VALAINERALS_ALTER_EGO, 2000, false },
            [9] = { xi.item.CIPHER_OF_ADELHEIDS_ALTER_EGO,   2000, false },
        },

        [1] = -- Stars of Service
        {
            [0] = { xi.item.IRON_RAM_CHAINMAIL, 10000, true },
            [1] = { xi.item.IRON_RAM_MUFFLERS,   7000, true },
            [2] = { xi.item.IRON_RAM_SOLLERETS,  7000, true },
            [3] = { xi.item.IRON_RAM_HELM,       7000, true },
            [4] = { xi.item.IRON_RAM_BREECHES,   7000, true },
        },

        [2] = -- Emblems of Service
        {
            [0] = { xi.item.IRON_RAM_HORN,     20000, true },
            [1] = { xi.item.IRON_RAM_LANCE,    20000, true },
            [2] = { xi.item.IRON_RAM_PICK,     20000, true },
            [3] = { xi.item.IRON_RAM_SALLET,   40000, true },
            [4] = { xi.item.IRON_RAM_DASTANAS, 40000, true },
        },

        [3] = -- Wings of Service
        {
            [0] = { xi.item.IRON_RAM_GREAVES, 50000, true },
            [1] = { xi.item.IRON_RAM_HOSE,    50000, true },
        },

        [4] = -- Medals of Service
        {
            [0] = { xi.item.PATRONUS_RING,      30000, true },
            [1] = { xi.item.FOX_EARRING,        30000, true },
            [2] = { xi.item.TEMPLE_EARRING,     30000, true },
            [3] = { xi.item.CRIMSON_BELT,       30000, true },
            [4] = { xi.item.ROSE_STRAP,         30000, true },
            [5] = { xi.item.IRON_RAM_HAUBERK,   75000, true },
            [6] = { xi.item.ROYAL_GUARD_LIVERY, 10000, true },
            [7] = { xi.item.ALLIED_RING,        15000, true },
        },

        [5] = -- Medals of Altana
        {
            [0] = { xi.item.GRIFFINCLAW,             100000, true },
            [1] = { xi.item.ROYAL_KNIGHT_SIGIL_RING,  50000, true },
        },
    },

    [xi.zone.BASTOK_MARKETS_S] =
    {
        [0] = -- Common
        {
            [0] = { xi.item.SPRINTERS_SHOES,                  980, false },
            [1] = { xi.item.SCROLL_OF_INSTANT_RETRACE,         10, false },
            [2] = { xi.item.FOURTH_DIVISION_TUNICA,          1000, true  },
            [3] = { xi.item.PILGRIM_TUNICA,                  1000, true  },
            [4] = { xi.item.FOURTH_DIVISION_GUN,             3000, true  },
            [5] = { xi.item.RECALL_RING_JUGNER,              5000, false },
            [6] = { xi.item.RECALL_RING_PASHHOW,             5000, false },
            [7] = { xi.item.RECALL_RING_MERIPHATAUD,         5000, false },
            [8] = { xi.item.CIPHER_OF_VALAINERALS_ALTER_EGO, 2000, false },
            [9] = { xi.item.CIPHER_OF_ADELHEIDS_ALTER_EGO,   2000, false },
        },

        [1] = -- Stars of Service
        {
            [0] = { xi.item.FOURTH_DIVISION_CUIRASS,   10000, true },
            [1] = { xi.item.FOURTH_DIVISION_GAUNTLETS,  7000, true },
            [2] = { xi.item.FOURTH_DIVISION_SABATONS,   7000, true },
            [3] = { xi.item.FOURTH_DIVISION_ARMET,      7000, true },
            [4] = { xi.item.FOURTH_DIVISION_CUISSES,    7000, true },
        },

        [2] = -- Emblems of Service
        {
            [0] = { xi.item.FOURTH_DIVISION_TOPOROK, 20000, true },
            [1] = { xi.item.FOURTH_DIVISION_MACE,    20000, true },
            [2] = { xi.item.FOURTH_DIVISION_ZAGHNAL, 20000, true },
            [3] = { xi.item.FOURTH_DIVISION_HAUBE,   40000, true },
            [4] = { xi.item.FOURTH_DIVISION_HENTZES, 40000, true },
        },

        [3] = -- Wings of Service
        {
            [0] = { xi.item.FOURTH_DIVISION_SCHUHS, 50000, true },
            [1] = { xi.item.FOURTH_DIVISION_SCHOSS, 50000, true },
        },

        [4] = -- Medals of Service
        {
            [0] = { xi.item.SHIELD_COLLAR,            30000, true },
            [1] = { xi.item.STURMS_REPORT,            30000, true },
            [2] = { xi.item.SONIAS_PLECTRUM,          30000, true },
            [3] = { xi.item.BULL_NECKLACE,            30000, true },
            [4] = { xi.item.ARRESTOR_MANTLE,          30000, true },
            [5] = { xi.item.FOURTH_DIVISION_BRUNNE,   75000, true },
            [6] = { xi.item.MYTHRIL_MUSKETEER_LIVERY, 10000, true },
            [7] = { xi.item.ALLIED_RING,              15000, true },
        },

        [5] = -- Medals of Altana
        {
            [0] = { xi.item.LEX_TALIONIS,           100000, true },
            [1] = { xi.item.FOURTH_DIVISION_MANTLE,  50000, true },
        },
    },

    [xi.zone.WINDURST_WATERS_S] =
    {
        [0] = -- Common
        {
            [0] = { xi.item.SPRINTERS_SHOES,                  980, false },
            [1] = { xi.item.SCROLL_OF_INSTANT_RETRACE,         10, false },
            [2] = { xi.item.COBRA_UNIT_TUNICA,               1000, true  },
            [3] = { xi.item.PILGRIM_TUNICA,                  1000, true  },
            [4] = { xi.item.COBRA_UNIT_CLAYMORE,             3000, true  },
            [5] = { xi.item.RECALL_RING_JUGNER,              5000, false },
            [6] = { xi.item.RECALL_RING_PASHHOW,             5000, false },
            [7] = { xi.item.RECALL_RING_MERIPHATAUD,         5000, false },
            [8] = { xi.item.CIPHER_OF_VALAINERALS_ALTER_EGO, 2000, false },
            [9] = { xi.item.CIPHER_OF_ADELHEIDS_ALTER_EGO,   2000, false },
        },

        [1] = -- Stars of Service
        {
            [0] = { xi.item.COBRA_UNIT_COAT,    10000, true },
            [1] = { xi.item.COBRA_UNIT_CUFFS,    7000, true },
            [2] = { xi.item.COBRA_UNIT_PIGACHES, 7000, true },
            [3] = { xi.item.COBRA_UNIT_HAT,      7000, true },
            [4] = { xi.item.COBRA_UNIT_SLOPS,    7000, true },
        },

        [2] = -- Emblems of Service
        {
            [0] = { xi.item.COBRA_UNIT_BAGHNAKHS, 20000, true },
            [1] = { xi.item.COBRA_UNIT_KNIFE,     20000, true },
            [2] = { xi.item.COBRA_UNIT_BOW,       20000, true },
            [3] = { xi.item.COBRA_UNIT_CAP,       40000, true },
            [4] = { xi.item.COBRA_UNIT_MITTENS,   40000, true },
            [5] = { xi.item.COBRA_UNIT_CLOCHE,    40000, true },
            [6] = { xi.item.COBRA_UNIT_GLOVES,    40000, true },
        },

        [3] = -- Wings of Service
        {
            [0] = { xi.item.COBRA_UNIT_LEGGINGS, 50000, true },
            [1] = { xi.item.COBRA_UNIT_SUBLIGAR, 50000, true },
            [2] = { xi.item.COBRA_UNIT_CRACKOWS, 50000, true },
            [3] = { xi.item.COBRA_UNIT_TREWS,    50000, true },
        },

        [4] = -- Medals of Service
        {
            [0] = { xi.item.CAPRICORNIAN_ROPE,  30000, true },
            [1] = { xi.item.EARTHY_BELT,        30000, true },
            [2] = { xi.item.COUGAR_PENDANT,     30000, true },
            [3] = { xi.item.CROCODILE_COLLAR,   30000, true },
            [4] = { xi.item.ARIESIAN_GRIP,      30000, true },
            [5] = { xi.item.COBRA_UNIT_HARNESS, 75000, true },
            [6] = { xi.item.COBRA_UNIT_ROBE,    75000, true },
            [7] = { xi.item.ALLIED_RING,        15000, true }
        },

        [5] = -- Medals of Altana
        {
            [0] = { xi.item.SAMUDRA,               100000, true },
            [1] = { xi.item.MERCENARY_MAJOR_CHARM,  50000, true },
        },
    },
}

-- -------------------------------------------------------------------
-- getSigilTimeStamp(player)
-- This is for the time-stamp telling player what day/time the
-- effect will last until, NOT the actual status effect duration.
-- -------------------------------------------------------------------

xi.campaign.getSigilTimeStamp = function(player)
    local timeStamp = 0 -- zero'd till math is done.

    -- TODO: calculate time stamp for menu display of when it wears off

    return timeStamp
end
