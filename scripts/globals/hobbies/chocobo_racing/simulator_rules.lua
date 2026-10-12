-----------------------------------
-- Chocobo Racing: Simulator rules
-- Every value the simulator uses, grouped by mechanic.
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}
xi.chocoboRacing.simulator = xi.chocoboRacing.simulator or {}

xi.chocoboRacing.simulator.rules =
{
    field =
    {
        autoRacers    = 8,  -- Birds in an auto race. Association races run 6 or 4.
        startPosition = 8,  -- Display position every bird starts at, the middle of the 0-15 range.
        maxGap        = 15, -- Positions show at most this many steps behind the leader.
    },

    -- The opening runs up to the quiet stretch, where nothing happens. Then comes the closing stretch.
    sections =
    {
        count        = 32,
        quietStart   = 16,
        closingStart = 23,
    },

    -- How far a bird runs each section, from its stats.
    speed =
    {
        base               = 4.4375,                              -- Distance every bird runs per section at full effort, before stats: about 4.4 steps.
        strBonus           = 1.21875,                             -- Extra distance per section at the highest STR: about 1.2 steps.
        strCurve           = { 0, 0.2352, 0.58, 0.8058, 0.9026 }, -- Share of strBonus at STR 0, 64, 128, 192 and 256: 0, 24%, 58%, 81%, 90%.
        startStrMultiplier = 2,                                   -- strBonus counts double in the first section.
        dscBonus           = 0.094,                               -- Extra distance per section at DSC rank 7, less at lower ranks: about 0.09 steps.
        endBonus           = 0.03125,                             -- Extra distance per section at END rank 7, less at lower ranks: about 0.03 steps.
        endLateLoss        = 0.1433,                              -- Closing stretch only: distance lost per section at END rank 7, about 0.14 steps.
    },

    -- How much stamina a bird starts with and how fast it spends it.
    stamina =
    {
        startEndBonus = 0.028,  -- Starting stamina is 1 plus this at END 255: about 3% more.
        drainEndCut   = 0.7329, -- Stamina spent per section is about 73% lower at END 255.
        drainEndShape = 0.75,   -- Shape of that END saving: below 1, the first points of END save the most.
        drainRcpCut   = 0.3976, -- Stamina spent per section is about 40% lower at RCP 255.
        leadRange     = 1,      -- Steps from the leader within which a bird counts as leading.
        leadDrainCut  = 0.3125, -- A leading bird spends about 31% less stamina.
        drainLuck     = 0.0082, -- Random spread in how much stamina a bird spends this race: about 0.8% at RCP 0, none at RCP 255.
        minDrain      = 0.01,   -- Lowest drain rate any bird can have, so extreme stats cannot reach zero. Not measured.
    },

    -- When a sprinter eases off to save stamina.
    sprint =
    {
        easeAt        = 0.875, -- A Sprint bird may switch to Keep Pace once down to 87.5% of its starting stamina.
        easeChance    = -0.18, -- Chance it does, 0 to 1: easeChance plus easeChanceRcp times RCP / 255. Never at RCP 20 or less, always from RCP 134.
        easeChanceRcp = 2.25,
    },

    -- How a bird slows as its stamina runs out, and when it shows straining.
    tired =
    {
        slowBelow      = 1.031,      -- Stamina for full speed. Below it a bird loses STR bonus as its stamina drops; it starts just above the starting stamina.
        strKeptEmpty   = 0.4539,     -- 45% of the STR Bonus is conserved once the chocobo is out of stamina.
        strKeptEnd     = 0.3,        -- Up to about 30% more kept at END 255.
        strLossShare   = 0.7345,     -- Running low mostly costs strBonus. Base speed drops only about a quarter as much.
        overdrawnLoss  = 0.1889,     -- Further share of strBonus lost per unit of stamina below zero.
        minStrKept     = 0.2,        -- Least of strBonus a tired bird keeps, so extreme stats cannot stop it. Not measured.
        strainBelow    = 0.7405,     -- A bird shows straining once below about 74% of its starting stamina.
        strainSections = { 23, 30 }, -- Sections where straining shows, when nothing else happens in the section.
    },

    -- Slow starts, first-section luck, and the early burst low DSC birds get.
    start =
    {
        luck           = 0.625,   -- Random spread in the first section: about 0.6 steps.
        slowLoss       = 3.0625,  -- A slow starter loses about 3 steps. The chance of a slow start falls with DSC.
        slowLossDscCut = 0.34375, -- That loss is about 34% smaller at DSC 255.
        burst          = 0.07831, -- Early-race extra effort: about 8% at DSC 0, none at DSC 255.
        burstFade      = 4.375,   -- The burst shrinks to about a third every 4.4 sections.
    },

    -- Item and mud effects are full size in this section, larger before it and smaller after.
    fullEffectSection = 12,

    items =
    {
        sections     = { { 4, 15 }, { 23, 30 } }, -- At most one item use per section.
        effectOffset = 12,                        -- Items are more effective early on. (1.5x to 0.6x)

        -- Chance out of 256 that a bird still holding its item uses it in a free item section: { opening, closing }.
        -- Sprinters use theirs at the first chance. Keep Pace birds use theirs mostly early, depending on the item. Final Spurt birds use theirs mostly late.
        useChance =
        {
            [xi.chocoboRacing.order.SPRINT] =
            {
                [xi.chocoboRacing.sectionEvent.SPEED_APPLE]        = { 256, 200 },
                [xi.chocoboRacing.sectionEvent.STAMINA_APPLE]      = { 256, 200 },
                [xi.chocoboRacing.sectionEvent.SHADOW_APPLE]       = { 256, 200 },
                [xi.chocoboRacing.sectionEvent.PEPPER_BISCUIT]     = { 256, 200 },
                [xi.chocoboRacing.sectionEvent.FIRE_BISCUIT]       = { 256, 200 },
                [xi.chocoboRacing.sectionEvent.GYSAHL_BOMB]        = { 256, 200 },
                [xi.chocoboRacing.sectionEvent.SPORE_BOMB]         = { 256, 200 },
                [xi.chocoboRacing.sectionEvent.FAIRWEATHER_FETISH] = { 256, 200 },
                [xi.chocoboRacing.sectionEvent.FOULWEATHER_FROG]   = { 256, 200 },
            },
            [xi.chocoboRacing.order.KEEP_PACE] =
            {
                [xi.chocoboRacing.sectionEvent.SPEED_APPLE]        = { 90,  187 },
                [xi.chocoboRacing.sectionEvent.STAMINA_APPLE]      = { 72,  187 },
                [xi.chocoboRacing.sectionEvent.SHADOW_APPLE]       = { 92,  187 },
                [xi.chocoboRacing.sectionEvent.PEPPER_BISCUIT]     = { 92,  187 },
                [xi.chocoboRacing.sectionEvent.FIRE_BISCUIT]       = { 115, 187 },
                [xi.chocoboRacing.sectionEvent.GYSAHL_BOMB]        = { 92,  187 },
                [xi.chocoboRacing.sectionEvent.SPORE_BOMB]         = { 92,  187 },
                [xi.chocoboRacing.sectionEvent.FAIRWEATHER_FETISH] = { 92,  187 },
                [xi.chocoboRacing.sectionEvent.FOULWEATHER_FROG]   = { 92,  187 },
            },
            [xi.chocoboRacing.order.FINAL_SPURT] =
            {
                [xi.chocoboRacing.sectionEvent.SPEED_APPLE]        = { 19,  125 },
                [xi.chocoboRacing.sectionEvent.STAMINA_APPLE]      = { 19,  200 },
                [xi.chocoboRacing.sectionEvent.SHADOW_APPLE]       = { 19,  200 },
                [xi.chocoboRacing.sectionEvent.PEPPER_BISCUIT]     = { 19,  200 },
                [xi.chocoboRacing.sectionEvent.FIRE_BISCUIT]       = { 19,  200 },
                [xi.chocoboRacing.sectionEvent.GYSAHL_BOMB]        = { 19,  200 },
                [xi.chocoboRacing.sectionEvent.SPORE_BOMB]         = { 19,  200 },
                [xi.chocoboRacing.sectionEvent.FAIRWEATHER_FETISH] = { 19,  200 },
                [xi.chocoboRacing.sectionEvent.FOULWEATHER_FROG]   = { 19,  200 },
            },
        },
    },

    speedApple =
    {
        distanceGain     = 1.75,  -- An instant jump of about 1.75 steps.
        nextDistanceGain = 1.375, -- About 1.4 more steps the next section.
        lingerGain       = 0.023, -- Then about 0.02 more steps per section...
        lingerSections   = 6,     -- ...for this many sections.
        staminaGain      = 0.022, -- About 0.02 stamina back.
    },

    staminaApple =
    {
        staminaGain = 0.21, -- About 0.2 stamina back, a fifth of the starting stamina.
    },

    -- Always thrown at the leader.
    pepperBiscuit =
    {
        hitPercent   = 47,  -- Seemingly not affected by stats
        distanceLoss = 2.5, -- The bird hit loses about 2.5 steps.
    },

    -- Always thrown at the leader.
    fireBiscuit =
    {
        hitPercent  = 79,    -- Seemingly not affected by stats
        staminaLoss = 0.061, -- The bird hit loses about 0.06 stamina.
    },

    -- Rolls a hit for every opponent, out of 256: hitBase + hitPerRcp * (thrower RCP - target RCP) / 256.
    gysahlBomb =
    {
        hitBase      = 102,   -- Out of 256: about 40% between birds with the same RCP.
        hitPerRcp    = 38,    -- Out of 256, added per 256 RCP the thrower has over the target.
        distanceLoss = 1.375, -- Each bird hit loses about 1.4 steps.
    },

    -- Mud happens only in rain, once per race, in a section with no item use. Three races in four it is in the opening stretch, otherwise early in the closing stretch.
    mud =
    {
        openingSections        = { 5, 15 },
        openingChance          = 192, -- Out of 256: 75% of rainy races get mud in the opening stretch.
        closingSections        = { 23, 30 },
        closingChance          = 128, -- Out of 256: 50% for each closing section in turn, until one is taken.
        caughtPercent          = 78,
        caughtPercentRainLover = 25,
        distanceLoss           = 4,   -- A bird caught loses about 4 steps.
        effectOffset           = 8,   -- Mud is about 2 times full size at section 2 and half at section 30.
    },

    abilities =
    {
        gallopDistance = 0.025,   -- Gallop: about 0.025 steps more per section.
        canterDistance = 0.03125, -- Canter: about 0.03 steps more per section from section 16 on.
        regenDistance  = 0.011,   -- Auto-Regen: about 0.01 steps more per section.
        regenStamina   = 0.0014,  -- Auto-Regen: about 0.001 stamina back per section.
    },

    -- A bird wins back some ground lost at the start over the next sections. It does not win back ground lost to mud or items.
    regain =
    {
        startShare  = 0.3125,   -- About 31% of the first section's luck and slow start is evened out over the next sections.
        perSection  = 0.15625,  -- About 16% of what is still to even out comes back each section.
        staminaCost = 0.000099, -- Stamina spent per step won back: almost none.
    },

    -- By stretch (opening, quiet, closing).
    luck    = { 0.022, 0.09375, 0.125 }, -- Random spread of each section: about 0.02, 0.09, 0.13 steps.
    catchUp = { 0.055, 0.02951, 0.033 }, -- Birds behind run extra per step behind the leader: about 5.5%, 3%, 3.3% of the gap per section.

    -- How each order runs, by stretch (opening, quiet, closing).
    -- effort: share of full speed the bird runs at. drain: stamina spent per section.
    -- drainStr: how much the drain grows with STR, 1 meaning STR 128 spends half of STR 256. drainDscCut: share of the drain DSC 255 saves.
    orders =
    {
        [xi.chocoboRacing.order.SPRINT]      = { effort = { 0.9904, 0.6187, 0.8523 }, drain = { 0.1317, 0.1317, 0.3 },       drainStr = 0.9939, drainDscCut = 0.9375  },
        [xi.chocoboRacing.order.KEEP_PACE]   = { effort = { 1, 0.6229, 0.85 },        drain = { 0.006448, 0.006448, 0.14 }, drainStr = 0.7191, drainDscCut = 0.09375 },
        [xi.chocoboRacing.order.FINAL_SPURT] = { effort = { 0.9936, 0.6215, 0.8485 }, drain = { 0.0092, 0.0092, 0.2224 },   drainStr = 0.8227, drainDscCut = 0.6875  },
    },
}
