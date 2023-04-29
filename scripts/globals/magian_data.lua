-----------------------------------
-- Magian Trial Data
-----------------------------------
require('scripts/globals/common')
require('scripts/globals/items')
require('scripts/globals/status')
-----------------------------------
xi = xi or {}
xi.magian = xi.magian or {}

-- Trial data requires that all conditions be defined per table if they are to be
-- checked.  Undefined (nil) values for specific keys will be ignored in the applied
-- listener.

-- Available Options to define:
-- tradeItem  : Item required for trades to delivery crate

xi.magian.trials =
{
    [2] = -- Nocuous Weapon x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.PEELER,
        },

        textOffset  = 1,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.RENEGADE,
        },
    },

    [3] = -- Black Triple Stars x3
    {
        previousTrial = 2,
        requiredItem  =
        {
            itemId = xi.items.RENEGADE,
        },

        textOffset  = 2,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.RENEGADE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack +3
            },
        },
    },

    [4] = -- Serra x3
    {
        previousTrial = 3,
        requiredItem  =
        {
            itemId       = xi.items.RENEGADE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack +3
            },
        },

        textOffset  = 3,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.RENEGADE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack +5
            },
        },
    },

    [5] = -- Bugbear Strongman x4
    {
        previousTrial = 4,
        requiredItem  =
        {
            itemId       = xi.items.RENEGADE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack +5
            },
        },

        textOffset  = 43,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.KARTIKA,
        },
    },

    [6] = -- La Velue x4
    {
        previousTrial = 5,
        requiredItem  =
        {
            itemId       = xi.items.KARTIKA,
        },

        textOffset  = 44,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack +3
            },
        },
    },

    [7] = -- Hovering Hotpot x4
    {
        previousTrial = 6,
        requiredItem  =
        {
            itemId       = xi.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack +3
            },
        },

        textOffset  = 45,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack +5
            },
        },
    },

    [8] = -- Yacumama x6
    {
        previousTrial = 7,
        requiredItem  =
        {
            itemId       = xi.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack +5
            },
        },

        textOffset  = 46,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack +7
            },
        },
    },

    [9] = -- Feuerunke x6
    {
        previousTrial = 8,
        requiredItem  =
        {
            itemId       = xi.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack +5
            },
        },

        textOffset  = 47,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.KARTIKA,
            itemAugments =
            {
                [1] = { 45, 4 }, -- DMG: +5
            },
        },
    },

    [10] = -- Arcana x400
    {
        previousTrial = 4,
        requiredItem  =
        {
            itemId       = xi.items.RENEGADE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack +5
            },
        },

        textOffset   = 68,
        mobEcosystem = xi.ecosystem.ARCANA,
        numRequired  = 400,

        rewardItem =
        {
            itemId = xi.items.ATHAME,
        },
    },

    [11] = -- Hippogryph x300
    {
        previousTrial = 10,
        requiredItem  =
        {
            itemId = xi.items.ATHAME,
        },

        textOffset  = 69,
        mobFamily   = set{ 140, 141 },
        numRequired = 300,

        rewardItem =
        {
            itemId = xi.items.ATHAME,
            itemAugments =
            {
                [1] = { 764, 14 }, -- Delay:-15
            },
        },
    },

    [12] = -- Eye of Verthandi x10
    {
        previousTrial = 11,
        requiredItem  =
        {
            itemId       = xi.items.ATHAME,
            itemAugments =
            {
                [1] = { 764, 14 }, -- Delay:-15
            },
        },

        textOffset  = 70,
        tradeItem   = xi.items.EYE_OF_VERTHANDI,
        numRequired = 10,

        rewardItem =
        {
            itemId = xi.items.ATHAME,
            itemAugments =
            {
                [1] = {  45, 12 }, -- DMG: +13
                [2] = { 752, 20 }, -- Delay:+21
                [3] = { 912, 10 }, -- Occ. atk. twice
            }
        },
    },

    [13] = -- Amorphs x500
    {
        previousTrial = 11,
        requiredItem  =
        {
            itemId       = xi.items.ATHAME,
            itemAugments =
            {
                [1] = { 764, 14 }, -- Delay:-15
            },
        },

        textOffset   = 71,
        mobEcosystem = xi.ecosystem.AMORPH,
        numRequired  = 500,

        rewardItem =
        {
            itemId       = xi.items.ATHAME,
            itemAugments =
            {
                [1] = { 764, 29 }, -- Delay:-30
            },
        },
    },

    [14] = -- Plantoids x600
    {
        previousTrial = 13,
        requiredItem  =
        {
            itemId       = xi.items.ATHAME,
            itemAugments =
            {
                [1] = { 764, 29 }, -- Delay:-30
            },
        },

        textOffset   = 72,
        mobEcosystem = xi.ecosystem.PLANTOID,
        numRequired  = 600,

        rewardItem =
        {
            itemId       = xi.items.ATHAME,
            itemAugments =
            {
                [1] = { 757, 7 }, -- Delay:-40
            },
        },
    },

    [68] = -- Tumbling Truffle x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.PUGILISTS,
        },

        textOffset  = 4,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.SIMIAN_FISTS,
        },
    },

    [69] = -- Helldiver x3
    {
        previousTrial = 68,
        requiredItem  =
        {
            itemId = xi.items.SIMIAN_FISTS,
        },

        textOffset  = 5,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.SIMIAN_FISTS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [70] = -- Orctrap x3
    {
        previousTrial = 69,
        requiredItem  =
        {
            itemId       = xi.items.SIMIAN_FISTS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 6,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.SIMIAN_FISTS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [71] = -- Intulo x4
    {
        previousTrial = 70,
        requiredItem  =
        {
            itemId       = xi.items.SIMIAN_FISTS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 48,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.MANTIS,
        },
    },

    [72] = -- Ramponneau x4
    {
        previousTrial = 71,
        requiredItem  =
        {
            itemId = xi.items.MANTIS,
        },

        textOffset  = 49,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [73] = -- Keeper of Halidom x4
    {
        previousTrial = 72,
        requiredItem  =
        {
            itemId       = xi.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 50,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [74] = -- Shoggoth x6
    {
        previousTrial = 73,
        requiredItem  =
        {
            itemId       = xi.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 51,
        numRequired = 6,

        rewardItem =
        {
            itemId = xi.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [75] = -- Farruca Fly x6
    {
        previousTrial = 74,
        requiredItem  =
        {
            itemId       = xi.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 52,
        numRequired = 6,

        rewardItem =
        {
            itemId = xi.items.MANTIS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },
    },

    [150] = -- Serpopard Ishtar x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.SIDE_SWORD,
        },

        textOffset  = 7,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.SCHIAVONA,
        },
    },

    [151] = -- Tottering Toby x3
    {
        previousTrial = 150,
        requiredItem  =
        {
            itemId = xi.items.SCHIAVONA,
        },

        textOffset  = 8,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SCHIAVONA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [152] = -- Drooling Daisy x3
    {
        previousTrial = 151,
        requiredItem  =
        {
            itemId       = xi.items.SCHIAVONA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 9,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SCHIAVONA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [153] = -- Gargantua x4
    {
        previousTrial = 152,
        requiredItem  =
        {
            itemId       = xi.items.SCHIAVONA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 53,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.NOBILIS,
        },
    },

    [154] = -- Megalobugard x4
    {
        previousTrial = 153,
        requiredItem  =
        {
            itemId = xi.items.NOBILIS,
        },

        textOffset  = 54,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [155] = -- Ratatoskr x4
    {
        previousTrial = 154,
        requiredItem  =
        {
            itemId       = xi.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 55,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [156] = -- Jyeshtha x6
    {
        previousTrial = 155,
        requiredItem  =
        {
            itemId       = xi.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 56,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [157] = -- Capricornus x6
    {
        previousTrial = 156,
        requiredItem  =
        {
            itemId       = xi.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 57,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.NOBILIS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },
    },

    [216] = -- Bloodpool Vorax x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.BREAK_BLADE,
        },

        textOffset  = 10,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.SUNBLADE,
        },
    },

    [217] = -- Golden Bat x3
    {
        previousTrial = 216,
        requiredItem  =
        {
            itemId = xi.items.SUNBLADE,
        },

        textOffset  = 11,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SUNBLADE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [218] = -- Slippery Sucker x3
    {
        previousTrial = 217,
        requiredItem  =
        {
            itemId       = xi.items.SUNBLADE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 12,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SUNBLADE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [219] = -- Seww the Squidlimbed x4
    {
        previousTrial = 218,
        requiredItem  =
        {
            itemId       = xi.items.SUNBLADE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 58,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.ALBION,
        },
    },

    [220] = -- Ankabut x4
    {
        previousTrial = 219,
        requiredItem  =
        {
            itemId = xi.items.ALBION,
        },

        textOffset  = 59,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [221] = -- Okyupete x4
    {
        previousTrial = 220,
        requiredItem  =
        {
            itemId       = xi.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 60,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [222] = -- Urd x6
    {
        previousTrial = 221,
        requiredItem  =
        {
            itemId       = xi.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 61,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [223] = -- Lamprey Lord x6
    {
        previousTrial = 222,
        requiredItem  =
        {
            itemId       = xi.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 62,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.ALBION,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },
    },

    [282] = -- Panzer Percival x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.CHOPPER,
        },

        textOffset  = 13,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.SPLINTER,
        },
    },

    [283] = -- Ge'Dha Evileye x3
    {
        previousTrial = 282,
        requiredItem  =
        {
            itemId = xi.items.SPLINTER,
        },

        textOffset  = 14,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SPLINTER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [284] = -- Bashe x3
    {
        previousTrial = 283,
        requiredItem  =
        {
            itemId       = xi.items.SPLINTER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 15,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SPLINTER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [285] = -- Intulo x4
    {
        previousTrial = 284,
        requiredItem  =
        {
            itemId       = xi.items.SPLINTER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 48,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.BONEBITER,
        },
    },

    [286] = -- Ramponneau x4
    {
        previousTrial = 285,
        requiredItem  =
        {
            itemId = xi.items.BONEBITER,
        },

        textOffset  = 49,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [287] = -- Keeper of Halidom x4
    {
        previousTrial = 286,
        requiredItem  =
        {
            itemId       = xi.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 50,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [288] = -- Shoggoth x6
    {
        previousTrial = 287,
        requiredItem  =
        {
            itemId       = xi.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 51,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [289] = -- Farruca Fly x6
    {
        previousTrial = 288,
        requiredItem  =
        {
            itemId       = xi.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 52,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.BONEBITER,
            itemAugments =
            {
                [1] = { 45, 5 }, -- DMG:+6
            },
        },
    },

    [364] = -- Hoo Mjuu the Torrent x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.LUMBERJACK,
        },

        textOffset  = 16,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.SAGARIS,
        },
    },

    [365] = -- Daggerclaw Dracos x3
    {
        previousTrial = 364,
        requiredItem  =
        {
            itemId = xi.items.SAGARIS,
        },

        textOffset  = 17,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SAGARIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [366] = -- Namtar x3
    {
        previousTrial = 365,
        requiredItem  =
        {
            itemId       = xi.items.SAGARIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 18,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SAGARIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [367] = -- Gargantua x4
    {
        previousTrial = 366,
        requiredItem  =
        {
            itemId       = xi.items.SAGARIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 53,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.BONESPLITTER,
        },
    },

    [368] = -- Megalobugard x4
    {
        previousTrial = 367,
        requiredItem  =
        {
            itemId = xi.items.BONESPLITTER,
        },

        textOffset  = 54,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [369] = -- Ratatoskr x4
    {
        previousTrial = 368,
        requiredItem  =
        {
            itemId       = xi.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 55,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [370] = -- Jyeshtha x6
    {
        previousTrial = 369,
        requiredItem  =
        {
            itemId       = xi.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 56,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [371] = -- Capricornus x6
    {
        previousTrial = 370,
        requiredItem  =
        {
            itemId       = xi.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 57,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 45, 10 }, -- DMG:+11
            },
        },
    },

    [430] = -- Slendlix Spindlethumb x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.RANSEUR,
        },

        textOffset  = 19,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.COPPERHEAD,
        },
    },

    [431] = -- Herbage Hunter x3
    {
        previousTrial = 430,
        requiredItem  =
        {
            itemId = xi.items.COPPERHEAD,
        },

        textOffset  = 20,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.COPPERHEAD,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [432] = -- Kirata x3
    {
        previousTrial = 431,
        requiredItem  =
        {
            itemId       = xi.items.COPPERHEAD,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 21,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.COPPERHEAD,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [433] = -- Intulo x4
    {
        previousTrial = 432,
        requiredItem  =
        {
            itemId       = xi.items.COPPERHEAD,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 48,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.OATHKEEPER,
        },
    },

    [434] = -- Ramponneau x4
    {
        previousTrial = 433,
        requiredItem  =
        {
            itemId = xi.items.OATHKEEPER,
        },

        textOffset  = 49,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [435] = -- Keeper of Halidom x4
    {
        previousTrial = 434,
        requiredItem  =
        {
            itemId       = xi.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 50,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [436] = -- Shoggoth x6
    {
        previousTrial = 435,
        requiredItem  =
        {
            itemId       = xi.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 51,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [437] = -- Farruca Fly x6
    {
        previousTrial = 436,
        requiredItem  =
        {
            itemId       = xi.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 52,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },
    },

    [512] = -- Barbastelle x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.FARMHAND,
        },

        textOffset  = 22,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.STIGMA,
        },
    },

    [513] = -- Ah Puch x3
    {
        previousTrial = 512,
        requiredItem  =
        {
            itemId = xi.items.STIGMA,
        },

        textOffset  = 23,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.STIGMA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [514] = -- Donggu x3
    {
        previousTrial = 513,
        requiredItem  =
        {
            itemId       = xi.items.STIGMA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 24,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.STIGMA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [515] = -- Bugbear Strongman x4
    {
        previousTrial = 514,
        requiredItem  =
        {
            itemId       = xi.items.STIGMA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 43,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.ULTIMATUM,
        },
    },

    [516] = -- La Velue x4
    {
        previousTrial = 515,
        requiredItem  =
        {
            itemId = xi.items.ULTIMATUM,
        },

        textOffset  = 44,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [517] = -- Hovering Hotpot x4
    {
        previousTrial = 516,
        requiredItem  =
        {
            itemId = xi.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 45,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [518] = -- Yacumama x6
    {
        previousTrial = 517,
        requiredItem  =
        {
            itemId = xi.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 46,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [519] = -- Feuerunke x6
    {
        previousTrial = 518,
        requiredItem  =
        {
            itemId = xi.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 47,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },
    },

    [578] = -- Zi'Ghi Boneeater x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.KIBASHIRI,
        },

        textOffset  = 25,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.KORURI,
        },
    },

    [579] = -- Lumbering Lambert x3
    {
        previousTrial = 578,
        requiredItem  =
        {
            itemId = xi.items.KORURI,
        },

        textOffset  = 26,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.KORURI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [580] = -- Deadly Dodo x3
    {
        previousTrial = 579,
        requiredItem  =
        {
            itemId       = xi.items.KORURI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 27,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.KORURI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [581] = -- Gargantua x4
    {
        previousTrial = 580,
        requiredItem  =
        {
            itemId       = xi.items.KORURI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 53,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.MOZU,
        },
    },

    [582] = -- Megalobugard x4
    {
        previousTrial = 581,
        requiredItem  =
        {
            itemId = xi.items.MOZU,
        },

        textOffset  = 54,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [583] = -- Ratatoskr x4
    {
        previousTrial = 582,
        requiredItem  =
        {
            itemId       = xi.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 55,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [584] = -- Jyeshtha x6
    {
        previousTrial = 583,
        requiredItem  =
        {
            itemId       = xi.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 56,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [585] = -- Capricornus x6
    {
        previousTrial = 584,
        requiredItem  =
        {
            itemId       = xi.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 57,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.MOZU,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },
    },

    [644] = -- Vuu Puqu the Beguiler x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.DONTO,
        },

        textOffset  = 28,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.SHIRODACHI,
        },
    },

    [645] = -- Buburimboo x3
    {
        previousTrial = 644,
        requiredItem  =
        {
            itemId = xi.items.SHIRODACHI,
        },

        textOffset  = 29,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SHIRODACHI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [646] = -- Zo'Khu Blackcloud x3
    {
        previousTrial = 645,
        requiredItem  =
        {
            itemId       = xi.items.SHIRODACHI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 30,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SHIRODACHI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [647] = -- Seww the Squidlimbed x4
    {
        previousTrial = 646,
        requiredItem  =
        {
            itemId       = xi.items.SHIRODACHI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 58,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.RADENNOTACHI,
        },
    },

    [648] = -- Ankabut x4
    {
        previousTrial = 647,
        requiredItem  =
        {
            itemId = xi.items.RADENNOTACHI,
        },

        textOffset  = 59,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [649] = -- Okyupete x4
    {
        previousTrial = 648,
        requiredItem  =
        {
            itemId       = xi.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 60,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [650] = -- Urd x6
    {
        previousTrial = 649,
        requiredItem  =
        {
            itemId       = xi.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 61,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [651] = -- Lamprey Lord x6
    {
        previousTrial = 650,
        requiredItem  =
        {
            itemId       = xi.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 62,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },
    },

    [710] = -- Stray Mary x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.STENZ,
        },

        textOffset  = 31,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.RAGEBLOW,
        },
    },

    [711] = -- Hawkeyed Dnatbat x3
    {
        previousTrial = 710,
        requiredItem  =
        {
            itemId = xi.items.RAGEBLOW,
        },

        textOffset  = 32,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.RAGEBLOW,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [712] = -- Dune Widow x3
    {
        previousTrial = 711,
        requiredItem  =
        {
            itemId       = xi.items.RAGEBLOW,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 33,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.RAGEBLOW,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [713] = -- Seww the Squidlimbed x4
    {
        previousTrial = 712,
        requiredItem  =
        {
            itemId       = xi.items.RAGEBLOW,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 58,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.CULACULA,
        },
    },

    [714] = -- Ankabut x4
    {
        previousTrial = 713,
        requiredItem  =
        {
            itemId = xi.items.CULACULA,
        },

        textOffset  = 59,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [715] = -- Okyupete x4
    {
        previousTrial = 714,
        requiredItem  =
        {
            itemId       = xi.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 60,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [716] = -- Urd x6
    {
        previousTrial = 715,
        requiredItem  =
        {
            itemId       = xi.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 61,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [717] = -- Lamprey Lord x6
    {
        previousTrial = 716,
        requiredItem  =
        {
            itemId       = xi.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 62,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.CULACULA,
            itemAugments =
            {
                [1] = { 45, 14 }, -- DMG:+15
            },
        },
    },

    [776] = -- Teporingo x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.CROOK,
        },

        textOffset  = 34,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.SHILLELAGH,
        },
    },

    [777] = -- Valkurm Emperor x3
    {
        previousTrial = 776,
        requiredItem  =
        {
            itemId = xi.items.SHILLELAGH,
        },

        textOffset  = 35,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SHILLELAGH,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [778] = -- Hyakume x3
    {
        previousTrial = 777,
        requiredItem  =
        {
            itemId       = xi.items.SHILLELAGH,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 36,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.SHILLELAGH,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [779] = -- Gloomanita x4
    {
        previousTrial = 778,
        requiredItem  =
        {
            itemId       = xi.items.SHILLELAGH,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 63,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.SLAINE,
        },
    },

    [780] = -- Mischievous Micholas x4
    {
        previousTrial = 779,
        requiredItem  =
        {
            itemId = xi.items.SLAINE,
        },

        textOffset  = 64,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [781] = -- Cactuar Cantautor x4
    {
        previousTrial = 780,
        requiredItem  =
        {
            itemId       = xi.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 65,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [782] = -- Erebus x6
    {
        previousTrial = 781,
        requiredItem  =
        {
            itemId       = xi.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 66,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [783] = -- Skuld x6
    {
        previousTrial = 782,
        requiredItem  =
        {
            itemId       = xi.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 67,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.SLAINE,
            itemAugments =
            {
                [1] = { 45, 12 }, -- DMG:+13
            },
        },
    },

    [891] = -- Desmodont x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.THUNDERSTICK,
        },

        textOffset  = 37,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.BLUE_STEEL,
        },
    },

    [892] = -- Moo Ouzi the Swiftblade x3
    {
        previousTrial = 891,
        requiredItem  =
        {
            itemId = xi.items.BLUE_STEEL,
        },

        textOffset  = 38,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.BLUE_STEEL,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },
    },

    [893] = -- Ni'Zho Bladebender x3
    {
        previousTrial = 892,
        requiredItem  =
        {
            itemId       = xi.items.BLUE_STEEL,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },

        textOffset  = 39,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.BLUE_STEEL,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },
    },

    [894] = -- Bugbear Strongman x4
    {
        previousTrial = 893,
        requiredItem  =
        {
            itemId       = xi.items.BLUE_STEEL,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },

        textOffset  = 43,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.MAGNATUS,
        },
    },

    [895] = -- La Velue x4
    {
        previousTrial = 894,
        requiredItem  =
        {
            itemId = xi.items.MAGNATUS,
        },

        textOffset  = 44,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },
    },

    [896] = -- Hovering Hotpot x4
    {
        previousTrial = 895,
        requiredItem  =
        {
            itemId       = xi.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },

        textOffset  = 45,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },
    },

    [897] = -- Yacumama x6
    {
        previousTrial = 896,
        requiredItem  =
        {
            itemId       = xi.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },

        textOffset  = 46,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 6 }, -- Rng.Atk.+7
            },
        },
    },

    [898] = -- Feuerunke x6
    {
        previousTrial = 897,
        requiredItem  =
        {
            itemId       = xi.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 6 }, -- Rng.Atk.+7
            },
        },

        textOffset  = 47,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },
    },

    [941] = -- Be'Hya Hundredwall x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = xi.items.SPARROW,
        },

        textOffset  = 40,
        numRequired = 3,

        rewardItem =
        {
            itemId = xi.items.KESTREL,
        },
    },

    [942] = -- Jolly Green x3
    {
        previousTrial = 941,
        requiredItem  =
        {
            itemId = xi.items.KESTREL,
        },

        textOffset  = 41,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.KESTREL,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },
    },

    [943] = -- Trembler Tabitha x3
    {
        previousTrial = 942,
        requiredItem  =
        {
            itemId       = xi.items.KESTREL,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },

        textOffset  = 42,
        numRequired = 3,

        rewardItem =
        {
            itemId       = xi.items.KESTREL,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },
    },

    [944] = -- Seww the Squidlimbed x4
    {
        previousTrial = 943,
        requiredItem  =
        {
            itemId       = xi.items.KESTREL,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },

        textOffset  = 58,
        numRequired = 4,

        rewardItem =
        {
            itemId = xi.items.ASTRILD,
        },
    },

    [945] = -- Ankabut x4
    {
        previousTrial = 944,
        requiredItem  =
        {
            itemId = xi.items.ASTRILD,
        },

        textOffset  = 59,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },
    },

    [946] = -- Okyupete x4
    {
        previousTrial = 945,
        requiredItem  =
        {
            itemId       = xi.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },

        textOffset  = 60,
        numRequired = 4,

        rewardItem =
        {
            itemId       = xi.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },
    },

    [947] = -- Urd x6
    {
        previousTrial = 946,
        requiredItem  =
        {
            itemId       = xi.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },

        textOffset  = 61,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 6 }, -- Rng.Atk.+7
            },
        },
    },

    [948] = -- Lamprey Lord x6
    {
        previousTrial = 947,
        requiredItem  =
        {
            itemId       = xi.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 6 }, -- Rng.Atk.+7
            },
        },

        textOffset  = 62,
        numRequired = 6,

        rewardItem =
        {
            itemId       = xi.items.ASTRILD,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },
    },

    [1092] = -- Tammuz x8
    {
        previousTrial = 9,
        requiredItem  =
        {
            itemId       = xi.items.KARTIKA,
            itemAugments =
            {
                [1] = { 45, 4 }, -- DMG:+5
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.KARTIKA,
            itemAugments =
            {
                [1] = { 45, 5 }, -- DMG:+6
            },
        },
    },

    [1138] = -- Chesma x8
    {
        previousTrial = 75,
        requiredItem  =
        {
            itemId       = xi.items.MANTIS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId = xi.items.MANTIS,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },
    },

    [1200] = -- Tammuz x8
    {
        previousTrial = 156,
        requiredItem  =
        {
            itemId       = xi.items.NOBILIS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.NOBILIS,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },
    },

    [1246] = -- Chesma x8
    {
        previousTrial = 223,
        requiredItem  =
        {
            itemId       = xi.items.ALBION,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.ALBION,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },
    },

    [1292] = -- Tammuz x8
    {
        previousTrial = 289,
        requiredItem  =
        {
            itemId       = xi.items.BONEBITER,
            itemAugments =
            {
                [1] = { 45, 5 }, -- DMG:+6
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.BONEBITER,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },
    },

    [1354] = -- Chesma x8
    {
        previousTrial = 371,
        requiredItem  =
        {
            itemId       = xi.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 45, 10 }, -- DMG:+11
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 45, 12 }, -- DMG:+13
            },
        },
    },

    [1400] = -- Chesma x8
    {
        previousTrial = 437,
        requiredItem  =
        {
            itemId       = xi.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 45, 13 }, -- DMG:+14
            },
        },
    },

    [1462] = -- Tammuz x8
    {
        previousTrial = 519,
        requiredItem  =
        {
            itemId = xi.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 45, 13 }, -- DMG:+14
            },
        },
    },

    [1508] = -- Tammuz x8
    {
        previousTrial = 585,
        requiredItem  =
        {
            itemId       = xi.items.MOZU,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.MOZU,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },
    },

    [1554] = -- Chesma x8
    {
        previousTrial = 651,
        requiredItem  =
        {
            itemId       = xi.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },
    },

    [1600] = -- Tammuz x8
    {
        previousTrial = 717,
        requiredItem  =
        {
            itemId       = xi.items.CULACULA,
            itemAugments =
            {
                [1] = { 45, 14 }, -- DMG:+15
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.CULACULA,
            itemAugments =
            {
                [1] = { 45, 15 }, -- DMG:+16
            },
        },
    },

    [1646] = -- Chesma x8
    {
        previousTrial = 783,
        requiredItem  =
        {
            itemId       = xi.items.SLAINE,
            itemAugments =
            {
                [1] = { 45, 12 }, -- DMG:+13
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.SLAINE,
            itemAugments =
            {
                [1] = { 45, 14 }, -- DMG:+15
            },
        },
    },

    [1758] = -- Tammuz x8
    {
        previousTrial = 898,
        requiredItem  =
        {
            itemId       = xi.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },
    },

    [1788] = -- Chesma x8
    {
        previousTrial = 948,
        requiredItem  =
        {
            itemId       = xi.items.ASTRILD,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = xi.items.ASTRILD,
            itemAugments =
            {
                [1] = { 45, 10 }, -- DMG:+11
            },
        },
    },
}
