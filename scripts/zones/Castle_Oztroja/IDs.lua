-----------------------------------
-- Area: Castle_Oztroja
-----------------------------------
zones = zones or {}

zones[xi.zone.CASTLE_OZTROJA] =
{
    text =
    {
        CANNOT_REACH_TARGET                = 0,    -- Cannot reach target.
        ITS_LOCKED                         = 1,    -- It's locked.
        PROBABLY_WORKS_WITH_SOMETHING_ELSE = 3,    -- It probably works with something else.
        TORCH_LIT                          = 5,    -- The torch is lit.
        INCORRECT                          = 11,   -- Incorrect.
        FIRST_WORD                         = 12,   -- The first word.
        SECOND_WORD                        = 13,   -- The second word.
        THIRD_WORD                         = 14,   -- The third word.
        CONQUEST_BASE                      = 26,   -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED            = 6570, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE         = 6574, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                      = 6576, -- Obtained: <item>.
        GIL_OBTAINED                       = 6577, -- Obtained <number> gil.
        KEYITEM_OBTAINED                   = 6579, -- Obtained key item: <keyitem>.
        NOT_ENOUGH_GIL                     = 6581, -- You do not have enough gil.
        ITEMS_OBTAINED                     = 6585, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY            = 6590, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING                = 6591, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET              = 6605, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS                = 7187, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY            = 7188, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                       = 7189, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED      = 7209, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET             = 7272, -- You can't fish here.
        CHEST_UNLOCKED                     = 7443, -- You unlock the chest!
        TEBHI_ACCEPTS                      = 7454, -- Tebhi happily accepts the <item> and leaves.
        YAGUDO_AVATAR_ENGAGE               = 7464, -- Kahk-ka-ka... You filthy, dim-witted heretics! You have damned yourselves by coming here.
        YAGUDO_AVATAR_DEATH                = 7465, -- Our lord, Tzee Xicu the Manifest!  Even should our bodies be crushed and broken, may our souls endure into eternity...
        YAGUDO_KING_ENGAGE                 = 7466, -- You are not here as sacrifices, are you? Could you possibly be committing this affront in the face of a deity?  Very well, I will personally mete out your divine punishment, kyah!
        YAGUDO_KING_DEATH                  = 7467, -- You have...bested me... However, I...am...a god... I will never die...never rot...never fade...never...
        HERETICS                           = 8012, -- Kyah! Kyah! Heretics being in our midst! Kill them!
        LETTING_YOU_GO                     = 8019, -- This time I be letting you go. Be flying home, smoothskin! Ka-kyah!
        LEARNS_SPELL                       = 8308, -- <name> learns <spell>!
        UNCANNY_SENSATION                  = 8310, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL              = 8317, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        MEE_DEGGI_THE_PUNISHER  = GetFirstID('Mee_Deggi_the_Punisher'),
        MOO_OUZI_THE_SWIFTBLADE = GetFirstID('Moo_Ouzi_the_Swiftblade'),
        QUU_DOMI_THE_GALLANT    = GetFirstID('Quu_Domi_the_Gallant'),
        YAA_HAQA_THE_PROFANE    = GetFirstID('Yaa_Haqa_the_Profane'),
        YAGUDO_AVATAR           = GetFirstID('Yagudo_Avatar'),
        HUU_XALMO_THE_SAVAGE    = GetFirstID('Huu_Xalmo_the_Savage'),
        MIMIC                   = GetFirstID('Mimic'),
    },
    npc =
    {
        HANDLE_DOOR_FLOOR_2    = GetFirstID('_471'),
        FIRST_PASSWORD_STATUE  = GetTableOfIDs('Brass_Statue')[1],
        SECOND_PASSWORD_STATUE = GetTableOfIDs('Brass_Statue')[3], -- This is intentional.
        THIRD_PASSWORD_STATUE  = GetTableOfIDs('Brass_Statue')[2], -- This is intentional.
        FINAL_PASSWORD_STATUE  = GetTableOfIDs('Brass_Statue')[4],
        BRASS_DOOR_FLOOR_4_H7  = GetFirstID('_477'),
        TRAP_DOOR_FLOOR_4      = GetFirstID('_478'),
        HINT_HANDLE_OFFSET     = GetFirstID('_47q'),
        TREASURE_CHEST         = GetFirstID('Treasure_Chest'),
        TREASURE_COFFER        = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.CASTLE_OZTROJA]
