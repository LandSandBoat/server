-----------------------------------
-- Area: Lufaise_Meadows
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.LUFAISE_MEADOWS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        CONQUEST                      = 7228, -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7562, -- You can't fish here.
        KI_STOLEN                     = 7691, -- The <keyitem> has been stolen!
        LOGGING_IS_POSSIBLE_HERE      = 7739, -- Logging is possible here if you have <item>.
        SURVEY_THE_SURROUNDINGS       = 7746, -- You survey the surroundings but see nothing out of the ordinary.
        MURDEROUS_PRESENCE            = 7747, -- Wait, you sense a murderous presence...!
        YOU_CAN_SEE_FOR_MALMS         = 7748, -- You can see for malms in every direction.
        SPINE_CHILLING_PRESENCE       = 7750, -- You sense a spine-chilling presence!
        KURREA_TEXT                   = 7793, -- The stench of rotten flesh fills the air around you. Some scavenger must have made this place its territory.
        COMMON_SENSE_SURVIVAL         = 8745, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 8809, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        PADFOOT               =
        {
            16875552, -- !pos -43.689 0.487 -328.028
            16875578, -- !pos 260.445 -1.761 -27.862
            16875615, -- !pos 412.447 -0.057 -200.161
            16875703, -- !pos -378.950 -15.742 144.215
            16875748, -- !pos -141.523 -15.529 91.709
        },
        MEGALOBUGARD_PH       =
        {
            [16875720] = 16875741, -- -137.168 -15.390 91.016
        },
        LESHY_OFFSET          = 16875754,
        COLORFUL_LESHY        = 16875762,
        SPLINTERSPINE_GRUKJUK = 16875774,
        KURREA                = 16875778,
        AMALTHEIA             = 16875779,
    },
    npc =
    {
        OVERSEER_BASE = 16875865, -- Jemmoquel_RK in npc_list
        LOGGING       =
        {
            16875883,
            16875884,
            16875885,
            16875886,
            16875887,
            16875888,
        },
    },
}

return zones[xi.zone.LUFAISE_MEADOWS]
