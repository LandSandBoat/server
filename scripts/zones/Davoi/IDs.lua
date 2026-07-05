-----------------------------------
-- Area: Davoi
-----------------------------------
zones = zones or {}

zones[xi.zone.DAVOI] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        NOT_ENOUGH_GIL                = 6399, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6403, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6408, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6423, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072, -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7137, -- San d'Oria's region points have increased!
        FISHING_MESSAGE_OFFSET        = 7231, -- You can't fish here.
        CAVE_HAS_BEEN_SEALED_OFF      = 7376, -- The cave has been sealed off by some sort of barrier.
        MAY_BE_SOME_WAY_TO_BREAK      = 7377, -- There may be some way to break through.
        POWER_OF_THE_ORB_ALLOW_PASS   = 7379, -- The disruptive power of the orb allows passage through the barrier.
        COLOR_OF_BLOOD                = 7380, -- This pool is the color of blood.
        ORB_QUEST_OFFSET              = 7382, -- You carefully dip the orb into the pool.
        QUEMARICOND_CAME_THIS_WAY     = 7396, -- I'm sure I came in through this way...
        QUEMARICOND_OVER_THERE        = 7397, -- Oh, wait. Maybe it was over there...
        QUEMARICOND_LOST              = 7398, -- I can't believe I've lost my way! They must have used an Orcish spell to change the terrain! Yes, that must be it!
        QUEMARICOND_DIALOG            = 7399, -- Er, sorry, no time to chat. I'm rather busy.
        YOU_SEE_NOTHING               = 7432, -- There is nothing here.
        YOU_FIND_NOTHING              = 7451, -- You find nothing.
        FIND_ORC_TENT                 = 7469, -- You find an Orcish tent.
        CLOSER_TO_SEARCH              = 7473, -- You must get closer to search the tent.
        AN_ORCISH_STORAGE_HOLE        = 7474, -- An Orcish storage hole. There is something inside, but you cannot open it without a key.
        A_WELL                        = 7476, -- A well, presumably dug by Orcs.
        CHEST_UNLOCKED                = 7495, -- You unlock the chest!
        WHERE_THE_TONBERRY_TOLD_YOU   = 7944, -- This is where the Tonberry from Carpenters' Landing told you to bring the <item>...
        NOTHING_TO_DO                 = 7945, -- You have nothing left to do here.
        UNDER_ATTACK                  = 7947, -- You are under attack!
        LEARNS_SPELL                  = 7987, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 7989, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 7996, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        HAWKEYED_DNATBAT    = GetFirstID('Hawkeyed_Dnatbat'),
        STEELBITER_GUDRUD   = GetFirstID('Steelbiter_Gudrud'),
        TIGERBANE_BAKDAK    = GetFirstID('Tigerbane_Bakdak'),
        POISONHAND_GNADGAD  = GetFirstID('Poisonhand_Gnadgad'),
        BLUBBERY_BULGE      = GetFirstID('Blubbery_Bulge'),
        GAVOTVUT            = GetFirstID('Gavotvut'),
        BARAKBOK            = GetFirstID('Barakbok'),
        BILOPDOP            = GetFirstID('Bilopdop'),
        DELOKNOK            = GetFirstID('Deloknok'),
        PURPLEFLASH_BRUKDOK = GetFirstID('Purpleflash_Brukdok'),
        ONE_EYED_GWAJBOJ    = GetFirstID('One-eyed_Gwajboj'),
        THREE_EYED_PROZPUZ  = GetFirstID('Three-eyed_Prozpuz'),
        HEMATIC_CYST        = GetFirstID('Hematic_Cyst'),
    },
    npc =
    {
        JAR              = GetFirstID('Jar'),
        HIDE_FLAP_OFFSET = GetFirstID('Hide_Flap_1'),
        STORAGE_HOLE     = GetFirstID('Storage_Hole'),
        TREASURE_CHEST   = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.DAVOI]
