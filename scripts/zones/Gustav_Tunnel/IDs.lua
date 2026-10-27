-----------------------------------
-- Area: Gustav Tunnel (212)
-----------------------------------
zones = zones or {}

zones[xi.zone.GUSTAV_TUNNEL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED        = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6398,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6399,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY        = 6409,  -- There is nothing out of the ordinary here.
        NOT_THE_TIME_FOR_THAT          = 6411,  -- Now is not the time for that!
        FELLOW_MESSAGE_OFFSET          = 6424,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED           = 7017,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                  = 7073,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET         = 7232,  -- You can't fish here.
        BAD_FEELING_ABOUT_PLACE        = 7333,  -- You have a bad feeling about this place.
        SENSE_OMINOUS_PRESENCE         = 7335,  -- You sense an ominous presence...
        RESTLESS_FOOTPRINTS            = 7397,  -- You see several sets of restless footprints about the outcropping.
        TIME_TO_COMPLETE_BATTLE        = 7421,  -- You have <number> minutes (Earth time) to complete the battle.
        TIME_REMAINING_BATTLE          = 7422,  -- You have <number> minutes (Earth time) remaining to complete the battle.
        UNITY_WANTED_BATTLE_INTERACT   = 7456,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        RENFRED_NOT_INTERESTED         = 7514,  -- We don't know what you're doing here, but truth be told, we're not really interested.
        RENFRED_PUTTING_UP_A_FIGHT     = 7515,  -- Putting up a fight, eh? Gorattz! Bompupu! Show her what the Tenshodo thinks of meddlesome adventurers!
        RENFRED_OVER_MY_HEAD           = 7516,  -- D-damn... I'm in way over my head...
        GORATTZ_TOUGHER_THAN_SHE_LOOKS = 7517,  -- Ugh... She's tougher than she looks...
        BOMPUPU_DIDNT_SIGN_UP          = 7518,  -- Waaah! I didn't signy-wign up for this...
        SHADOW_IMAGE_DISAPPEARS        = 7519,  -- <name>'s shadow image disappears...
        OPPONENTS_DISAPPEAR            = 7548,  -- Your opponents deem you too weak to be worthwhile, disappearing whence they came.
        REGIME_REGISTERED              = 9603,  -- New training regime registered!
        PLAYER_OBTAINS_ITEM            = 10655, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 10656, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 10657, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 10658, -- You already possess that temporary item.
        NO_COMBINATION                 = 10663, -- You were unable to enter a combination.
        COMMON_SENSE_SURVIVAL          = 10687, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        GOBLINSAVIOR_HERONOX   = GetFirstID('Goblinsavior_Heronox'),
        WYVERNPOACHER_DRACHLOX = GetFirstID('Wyvernpoacher_Drachlox'),
        BAOBHAN_SITH           = GetFirstID('Baobhan_Sith'),
        TAXIM                  = GetFirstID('Taxim'),
        UNGUR                  = GetFirstID('Ungur'),
        AMIKIRI                = GetFirstID('Amikiri'),
        BUNE                   = GetFirstID('Bune'),
        GIGAPLASM              = GetFirstID('Gigaplasm'),
        BARONIAL_BAT           = GetFirstID('Baronial_Bat'),
        RENFRED                = GetFirstID('Renfred'), -- ASA-6, clones at +1 to +3
        GORATTZ                = GetFirstID('Gorattz'), -- ASA-6, clones at +1 to +3
        BOMPUPU                = GetFirstID('Bompupu'), -- ASA-6, clones at +1 to +3
    },
    npc =
    {
        OUTCROPPING = GetFirstID('Outcropping'), -- ASA-5 to ASA-7
    },
}

return zones[xi.zone.GUSTAV_TUNNEL]
