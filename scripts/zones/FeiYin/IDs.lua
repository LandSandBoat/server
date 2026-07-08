-----------------------------------
-- Area: FeiYin
-----------------------------------
zones = zones or {}

zones[xi.zone.FEIYIN] =
{
    text =
    {
        CONQUEST_BASE                      = 3,     -- Tallying conquest results...
        REGION_POINTS_SANDORIA             = 68,    -- San d'Oria's region points have increased!
        ITEM_CANNOT_BE_OBTAINED            = 6565,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                      = 6573,  -- Obtained: <item>.
        GIL_OBTAINED                       = 6574,  -- Obtained <number> gil.
        KEYITEM_OBTAINED                   = 6576,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY            = 6587,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING                = 6588,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET              = 6602,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS                = 7184,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY            = 7185,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                       = 7186,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED      = 7206,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET             = 7251,  -- You can't fish here.
        CHEST_UNLOCKED                     = 7383,  -- You unlock the chest!
        YOU_FIND_NOTHING                   = 7422,  -- You find nothing.
        EVIL_PRESENCE                      = 7423,  -- You feel a conspicuously evil presence.
        SOUL_OF_TAVNAZIA                   = 7424,  -- You are able to make out the blurred letters. The soul of Tavnazia will never perish.
        ITS_FINALLY_OVER                   = 7425,  -- It is finally...over... Ahh... I can... I can see... Tavnazia... The land of wind...and light... My... My home...!
        SOFTLY_SHIMMERING_LIGHT            = 7509,  -- You see a softly shimmering light...
        YOU_REACH_OUT_TO_THE_LIGHT         = 7510,  -- You reach out to the light, and one facet of a curious seed-shaped emblem materializes on the back of your hand. It emanates an otherworldly [red/orange/yellow/green/cerulean/blue/golden/silver/white] radiance.
        THE_LIGHT_DWINDLES                 = 7511,  -- However, the light dwindles and grows dim almost at once...
        EVEN_GREATER_INTENSITY             = 7512,  -- The emblem on your hand glows with even greater intensity!
        YOU_REACH_FOR_THE_LIGHT            = 7513,  -- You reach for the light, but there is no discernable effect...
        SCINTILLATING_BURST_OF_LIGHT       = 7514,  -- As you extend your hand, there is a scintillating burst of light! Now complete, the Mark of Seed glows with near-blinding intensity!
        MARK_OF_SEED_FLICKERS              = 7523,  -- The glow of the Mark of Seed flickers and dims ever so slightly...
        MARK_OF_SEED_GROWS_FAINTER         = 7524,  -- The Mark of Seed grows fainter still. Before long, it will fade away entirely...
        MARK_OF_SEED_IS_ABOUT_TO_DISSIPATE = 7525,  -- The Mark of Seed is about to dissipate entirely! Only a faint outline remains...
        MARK_OF_SEED_HAS_VANISHED          = 7526,  -- The Mark of Seed has vanished without a trace...
        PLAYER_OBTAINS_ITEM                = 7531,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM              = 7532,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM           = 7533,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP               = 7534,  -- You already possess that temporary item.
        NO_COMBINATION                     = 7539,  -- You were unable to enter a combination.
        REGIME_REGISTERED                  = 9617,  -- New training regime registered!
        LEARNS_SPELL                       = 10665, -- <name> learns <spell>!
        UNCANNY_SENSATION                  = 10667, -- You are assaulted by an uncanny sensation.
        HOMEPOINT_SET                      = 10716, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT       = 10774, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        MIND_HOARDER        = GetFirstID('Mind_Hoarder'),
        GOLIATH             = GetFirstID('Goliath'),
        NORTHERN_SHADOW     = GetFirstID('Northern_Shadow'),
        EASTERN_SHADOW      = GetFirstID('Eastern_Shadow'),
        SOUTHERN_SHADOW     = GetFirstID('Southern_Shadow'),
        WESTERN_SHADOW      = GetFirstID('Western_Shadow'),
        ALTEDOUR_I_TAVNAZIA = GetFirstID('Altedour_I_Tavnazia'),
        MISER_MURPHY        = GetFirstID('Miser_Murphy'),
        DABOTZS_GHOST       = GetFirstID('Dabotzs_Ghost'),
        CAPRICIOUS_CASSIE   = GetFirstID('Capricious_Cassie'),
    },
    npc =
    {
        AFTERGRLOW_OFFSET       = GetFirstID('Seed_Afterglow'),
        TREASURE_CHEST          = GetFirstID('Treasure_Chest'),
        UNDERGROUND_POOL_OFFSET = GetFirstID('Underground_Pool'),
    },
}

return zones[xi.zone.FEIYIN]
