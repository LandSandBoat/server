-----------------------------------
-- Chocobo Raising - Constants & Lookups
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

-- TODO: Remove the duplication for walk CSs
xi.chocoboRaising.csidTable =
{
    -- { intro csid, main csid, trading csid, rejection csid, chicks owner csid, short walk csid, medium walk csid, long walk csid, watch csid, debug }
    [xi.zone.SOUTHERN_SAN_DORIA] = { 817, 823, 826, 831, 852, 298, 299, 300, 304, 862 }, -- Hantileon
    [xi.zone.BASTOK_MINES]       = { 508, 509, 512, 515, 542, 554, 555, 556, 560, 558 }, -- Zopago
    [xi.zone.WINDURST_WOODS]     = { 741, 742, 745, 748, 766, 810, 811, 812, 816, 773 }, -- Pulonono
}

xi.chocoboRaising.raisingLocation =
{
    [xi.zone.SOUTHERN_SAN_DORIA] = 1,
    [xi.zone.BASTOK_MINES]       = 2,
    [xi.zone.WINDURST_WOODS]     = 3,
}

xi.chocoboRaising.shortWalkLocation =
{
    [1] = xi.zone.WEST_RONFAURE,
    [2] = xi.zone.NORTH_GUSTABERG,
    [3] = xi.zone.EAST_SARUTABARUTA,
}

xi.chocoboRaising.mediumWalkLocation =
{
    [1] = xi.zone.LA_THEINE_PLATEAU,
    [2] = xi.zone.KONSCHTAT_HIGHLANDS,
    [3] = xi.zone.TAHRONGI_CANYON,
}

xi.chocoboRaising.longWalkLocation =
{
    [1] = xi.zone.JUGNER_FOREST,
    [2] = xi.zone.PASHHOW_MARSHLANDS,
    [3] = xi.zone.MERIPHATAUD_MOUNTAINS,
}

xi.chocoboRaising.stage =
{
    EGG        = 1,
    CHICK      = 2,
    ADOLESCENT = 3,
    ADULT_1    = 4,
    ADULT_2    = 5,
    ADULT_3    = 6,
    ADULT_4    = 7, -- Retired?
}

xi.chocoboRaising.affectionRank =
{
    DOESNT_CARE       = 0,
    CAN_ENDURE        = 1,
    SLIGHTLY_ENJOY    = 2,
    LIKES             = 3,
    LIKES_PRETTY_WELL = 4,
    LIKES_A_LOT       = 5,
    ALL_THE_TIME      = 6,
    PARENT            = 7,
}

xi.chocoboRaising.hunger =
{
    STARVING        = 0,
    QUITE_HUNGRY    = 1,
    A_LITTLE_HUNGRY = 2,
    AVERAGE_1       = 3,
    AVERAGE_2       = 4,
    ALMOST_FULL     = 5,
    QUITE_FULL      = 6,
    COMPLETELY_FULL = 7,
}
utils.unused(xi.chocoboRaising.hunger)

-- TODO: Combine carePlanData with this cutscenes table, so cutscenes have associated
--     : stat changes that can be looked up and applied.
xi.chocoboRaising.cutscenes =
{
    -- Each cutscene needs this offset added to them before they can be used,
    -- depending on the zone
    SANDORIA_OFFSET = 256,
    BASTOK_OFFSET   = 512,
    WINDURST_OFFSET = 768,

    -- EGG ONWARDS:
    REPORT_BASIC_CARE = 0,

    -- CHICK ONWARDS:
    REPORT_REST            = 1,
    REPORT_TAKE_A_WALK     = 2,
    REPORT_LISTEN_TO_MUSIC = 3,

    -- ADOLESCENT ONWARDS:
    REPORT_EXERCISE_ALONE         = 4,
    REPORT_EXERCISE_IN_A_GROUP    = 5,
    REPORT_INTERACT_WITH_CHILDREN = 6,
    REPORT_INTERACT_WITH_CHOCOBOS = 7,
    REPORT_CARRY_PACKAGES         = 8,
    REPORT_EXHIBIT_TO_THE_PUBLIC  = 9,

    -- ADULT ONWARDS:
    REPORT_DELIVER_MESSAGES = 10,
    REPORT_DIG_FOR_TREASURE = 11,
    REPORT_ACT_IN_A_PLAY    = 12,

    -- OTHER:
    EGG_HATCHING          = 33,
    CHICK_TO_ADOLESCENT   = 34,
    ADOLESCENT_TO_ADULT_1 = 35,
    ADULT_1_TO_ADULT_2    = 36,
    ADULT_2_TO_ADULT_3    = 37,
    ADULT_3_TO_ADULT_4    = 38,

    RAN_AWAY = 39,
    -- 40: Player gives the chocobo x
    -- 48: Happy to see you
    INTERESTED_IN_YOUR_STORY = 50,
    HANGS_HEAD_IN_SHAME      = 51, -- Hangs its head in shame
    COMPETE_WITH_OTHERS      = 52,
    HAVENT_SEEN_YOU          = 53, -- Haven't seen you around, chocobo is sleeping (dispose of white handkerchief)
    -- 54: Accept white handkerchief
    CRYING_AT_NIGHT = 69, -- White handkerchief
    -- 70: Chocobo full of energy!
    -- 71: Bright and focused
    -- 72: Injury has healed
    CALMED_DOWN = 77,
    -- 84: Sleeping well thanks to White Handkerchief
}

xi.chocoboRaising.getCutsceneWithOffset = function(player, cutscene)
    local cutsceneOffsets =
    {
        [xi.zone.SOUTHERN_SAN_DORIA] = xi.chocoboRaising.cutscenes.SANDORIA_OFFSET,
        [xi.zone.BASTOK_MINES]       = xi.chocoboRaising.cutscenes.BASTOK_OFFSET,
        [xi.zone.WINDURST_WOODS]     = xi.chocoboRaising.cutscenes.WINDURST_OFFSET,
    }

    return cutscene + cutsceneOffsets[player:getZoneID()]
end

-- These act as multipliers for adding per-rank bonuses to things.
-- F gives base + (0 * bonus)
-- SS gives base + (7 * bonus)
xi.chocoboRaising.skillRanks =
{
    F_POOR                = 0,
    E_SUBSTANDARD         = 1,
    D_A_BIT_DEFICIENT     = 2,
    C_AVERAGE             = 3,
    B_BETTER_THAN_AVERAGE = 4,
    A_IMPRESSIVE          = 5,
    S_OUTSTANDING         = 6,
    SS_FIRST_CLASS        = 7,
}

xi.chocoboRaising.skillRankBoundaries =
{
    F_POOR                = 31,
    E_SUBSTANDARD         = 63,
    D_A_BIT_DEFICIENT     = 95,
    C_AVERAGE             = 127,
    B_BETTER_THAN_AVERAGE = 159,
    A_IMPRESSIVE          = 191,
    S_OUTSTANDING         = 223,
    SS_FIRST_CLASS        = 255,
}

xi.chocoboRaising.numberToRank = function(skill)
    local rank = xi.chocoboRaising.skillRanks.F_POOR

    -- Since pairs isn't guaranteed to iterate in order, we have
    -- do check against ranks and see if things are greater than
    -- our best-found rank
    for idx, boundary in ipairs(xi.chocoboRaising.skillRankBoundaries) do
        if skill >= boundary and xi.chocoboRaising.skillRanks[idx] > rank then
            rank = xi.chocoboRaising.skillRanks[idx]
        end
    end

    return rank
end

xi.chocoboRaising.getPlayerRidingSpeedAndTime = function(player)
    local baseSpeed = xi.chocoboRaising.ridingSpeedBase
    local baseTime  = xi.chocoboRaising.ridingTimeBase

    -- TODO: This should be looking up your registered chocobo, not your
    --     : current raising chocobo.
    local chocoState = player:getChocoboRaisingInfo()

    if chocoState == nil then
        -- TODO: Log
        return baseSpeed, baseTime
    end

    local strRank  = xi.chocoboRaising.numberToRank(chocoState.strength)
    local endRank  = xi.chocoboRaising.numberToRank(chocoState.endurance)
    local outSpeed = utils.clamp(baseSpeed + (strRank * xi.chocoboRaising.ridingSpeedPerRank), 0, xi.chocoboRaising.ridingSpeedCap)
    local outTime  = utils.clamp(baseTime + (endRank * xi.chocoboRaising.ridingTimePerRank), 0, xi.chocoboRaising.ridingTimeCap)

    return outSpeed, outTime
end

-- NOTE: These are animation effects, so you can use warp etc.
xi.chocoboRaising.glow =
{
    NONE       = 0,
    WARP       = 80,
    RED        = 96,
    BLUE       = 97,
    YELLOW     = 98,
    GREEN      = 99,
    LIGHT_BLUE = 100,
}

xi.chocoboRaising.conditions =
{
    -- Negative
    ILL      = 0,
    VERY_ILL = 1,
    SICK     = 2,
    INJURED  = 3,
    SPOILED  = 4,
    BORED    = 5,
    LOVESICK = 6,
    RUN_AWAY = 7,

    -- Positive
    HIGH_SPIRITS       = 8,
    PERKY              = 9,
    EXTREMELY_HAPPY    = 10,
    FULL_OF_ENERGY_1   = 11,
    FULL_OF_ENERGY_2   = 12,
    BRIGHT_AND_FOCUSED = 13,
}

xi.chocoboRaising.hasCondition = function(chocoState)
    return chocoState.conditions > 0
end

xi.chocoboRaising.getCondition = function(chocoState, condition)
    return utils.mask.getBit(chocoState.conditions, condition)
end

xi.chocoboRaising.setCondition = function(chocoState, condition, value)
    chocoState.conditions = utils.mask.setBit(chocoState.conditions, condition, value)
end

xi.chocoboRaising.conditionsHealedByItems =
{
    [xi.chocoboRaising.conditions.ILL] =
    {
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.VERY_ILL] =
    {
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.SICK] =
    {
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.INJURED] =
    {
        xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.SPOILED] =
    {
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.BORED] =
    {
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.LOVESICK] =
    {
        xi.item.CELERITY_SALAD,
    },
}
utils.unused(xi.chocoboRaising.conditionsHealedByItems)

xi.chocoboRaising.carePlans =
{
    BASIC_CARE               = 0,
    RESTING                  = 1,
    TAKING_A_WALK            = 2,
    LISTENING_TO_MUSIC       = 3,
    EXERCISING_ALONE         = 4,
    EXCERCISING_IN_A_GROUP   = 5,
    PLAYING_WITH_CHILDREN    = 6,
    PLAYING_WITH_CHOCOBOS    = 7,
    CARRYING_PACKAGES        = 8,
    EXHIBITING_TO_THE_PUBLIC = 9,
    DELIVERING_MESSAGES      = 10,
    DIGGING_FOR_TREASURE     = 11,
    ACTING_IN_A_PLAY         = 12,
}

-- http://www.playonline.com/pcd/update/ff11us/20060822VOL2B1/table03en.jpg
-- minor: 1, moderate: 5, major: 10
-- strength, endurance, discernment, receptivity, affection, energy, payment
xi.chocoboRaising.carePlanData =
{
    [xi.chocoboRaising.carePlans.BASIC_CARE              ] = {  1,  1,  1,  1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.RESTING                 ] = {  0,  0,  0,  0,   0,   1, nil },
    [xi.chocoboRaising.carePlans.TAKING_A_WALK           ] = {  1,  1, -1, -1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.LISTENING_TO_MUSIC      ] = { -1, -1,  1,  1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.EXERCISING_ALONE        ] = {  1,  0, -1, -1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.EXCERCISING_IN_A_GROUP  ] = {  0,  1, -1, -1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.PLAYING_WITH_CHILDREN   ] = { -1, -1,  1,  0,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.PLAYING_WITH_CHOCOBOS   ] = { -1, -1,  0,  1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.CARRYING_PACKAGES       ] = {  5,  5, -5, -5, -10,  -5, 100 },
    [xi.chocoboRaising.carePlans.EXHIBITING_TO_THE_PUBLIC] = { -5, -5,  5,  5, -10,  -5, 100 },
    [xi.chocoboRaising.carePlans.DELIVERING_MESSAGES     ] = { 10,  0,  0, -5, -10, -10, 100 },
    [xi.chocoboRaising.carePlans.DIGGING_FOR_TREASURE    ] = {  0, -5, 10,  0, -10, -10, 100 },
    [xi.chocoboRaising.carePlans.ACTING_IN_A_PLAY        ] = { -5,  0,  0, 10, -10, -10, 100 },
}

xi.chocoboRaising.handleStatChange = function(stat, change, max)
    if change > 0 then
        change = change * xi.settings.main.CHOCOBO_RAISING_STAT_POS_MULTIPLIER
    elseif change < 0 then
        change = change * xi.settings.main.CHOCOBO_RAISING_STAT_NEG_MULTIPLIER
    end

    -- TODO: Enum for which stat is changing?
    -- TODO: Handle Green Racing Silks here for energy?
    -- https://ffxiclopedia.fandom.com/wiki/Green_Race_Silks

    stat = utils.clamp(stat + change, 0, max)

    return stat
end

xi.chocoboRaising.handleCarePlan = function(player, chocoState, carePlan)
    -- TODO: Take in a multiplier to account for merged time ranges

    chocoState.strength    = xi.chocoboRaising.handleStatChange(chocoState.strength   , xi.chocoboRaising.carePlanData[carePlan][1], 255)
    chocoState.endurance   = xi.chocoboRaising.handleStatChange(chocoState.endurance  , xi.chocoboRaising.carePlanData[carePlan][2], 255)
    chocoState.discernment = xi.chocoboRaising.handleStatChange(chocoState.discernment, xi.chocoboRaising.carePlanData[carePlan][3], 255)
    chocoState.receptivity = xi.chocoboRaising.handleStatChange(chocoState.receptivity, xi.chocoboRaising.carePlanData[carePlan][4], 255)
    chocoState.affection   = xi.chocoboRaising.handleStatChange(chocoState.affection  , xi.chocoboRaising.carePlanData[carePlan][5], 255)
    chocoState.energy      = xi.chocoboRaising.handleStatChange(chocoState.energy     , xi.chocoboRaising.carePlanData[carePlan][6], 100)

    local payment = xi.chocoboRaising.carePlanData[carePlan][7]

    if payment then
        payment = payment * xi.settings.main.CHOCOBO_RAISING_GIL_MULTIPLIER
        debug(string.format('Care Plan Payment: %d', payment))

        -- TODO: Handle payment
    end
end

-- TODO: Make sure stat changes are clamped 0-255!

xi.chocoboRaising.validFoods =
{
--  [itemId]                                = { hunger, affection, energy, strength, endurance, discernment, receptivity, randomAttribute, glow }
    [xi.item.BUNCH_OF_GYSAHL_GREENS]       = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.BUNCH_OF_SHARUG_GREENS]       = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.BUNCH_OF_AZOUPH_GREENS]       = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.CARROT_PASTE]                 = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.HERB_PASTE]                   = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.VEGETABLE_PASTE]              = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.WORM_PASTE]                   = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.VOMP_CARROT]                  = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.SAN_DORIAN_CARROT]            = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.ZEGHAM_CARROT]                = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.BLUE   },
    [xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS]  = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.CLUMP_OF_GARIDAV_WILDGRASS]   = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS] = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.CHOCOLIXIR]                   = { 50,  0, 100, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.HI_CHOCOLIXIR]                = { 25,  0, 100, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.CHOCOTONIC]                   = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.CUPID_WORM]                   = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.BLUE   },
    [xi.item.GREGARIOUS_WORM]              = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.PARASITE_WORM]                = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.BLUE   },
    [xi.item.TORNADO_SALAD]                = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.GREEN  },
    [xi.item.CELERITY_SALAD]               = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.GREEN  },
    [xi.item.LETHE_POTAGE]                 = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.GREEN  },
    [xi.item.LETHE_CONSOMME]               = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.GREEN  },
    [xi.item.LA_THEINE_MILLET]             = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.GREEN  },
--  [xi.item.SCROLL_OF_INSTANT_WARP]       = { 0, 0, 0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.WARP },
}

-- Items that can be found on a walk in a certain area
xi.chocoboRaising.walkItems =
{
    -- Short Walk: Sandoria
    [xi.zone.WEST_RONFAURE] =
    {
        xi.item.BEASTCOIN,
        xi.item.BRONZE_AXE,
        xi.item.RONFAURE_CHESTNUT,
        xi.item.FLINT_STONE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_MASK,
        xi.item.LITTLE_WORM,
        xi.item.PEBBLE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
    },
    -- Short Walk: Bastok
    [xi.zone.NORTH_GUSTABERG] =
    {
        xi.item.BEASTCOIN,
        xi.item.FLINT_STONE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_MASK,
        xi.item.LITTLE_WORM,
        xi.item.EAR_OF_MILLIONCORN,
        xi.item.PEBBLE,
        xi.item.QUADAV_BACKPLATE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
    },
    -- Short Walk: Windurst
    [xi.zone.EAST_SARUTABARUTA] =
    {
        xi.item.BEASTCOIN,
        xi.item.FLINT_STONE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_MASK,
        xi.item.GOBLIN_HELM,
        xi.item.LITTLE_WORM,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BOX_OF_TARUTARU_RICE,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
        xi.item.YAGUDO_BEAD_NECKLACE,
    },
    -- Medium Walk: Sandoria
    [xi.zone.LA_THEINE_PLATEAU] =
    {
        xi.item.BEASTCOIN,
        xi.item.CRAB_SHELL,
        xi.item.CUPID_WORM,
        xi.item.CHUNK_OF_DARKSTEEL_ORE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_ARMOR,
        xi.item.LILAC,
        xi.item.PEBBLE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.ZEGHAM_CARROT,
        xi.item.MYTHRIL_BEASTCOIN,
    },
    -- Medium Walk: Bastok
    [xi.zone.KONSCHTAT_HIGHLANDS] =
    {
        xi.item.BEASTCOIN,
        xi.item.CUPID_WORM,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_ARMOR,
        xi.item.GOBLIN_HELM,
        xi.item.PEBBLE,
        xi.item.CHUNK_OF_DARKSTEEL_ORE,
        xi.item.CHUNK_OF_PLATINUM_ORE,
        xi.item.RAIN_LILY,
        xi.item.SHEEP_TOOTH,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.VOMP_CARROT,
        xi.item.ZEGHAM_CARROT,
    },
    -- Medium Walk: Windurst
    [xi.zone.TAHRONGI_CANYON] =
    {
        xi.item.AMARYLLIS,
        xi.item.BEASTCOIN,
        xi.item.CHICKEN_BONE,
        xi.item.CUPID_WORM,
        xi.item.CHUNK_OF_DARKSTEEL_ORE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_ARMOR,
        xi.item.PEBBLE,
        xi.item.CHUNK_OF_PLATINUM_ORE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.VOMP_CARROT,
        xi.item.ZEGHAM_CARROT,
        xi.item.BAG_OF_TREE_CUTTINGS,
    },
    -- Long Walk: Sandoria
    [xi.zone.JUGNER_FOREST] =
    {
        xi.item.CHUNK_OF_ADAMAN_ORE,
        xi.item.GOBLIN_HELM,
        xi.item.GOLD_BEASTCOIN,
        xi.item.GREGARIOUS_WORM,
        xi.item.MYTHRIL_BEASTCOIN,
        xi.item.OLIVE_FLOWER,
        xi.item.CHUNK_OF_ORICHALCUM_ORE,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BAG_OF_TREE_CUTTINGS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
    },
    -- Long Walk: Bastok
    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        xi.item.CHUNK_OF_ADAMAN_ORE,
        xi.item.CATTLEYA,
        xi.item.GOBLIN_HELM,
        xi.item.GREGARIOUS_WORM,
        xi.item.MYTHRIL_BEASTCOIN,
        xi.item.CHUNK_OF_ORICHALCUM_ORE,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BAG_OF_TREE_CUTTINGS,
    },
    -- Long Walk: Windurst
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        xi.item.CHUNK_OF_ADAMAN_ORE,
        xi.item.CASABLANCA,
        xi.item.GOBLIN_HELM,
        xi.item.GOLD_BEASTCOIN,
        xi.item.GREGARIOUS_WORM,
        xi.item.MYTHRIL_BEASTCOIN,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BAG_OF_TREE_CUTTINGS,
        xi.item.CHUNK_OF_ORICHALCUM_ORE,
    },
}

xi.chocoboRaising.packStats1 = function(chocoState)
    return bit.lshift(chocoState.strength,  0) +
        bit.lshift(chocoState.endurance,    8) +
        bit.lshift(chocoState.discernment, 16) +
        bit.lshift(chocoState.receptivity, 24)
end

xi.chocoboRaising.packStats2 = function(chocoState)
    return bit.lshift(chocoState.affection,  0) +
        bit.lshift(chocoState.energy,        8) +
        bit.lshift(chocoState.satisfaction, 16)
end

xi.chocoboRaising.getWeatherInZone = function(zoneId)
    local zone = GetZone(zoneId)

    if not zone then
        print('ChocoboRaising: Failed to get Zone object for weather information. \
            Is the target zone on another executable?')
        return xi.weather.NONE
    end

    return zone:getWeather()
end

-- If stage = [1] and age >= [2], play CS: [3] and set stage to [4].
local ageBoundaries =
{
    { xi.chocoboRaising.stage.EGG,        xi.chocoboRaising.daysToChick,      xi.chocoboRaising.cutscenes.EGG_HATCHING,          xi.chocoboRaising.stage.CHICK },
    { xi.chocoboRaising.stage.CHICK,      xi.chocoboRaising.daysToAdolescent, xi.chocoboRaising.cutscenes.CHICK_TO_ADOLESCENT,   xi.chocoboRaising.stage.ADOLESCENT },
    { xi.chocoboRaising.stage.ADOLESCENT, xi.chocoboRaising.daysToAdult1,     xi.chocoboRaising.cutscenes.ADOLESCENT_TO_ADULT_1, xi.chocoboRaising.stage.ADULT_1 },
    { xi.chocoboRaising.stage.ADULT_1,    xi.chocoboRaising.daysToAdult2,     xi.chocoboRaising.cutscenes.ADULT_1_TO_ADULT_2,    xi.chocoboRaising.stage.ADULT_2 },
    { xi.chocoboRaising.stage.ADULT_2,    xi.chocoboRaising.daysToAdult3,     xi.chocoboRaising.cutscenes.ADULT_2_TO_ADULT_3,    xi.chocoboRaising.stage.ADULT_3 },
    { xi.chocoboRaising.stage.ADULT_3,    xi.chocoboRaising.daysToAdult4,     xi.chocoboRaising.cutscenes.ADULT_3_TO_ADULT_4,    xi.chocoboRaising.stage.ADULT_4 },
}

xi.chocoboRaising.ageToStage = function(age)
    for _, entry in ipairs(ageBoundaries) do
        if age <= entry[2] then
            return entry[1]
        end
    end

    return xi.chocoboRaising.stage.ADULT_4
end
