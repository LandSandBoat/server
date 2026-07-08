-----------------------------------
-- Area: Jade_Sepulcher
-----------------------------------
zones = zones or {}

zones[xi.zone.JADE_SEPULCHER] =
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
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7337, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7352, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7376, -- A decorative door. It appears to be locked...
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
        ENTERING_THE_BATTLEFIELD_FOR  = 7710, -- Entering the battlefield for [Making a Mockery/Shadows of the Mind/The Beast Within/Moment of Truth/Puppet in Peril/★Puppet in Peril/Tateeya's Worries/An Imperial Heist]!
        RAUBAHN_COME_SURRENDER        = 7754, -- Come, surrender your strength to me and serve the Empire in death!
        RAUBAHN_YOUR_SOUL             = 7755, -- Your soul will be devoured by the power you seek... Serve the Empire to the last by joining your strength to mine!
        RAUBAHN_BEAST_OF_AMBITION     = 7756, -- The beast of ambition has slain you... Rest now in eternal slumber.
        RAUBAHN_STRENGTH_FAILED_ME    = 7757, -- My strength has failed me...
        RAUBAHN_OUR_ARSENAL           = 7758, -- Blue magic is but one part of our arsenal. A fact you will soon learn...
        RAUBAHN_SHOW_ME               = 7759, -- Show me! Show me the power that lurks within you!
        RAUBAHN_BE_BURIED             = 7760, -- You will be buried in the shadow of forgotten history!
        RAUBAHN_AZURE_SAVEGERY        = 7761, -- Now you will bear the full torrent of my azure savagery!
        RAUBAHN_IT_IS_OVER            = 7762, -- It is over. You have no strength left to resist me. Surrender to your fate!
        RAUBAHN_GREATER_POWER         = 7763, -- Hahaha... The greater the power you wield, the greater my strength will be when I devour your essence...!
        YOUR_LEVEL_LIMIT_IS_NOW_75    = 7764, -- Your level limit is now 75.
    },
    mob =
    {
        LANCELORD_GAHEEL_JA  = GetFirstID('Lancelord_Gaheel_Ja'),
        RAUBAHN              = GetFirstID('Raubahn'),
        SHADOWHAND_KAJEEL_JA = GetFirstID('Shadowhand_Kajeel_Ja'),
    },
    npc =
    {
    },
}

return zones[xi.zone.JADE_SEPULCHER]
