-----------------------------------
-- Area: Talacca_Cove
-----------------------------------
zones = zones or {}

zones[xi.zone.TALACCA_COVE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7072, -- You can't fish here.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7337, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7352, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7375, -- It appears as if something had been thrust into the rockface here...
        TESTIMONY_IS_TORN             = 7395, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7396, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7643, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7644, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7646, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7647, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7648, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7682, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7689, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        IMPERIAL_ORDER_BREAKS         = 7697, -- The <item> breaks!
        ENTERING_THE_BATTLEFIELD_FOR  = 7710, -- Entering the battlefield for [Call to Arms/Compliments to the Chef/Puppetmaster Blues/Breaking the Bonds of Fate/Legacy of the Lost/★Legacy of the Lost/An Imperial Heist]!
        YOU_CAN_NOW_BECOME_A_CORSAIR  = 7808, -- You can now become a corsair!
        NOBODY_COMES_TO_HELP          = 7859, -- Nobody comes to help. The Imp Bandsman looks dejected.
        HELP_HAS_ARRIVED              = 7860, -- Help has arrived!
        QULTADA_CARDS_DEALT           = 7861, -- The cards have been dealt. Now let us begin our little gamble of luck and skill.
        QULTADA_GO_EASY               = 7862, -- You need not go easy on me... I certainly will not go easy on you.
        QULTADA_QUICK_START           = 7863, -- Oho... That was a quick start.
        QULTADA_BETTER_LUCK           = 7864, -- You could not put a dent in my tricorne with attacks like that. Better luck next time.
        QULTADA_NOT_BAD               = 7865, -- Not bad...
        QULTADA_ANTE_UP               = 7866, -- Ante up!
        QULTADA_TRY_YOUR_LUCK         = 7867, -- Let's try your luck!
        QULTADA_GET_AWAY              = 7868, -- Think you can get away?
        QULTADA_BEHOLD                = 7869, -- Behold my trump card... Time for you to fold!
        QULTADA_TOO_BAD               = 7870, -- Too bad. I was hoping for a bit more excitement.
        QULTADA_LADY_DESTINY          = 7871, -- Does Lady Destiny smile upon you today? Or is it merely Fate's mocking grin? Now is the time to offer your prayers!
        QULTADA_LUCK_OF_CORSAIR       = 7872, -- The luck of the corsair is a wonderful thing!
        QULTADA_FIVE_ROLL             = 7873, -- Ha! Lady Luck, stay with me!
        QULTADA_AS_LUCK               = 7874, -- As luck would have it...
        QULTADA_DO_NOT_FAIL           = 7875, -- Luck, do not fail me again...
        QULTADA_CHIPS_ARE_DOWN        = 7876, -- Sometimes the chips are down...
        QULTADA_HEAT_UP               = 7877, -- Looks like things are beginning to heat up!
        YOUR_LEVEL_LIMIT_IS_NOW_75    = 7878, -- Your level limit is now 75.
    },
    mob =
    {
        GESSHO  = GetFirstID('Gessho'),
        QULTADA = GetFirstID('Qultada'),
        VALKENG = GetFirstID('Valkeng'),
    },
    npc =
    {
    },
}

return zones[xi.zone.TALACCA_COVE]
