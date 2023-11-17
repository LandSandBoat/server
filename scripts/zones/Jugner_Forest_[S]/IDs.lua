-----------------------------------
-- Area: Jugner_Forest_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.JUGNER_FOREST_S] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        LOGGING_IS_POSSIBLE_HERE      = 7081, -- Logging is possible here if you have <item>.
        YOU_FIND_NOTHING_ORDINARY     = 7121, -- You find nothing out of the ordinary.
        FISHING_MESSAGE_OFFSET        = 7374, -- You can't fish here.
        ALREADY_OBTAINED_TELE         = 7710, -- You already possess the gate crystal for this telepoint.
        YOU_FIND_SPARKLING_STONE      = 7728, -- You find a sparkling stone.
        ELEGANT_FOOTPRINTS            = 8403, -- You see numerous sets of elegant footprints.
        LILISETTE_IS_PREPARING        = 8404, -- Lilisette is preparing a new trap in an attempt to catch the ever-elusive Cait Sith. Bring her <item> to use as bait.
        IDEAL_PLACE_TO_PLANT_ITEM     = 8533, -- This seems to be an ideal place to plant <item>.
        YOU_PLANT_ITEM                = 8534, -- You plant <item>.
        ITEM_IS_PLANTED_HERE          = 8535, -- <item> has been planted here...
        NO_RESPONSE                   = 8539, -- There is no response...
        VOIDWALKER_DESPAWN            = 8562, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_NO_MOB             = 8609, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 8610, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 8611, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 8612, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 8614, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 8615, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 8616, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 8617, -- Obtained key item: <keyitem>!
        GATHERED_DAWNDROPS_LIGHT      = 8637, -- The gathered dawndrops unleash a brilliant light, melding together to form <keyitem>!
        RETRACED_ALL_JUNCTIONS        = 8638, -- You have retraced all junctions of eventualities. Hasten back to where Cait Sith and Lilisette await.
        COMMON_SENSE_SURVIVAL         = 9512, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        DRUMSKULL_ZOGDREGG_PH =
        {
            [17113380] = 17113381, -- 195.578 -0.556 -347.699
        },

        FINGERFILCHER_DRADZAD = 17113462,
        COBRACLAW_BUCHZVOTCH  = 17113464,

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17113500, -- Sunderclaw
                17113499, -- Sunderclaw
                17113498, -- Sunderclaw
                17113497, -- Sunderclaw
                17113496, -- Quagmire Pugil
                17113495, -- Quagmire Pugil
                17113494, -- Quagmire Pugil
                17113493, -- Quagmire Pugil
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17113492, -- Capricornus
                17113491, -- Yacumama
            },

            [xi.keyItem.BLUE_ABYSSITE] =
            {
                17113490, -- Krabkatoa
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17113489, -- Yilbegan
            }
        },
    },

    npc =
    {
        LOGGING = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.JUGNER_FOREST_S]
