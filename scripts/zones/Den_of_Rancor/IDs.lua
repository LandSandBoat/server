-----------------------------------
-- Area: Den_of_Rancor
-----------------------------------
zones = zones or {}

zones[xi.zone.DEN_OF_RANCOR] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6409,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6424,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7073,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7138,  -- San d'Oria's region points have increased!
        LANTERN_OFFSET                = 7232,  -- The grating will not budge.
        LANTERN_ALREADY_LIT           = 7239,  -- The lantern is already lit.
        RUSTY_OLD_LANTERN             = 7246,  -- Rusty old lanterns hang from this altar.
        ONE_OF_THE_LANTERNS           = 7247,  -- One of the lanterns is lit.
        TANSFORMED_INTO_A_MONSTER     = 7251,  -- The flames of rancor have transformed into a monster!
        FISHING_MESSAGE_OFFSET        = 7260,  -- You can't fish here.
        CHEST_UNLOCKED                = 7369,  -- You unlock the chest!
        FIVE_DRIED_EYEBALLS           = 7377,  -- Five dried eyeballs are stuck to the surface of the rock...
        SENSE_OMINOUS_PRESENCE        = 7379,  -- You sense an ominous presence...
        PLAYER_OBTAINS_ITEM           = 7426,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7427,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7428,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7429,  -- You already possess that temporary item.
        NO_COMBINATION                = 7434,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9512,  -- New training regime registered!
        HOMEPOINT_SET                 = 10562, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 10620, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        AZRAEL                  = GetFirstID('Azrael'),
        BISTRE_HEARTED_MALBERRY = GetFirstID('Bistre-hearted_Malberry'),
        CARMINE_TAILED_JANBERRY = GetFirstID('Carmine-tailed_Janberry'),
        CELESTE_EYED_TOZBERRY   = GetFirstID('Celeste-eyed_Tozberry'),
        FRIAR_RUSH              = GetFirstID('Friar_Rush'),
        HAKUTAKU                = GetFirstID('Hakutaku'),
        MIMIC                   = GetFirstID('Mimic'),
        MOKUMOKUREN             = GetFirstID('Mokumokuren'),
        OGAMA                   = GetFirstID('Ogama'),
        RANCOR_TORCH            = GetFirstID('Rancor_Torch'),
        TAWNY_FINGERED_MUGBERRY = GetFirstID('Tawny-fingered_Mugberry'),
    },
    npc =
    {
        DROP_GATE       = GetFirstID('_4g0'),
        LANTERN_OFFSET  = GetFirstID('_4g3'),
        TREASURE_COFFER = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.DEN_OF_RANCOR]
