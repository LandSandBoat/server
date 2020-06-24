-----------------------------------
-- Area: Batallia_Downs
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.BATALLIA_DOWNS] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6404,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6410,  -- Obtained: <item>.
        GIL_OBTAINED             = 6411,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6413,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6424,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6439,  -- I'm ready. I suppose.
        CONQUEST_BASE            = 7071,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7230,  -- You can't fish here.
        DIG_THROW_AWAY           = 7243,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7245,  -- You dig and you dig, but find nothing.
        SPARKLING_LIGHT          = 7339,  -- The ground is sparkling with a strange light.
        PLAYER_OBTAINS_ITEM      = 7690,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7691,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7692,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7693,  -- You already possess that temporary item.
        NO_COMBINATION           = 7698,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9976,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 12832, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        RAPTOR_OVERCOME_MUNCHIES = 12985, -- The raptor has overcome the munchies! (<n>/<n>)
        RAPTOR_SECOND_WIND       = 12986, -- The raptor has gained a second wind!
        MEET_SYRILLIA            = 12987, -- Meet up with Syrillia.
        RAPTOR_SPEEDS_OFF        = 12988, -- The raptor speeds off into the sunset...
    },
    mob =
    {
        PRANKSTER_MAVERIX_PH =
        {
            [17207635] = 17207640,
            [17207636] = 17207640,
            [17207637] = 17207640,
            [17207638] = 17207640,
            [17207639] = 17207640,
        },
        TOTTERING_TOBY_PH =
        {
            [17207449] = 17207476, -- -194.234 -18.485 132.208
        },
        AHTU              = 17207657,
        STURMTIGER        = 17207696,
        SUPARNA           = 17207697,
        SUPARNA_FLEDGLING = 17207698,
        VEGNIX_GREENTHUMB = 17207710,
    },
    npc =
    {
        CASKET_BASE      = 17207794,
        SYRILLIA         = 17207972,
        BLUE_BEAM_BASE   = 17207973,
        RAPTOR_FOOD_BASE = 17207981,
    },
}

return zones[tpz.zone.BATALLIA_DOWNS]
