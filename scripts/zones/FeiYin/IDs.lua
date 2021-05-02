-----------------------------------
-- Area: FeiYin
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.FEIYIN] =
{
    text =
    {
        CONQUEST_BASE                      = 3,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED            = 6562,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                      = 6568,  -- Obtained: <item>.
        GIL_OBTAINED                       = 6569,  -- Obtained <number> gil.
        KEYITEM_OBTAINED                   = 6571,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY            = 6582,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING                = 6583,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET              = 6597,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS                = 7179, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY            = 7180, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                       = 7181, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET             = 7229,  -- You can't fish here.
        CHEST_UNLOCKED                     = 7360,  -- You unlock the chest!
        SOFTLY_SHIMMERING_LIGHT            = 7486,  -- You see a softly shimmering light...
        YOU_REACH_OUT_TO_THE_LIGHT         = 7487,  -- You reach out to the light, and one facet of a curious seed-shaped emblem materializes on the back of your hand. It emanates an otherworldly [red/orange/yellow/green/cerulean/blue/golden/silver/white] radiance.
        THE_LIGHT_DWINDLES                 = 7488,  -- However, the light dwindles and grows dim almost at once...
        EVEN_GREATER_INTENSITY             = 7489,  -- The emblem on your hand glows with even greater intensity!
        YOU_REACH_FOR_THE_LIGHT            = 7490,  -- You reach for the light, but there is no discernable effect...
        SCINTILLATING_BURST_OF_LIGHT       = 7491,  -- As you extend your hand, there is a scintillating burst of light! Now complete, the Mark of Seed glows with near-blinding intensity!
        MARK_OF_SEED_FLICKERS              = 7500,  -- The glow of the Mark of Seed flickers and dims ever so slightly...
        MARK_OF_SEED_GROWS_FAINTER         = 7501,  -- The Mark of Seed grows fainter still. Before long, it will fade away entirely...
        MARK_OF_SEED_IS_ABOUT_TO_DISSIPATE = 7502,  -- The Mark of Seed is about to dissipate entirely! Only a faint outline remains...
        MARK_OF_SEED_HAS_VANISHED          = 7503,  -- The Mark of Seed has vanished without a trace...
        PLAYER_OBTAINS_ITEM                = 7508,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM              = 7509,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM           = 7510,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP               = 7511,  -- You already possess that temporary item.
        NO_COMBINATION                     = 7516,  -- You were unable to enter a combination.
        REGIME_REGISTERED                  = 9594,  -- New training regime registered!
        HOMEPOINT_SET                      = 10693, -- Home point set!
    },
    mob =
    {
        MIND_HOARDER_PH =
        {
            [17612856] = 17612859,
            [17612857] = 17612859,
            [17612858] = 17612859,
        },
        GOLIATH_PH  =
        {
            [17613052] = 17613045,
        },
        NORTHERN_SHADOW_PH  =
        {
            [17613098] = 17613102, -- -159.000 -16.000 146.000
        },
        EASTERN_SHADOW_PH   =
        {
            [17613107] = 17613109, -- -86.000 -15.000 152.000
        },
        SOUTHERN_SHADOW_PH  =
        {
            [17613117] = 17613120, -- -169.000 -16.000 87.000
        },
        WESTERN_SHADOW_PH   =
        {
            [17613094] = 17613095, -- -204.000 -15.000 118.000
        },
        ALTEDOUR_I_TAVNAZIA = 17612836,
        MISER_MURPHY        = 17612849,
        DABOTZS_GHOST       = 17613128,
        CAPRICIOUS_CASSIE   = 17613129,
    },
    npc =
    {
        AFTERGRLOW_OFFSET       = 17613147,
        CASKET_BASE             = 17613156,
        TREASURE_CHEST          = 17613241,
        UNDERGROUND_POOL_OFFSET = 17613246,
    },
}

return zones[xi.zone.FEIYIN]
