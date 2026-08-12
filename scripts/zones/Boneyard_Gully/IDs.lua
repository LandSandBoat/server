-----------------------------------
-- Area: Boneyard_Gully
-----------------------------------
zones = zones or {}

zones[xi.zone.BONEYARD_GULLY] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7078, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7093, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7102, -- An ominous veil of pitch-black gas blocks your path. You cannot proceed any further...
        MEMBERS_OF_YOUR_PARTY         = 7384, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7385, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7387, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7388, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7389, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7423, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7430, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7447, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7610, -- Entering the battlefield for [Head Wind/Like the Wind/Sheep in Antlion's Clothing/Shell We Dance?/Totentanz/Tango with a Tracker/Requiem of Sin/Antagonistic Ambuscade/★Head Wind]!
        SHIKAREE_ENGAGE               = 7730, -- We are the Mithran Trackers! You will answer for your sins!
        SHIKAREE_Z_OFFSET             = 7731, -- H-how...is this possible...?
        FOLLOW_LEAD                   = 7733, -- Follow my lead!
        SHIKAREE_Y_OFFSET             = 7742, -- I...I can't have lost...
        READY_TO_REAP                 = 7743, -- Ready to rrrreap!
        LET_THE_MASSACRE_BEGIN        = 7744, -- Let the massacrrre begin!
        JUST_FOR_YOU_SUGARPLUM        = 7745, -- Just for you, sugarplum!
        IN_YOUR_EYE_HONEYCAKES        = 7746, -- In your eye, honeycakes!
        SHIKAREE_X_OFFSET             = 7753, -- Defeated...on my...first hunt...
        READY_TO_RUMBLE               = 7754, -- Ready to rrrumble!
        TIME_TO_HUNT                  = 7755, -- Mithran Trackers! Time to hunt!
        MY_TURN                       = 7756, -- My turn! My turn!
        YOURE_MINE                    = 7757, -- You're mine!
        TUCHULCHA_SANDPIT             = 7766, -- Tuchulcha retreats beneath the soil!
        BURSTS_INTO_FLAMES            = 7771, -- The <keyitem> suddenly bursts into flames, the blackened remains borne away by the wind...
        GET_YOUR_BLOOD_RACING         = 7821, -- I'll get your blood rrracing!
        SHIKAREE_Y_2HR                = 7823, -- Ah, the scent of frrresh blood!
        EVEN_AT_MY_BEST               = 7825, -- Even at my best...
        SHIKAREE_X_2HR                = 7826, -- Time to end the hunt! Go for the jugular!
        DINNER_TIME_ADVENTURER_STEAK  = 7827, -- Dinner time! Tonight we're having Adventurer Steak!
        SHIKAREE_ROS_ENGAGE           = 7828, -- Justice is the diamond that shines even after being shattered!
        SHIKAREE_PARTY_WIPE           = 7813, -- Have you been slacking off since you saved the world, sweetheart? Looks like your sense of justice needs a little dusting off.
    },

    mob =
    {
        PARATA             = GetFirstID('Parata'),
        SHIKAREE_Z_HW      = GetFirstID('Shikaree_Z_HW'),
        SHIKAREE_Y_HW      = GetFirstID('Shikaree_Y_HW'),
        SHIKAREE_X_HW      = GetFirstID('Shikaree_X_HW'),
        SHIKAREE_Z_ROS     = GetFirstID('Shikaree_Z_ROS'),
        SHIKAREE_Y_ROS_TWT = GetFirstID('Shikaree_Y_ROS_TWT'),
        SHIKAREE_X_ROS_TWT = GetFirstID('Shikaree_X_ROS_TWT'),
        TUCHULCHA          = GetFirstID('Tuchulcha'),
    },

    npc =
    {
    },
}

return zones[xi.zone.BONEYARD_GULLY]
