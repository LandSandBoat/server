-----------------------------------
-- Area: Qulun_Dome
-----------------------------------
zones = zones or {}

zones[xi.zone.QULUN_DOME] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED                 = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                           = 6390, -- Obtained: <item>.
        GIL_OBTAINED                            = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED                        = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY                 = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS                     = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY                 = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                            = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED           = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                           = 7064, -- Tallying conquest results...
        IT_SEEMS_TO_BE_LOCKED_BY_POWERFUL_MAGIC = 7223, -- A door... It seems to be locked by powerful magic.
        THE_3_ITEMS_GLOW_FAINTLY                = 7224, -- The <item>, <item>, and <item> glow faintly.
        CANNOT_BE_OPENED_FROM_THIS_SIDE         = 7228, -- It cannot be opened from this side!
        THE_MAGICITE_GLOWS_OMINOUSLY            = 7266, -- The magicite glows ominously.
        YOU_FIND_NOTHING                        = 7267, -- You find nothing.
        DIAMOND_QUADAV_ENGAGE                   = 7268, -- Gwa-ha-ha, puny peoples! Ou-ur king never forge-ets a gru-udge. He'll gri-ind you into pa-aste!
        DIAMOND_QUADAV_DEATH                    = 7269, -- Glo-ory to the Adamantking!
        QUADAV_KING_ENGAGE                      = 7270, -- Childre-en of Altana? I will ba-athe in your blood as I did at the Ba-attle of Jeuno!
        QUADAV_KING_DEATH                       = 7271, -- I a-am fini-ished. Hear me, wa-arriors of the Quadav! The throne of the Adamantking and the line of Za'Dha pa-asses to my bro-other...
    },
    mob =
    {
        DIAMOND_QUADAV             = GetFirstID('Diamond_Quadav'), -- Also used for An Affable Adamantking? offset
    },
    npc =
    {
    },
}

return zones[xi.zone.QULUN_DOME]
