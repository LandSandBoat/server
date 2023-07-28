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
        AMALTHEIA_WRONG_TRADE         = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405, -- You are suddenly overcome with a sense of foreboding...
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
        AMALTHEIA_TRIGGER             = 7789, -- A message has been engraved into the rock: “Offer up the ancient shield, and the pact shall be honored.”
        AMALTHEIA_SPAWN1              = 7790, -- Very well, I shall test thy mettle...
        AMALTHEIA_SPAWN2              = 7791, -- I am Amaltheia the Omnipotent. My almighty horns shall seal thy fate this day!
        KURREA_TRIGGER                = 7793, -- The stench of rotten flesh fills the air around you. Some scavenger must have made this place its territory.
        KURREA_SPAWN                  = 7794, -- You set <number> <items> on the ground. The smell becomes almost unbearable. Suddenly, a huge creature approaches and starts sniffing around!
        KURREA_WRONG_TRADE            = 7795, -- Nothing happens.
        KURREA_SLURPS                 = 7796, -- Kurrea slurps down the adamantoise soup!
        KURREA_MUSCLES                = 7797, -- Kurrea's muscles bulge crazily!
        KURREA_SHINE                  = 7798, -- Kurrea's scales shine mysteriously!
        KURREA_WIND                   = 7799, -- Kurrea is enveloped by a fierce wind!
        KURREA_RIGID                  = 7800, -- Kurrea's hide grows rigid!
        KURREA_VEIN                   = 7801, -- The veins in Kurrea's head are popping out!
        KURREA_EYES                   = 7802, -- Kurrea's eyes glow weirdly!
        KURREA_CURE                   = 7803, -- Kurrea's wounds disappear!
        KURREA_AURA                   = 7804, -- Kurrea is surrounded by an ominous aura!
        KURREA_GREEN                  = 7805, -- Kurrea's face has turned green...
        COMMON_SENSE_SURVIVAL         = 8745, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 8809, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        PADFOOT =
        {
            16875552, -- !pos -43.689 0.487 -328.028
            16875578, -- !pos 260.445 -1.761 -27.862
            16875615, -- !pos 412.447 -0.057 -200.161
            16875703, -- !pos -378.950 -15.742 144.215
            16875748, -- !pos -141.523 -15.529 91.709
        },
        MEGALOBUGARD_PH =
        {
            [16875720] = 16875741, -- -137.168 -15.390 91.016
        },
        YALUN_EKE_PH =
        {
            [16875593] = 16875600, -- 236.418, -0.573, -118.742
            [16875604] = 16875600, -- 387.196, 0.060, -115.952
        },
        BITTER_PAST_MOBS =
        {
            16875775,
            16875776,
        },
        LESHY_OFFSET          = 16875754,
        COLORFUL_LESHY        = 16875762,
        SPLINTERSPINE_GRUKJUK = 16875774,
        KURREA                = 16875778,
        AMALTHEIA             = 16875779,
        SENGANN               = 16875690,
        YALUN_EKE             = 16875600,
        BAUMESEL              = 16875777,
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
