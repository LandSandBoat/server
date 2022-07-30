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
        ITEM_CANNOT_BE_OBTAINED  = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6390, -- Obtained: <item>.
        GIL_OBTAINED             = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6394, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6404, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7057, -- Tallying conquest results...
        CONQUEST                 = 7225, -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET   = 7559, -- You can't fish here.
        KI_STOLEN                = 7688, -- The <keyitem> has been stolen!
        LOGGING_IS_POSSIBLE_HERE = 7736, -- Logging is possible here if you have <item>.
        SURVEY_THE_SURROUNDINGS  = 7743, -- You survey the surroundings but see nothing out of the ordinary.
        MURDEROUS_PRESENCE       = 7744, -- Wait, you sense a murderous presence...!
        YOU_CAN_SEE_FOR_MALMS    = 7745, -- You can see for malms in every direction.
        SPINE_CHILLING_PRESENCE  = 7747, -- You sense a spine-chilling presence!
        AMALTHEIA_TRIGGER        = 7786, -- A message has been engraved into the rock: “Offer up the ancient shield, and the pact shall be honored.”
        AMALTHEIA_SPAWN1         = 7787, -- Very well, I shall test thy mettle...
        AMALTHEIA_SPAWN2         = 7788, -- I am Amaltheia the Omnipotent. My almighty horns shall seal thy fate this day!
        AMALTHEIA_WRONG_TRADE    = 7789, -- Nothing happens...
        KURREA_TRIGGER           = 7790, -- The stench of rotten flesh fills the air around you. Some scavenger must have made this place its territory.
        KURREA_SPAWN             = 7791, -- You set <number> <items> on the ground. The smell becomes almost unbearable. Suddenly, a huge creature approaches and starts sniffing around!
        KURREA_WRONG_TRADE       = 7792, -- Nothing happens.
        KURREA_SLURPS            = 7793, -- Kurrea slurps down the adamantoise soup!
        KURREA_MUSCLES           = 7794, -- Kurrea's muscles bulge crazily!
        KURREA_SHINE             = 7795, -- Kurrea's scales shine mysteriously!
        KURREA_WIND              = 7796, -- Kurrea is enveloped by a fierce wind!
        KURREA_RIGID             = 7797, -- Kurrea's hide grows rigid!
        KURREA_VEIN              = 7798, -- The veins in Kurrea's head are popping out!
        KURREA_EYES              = 7799, -- Kurrea's eyes glow weirdly!
        KURREA_CURE              = 7800, -- Kurrea's wounds disappear!
        KURREA_AURA              = 7801, -- Kurrea is surrounded by an ominous aura!
        KURREA_GREEN             = 7802, -- Kurrea's face has turned green...
        COMMON_SENSE_SURVIVAL    = 8742, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        YALUN_EKE_PH          =
        {
            [16875593] = 16875600, -- 236.418, -0.573, -118.742
            [16875604] = 16875600, -- 387.196, 0.060, -115.952
        },
        LESHY_OFFSET          = 16875754,
        COLORFUL_LESHY        = 16875762,
        SPLINTERSPINE_GRUKJUK = 16875774,
        KURREA                = 16875778,
        AMALTHEIA             = 16875779,
        SENGANN               = 16875690,
        YALUN_EKE             = 16875600,
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
