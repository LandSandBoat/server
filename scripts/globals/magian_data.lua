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
-- mobId  : Specific Mob ID(s) required to be defeated

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
        mobId       = set{ 17563801 },
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
        mobId       = set{ 17227972, 17227992 },
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
        mobId       = set{ 16793646 },
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
        mobId       = set{ 16822423, 16822427 },
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
        mobId       = set{ 17121576 },
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
        mobId       = set{ 17596628 },
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
        mobId       = set{ 17109384, 17113491 },
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
        mobId       = set{ 17334552, 17338598 },
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
}
