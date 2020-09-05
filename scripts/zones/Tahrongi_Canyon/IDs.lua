-----------------------------------
-- Area: Tahrongi_Canyon
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.TAHRONGI_CANYON] =
{
    text =
    {
        CONQUEST_BASE                = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED      = 6563,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                = 6569,  -- Obtained: <item>.
        GIL_OBTAINED                 = 6570,  -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6572,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY      = 6583,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET        = 6598,  -- I'm ready. I suppose.
        FISHING_MESSAGE_OFFSET       = 7230,  -- You can't fish here.
        DIG_THROW_AWAY               = 7243,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                 = 7245,  -- You dig and you dig, but find nothing.
        ALREADY_OBTAINED_TELE        = 7330,  -- You already possess the gate crystal for this telepoint.
        TELEPOINT_DISAPPEARED        = 7331,  -- The telepoint has disappeared...
        SIGN_1                       = 7405,  -- North: Meriphataud Mountains Northeast: Crag of Mea South: East Sarutabaruta
        SIGN_3                       = 7406,  -- North: Meriphataud Mountains East: Crag of Mea South: East Sarutabaruta
        SIGN_5                       = 7407,  -- North: Meriphataud Mountains East: Buburimu Peninsula South: East Sarutabaruta
        SIGN_7                       = 7408,  -- East: Buburimu Peninsula West: East Sarutabaruta
        BUD_BREAKS_OFF               = 7409,  -- The bud breaks off. You obtain <item>.
        POISONOUS_LOOKING_BUDS       = 7410,  -- The flowers have poisonous-looking buds.
        CANT_TAKE_ANY_MORE           = 7411,  -- You can't take any more.
        MINING_IS_POSSIBLE_HERE      = 7432,  -- Mining is possible here if you have <item>.
        TELEPOINT_HAS_BEEN_SHATTERED = 7506,  -- The telepoint has been shattered into a thousand pieces...
        SPROUT_LOOKS_WITHERED        = 7549,  -- There is something sprouting from the ground here. It looks a little withered.
        REPULSIVE_CREATURE_EMERGES   = 7550,  -- A repulsive creature emerges from the ground!
        SPROUT_DOES_NOT_NEED_WATER   = 7551,  -- The sprout does not need any more water now.
        NOTHING_HAPPENS              = 7552,  -- Nothing happens.
        SPROUT_LOOKING_BETTER        = 7553,  -- The sprout is looking better.
        PLAYER_OBTAINS_ITEM          = 7558,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM        = 7559,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM     = 7560,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP         = 7561,  -- You already possess that temporary item.
        NO_COMBINATION               = 7566,  -- You were unable to enter a combination.
        REGIME_REGISTERED            = 9818,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL        = 11935, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        SERPOPARD_ISHTAR_PH =
        {
            [17256560] = 17256563, -- -9.176 -8.191 -64.347 (south)
            [17256686] = 17256690, -- 22.360 23.757 281.584 (north)
        },
        HERBAGE_HUNTER_PH =
        {
            [17256835] = 17256836, -- -119.301, 24.087, 448.636
        },
        HABROK            = 17256493,
        YARA_MA_YHA_WHO   = 17256900,
    },
    npc =
    {
        CASKET_BASE     = 17257008,
        SIGNPOST_OFFSET = 17257033,
        EXCAVATION =
        {
            17257055,
            17257056,
            17257057,
            17257058,
            17257059,
            17257060,
        },
    },
}

return zones[tpz.zone.TAHRONGI_CANYON]
