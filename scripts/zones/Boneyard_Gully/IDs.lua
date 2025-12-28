-----------------------------------
-- Area: Boneyard_Gully
-----------------------------------
zones = zones or {}

zones[xi.zone.BONEYARD_GULLY] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7073, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7088, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7097, -- An ominous veil of pitch-black gas blocks your path. You cannot proceed any further...
        MEMBERS_OF_YOUR_PARTY         = 7379, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7380, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7382, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7383, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7384, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7418, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7425, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7442, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7605, -- Entering the battlefield for [Head Wind/Like the Wind/Sheep in Antlion's Clothing/Shell We Dance?/Totentanz/Tango with a Tracker/Requiem of Sin/Antagonistic Ambuscade/Head Wind]!
        SHIKAREE_ENGAGE               = 7725, -- We are the Mithran Trackers! You will answer for your sins!
        SHIKAREE_Z_OFFSET             = 7726, -- H-how...is this possible...?
        FOLLOW_LEAD                   = 7728, -- Follow my lead!
        SHIKAREE_Y_OFFSET             = 7737, -- I...I can't have lost...
        READY_TO_REAP                 = 7738, -- Ready to rrrreap!
        LET_THE_MASSACRE_BEGIN        = 7739, -- Let the massacrrre begin!
        JUST_FOR_YOU_SUGARPLUM        = 7740, -- Just for you, sugarplum!
        IN_YOUR_EYE_HONEYCAKES        = 7741, -- In your eye, honeycakes!
        SHIKAREE_X_OFFSET             = 7748, -- Defeated...on my...first hunt...
        READY_TO_RUMBLE               = 7749, -- Ready to rrrumble!
        TIME_TO_HUNT                  = 7750, -- Mithran Trackers! Time to hunt!
        MY_TURN                       = 7751, -- My turn! My turn!
        YOURE_MINE                    = 7752, -- You're mine!
        TUCHULCHA_SANDPIT             = 7761, -- Tuchulcha retreats beneath the soil!
        BURSTS_INTO_FLAMES            = 7766, -- The <keyitem> suddenly bursts into flames, the blackened remains borne away by the wind...
        GET_YOUR_BLOOD_RACING         = 7816, -- I'll get your blood rrracing!
        SHIKAREE_Y_2HR                = 7818, -- Ah, the scent of frrresh blood!
        EVEN_AT_MY_BEST               = 7820, -- Even at my best...
        SHIKAREE_X_2HR                = 7821, -- Time to end the hunt! Go for the jugular!
        DINNER_TIME_ADVENTURER_STEAK  = 7822, -- Dinner time! Tonight we're having Adventurer Steak!
    },

    mob =
    {
        PARATA         = GetFirstID('Parata'),
        SHIKAREE_Z_HW  = GetFirstID('Shikaree_Z_HW'),
        SHIKAREE_Y_HW  = GetFirstID('Shikaree_Y_HW'),
        SHIKAREE_X_HW  = GetFirstID('Shikaree_X_HW'),
        SHIKAREE_Z_ROS = GetFirstID('Shikaree_Z_ROS'),
        TUCHULCHA      = GetFirstID('Tuchulcha'),
    },

    npc =
    {
    },
}

return zones[xi.zone.BONEYARD_GULLY]
