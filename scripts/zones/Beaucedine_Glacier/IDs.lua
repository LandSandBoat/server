-----------------------------------
-- Area: Beaucedine_Glacier
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.BEAUCEDINE_GLACIER] =
{
    text =
    {
        CONQUEST_BASE                   = 0,     -- Tallying conquest results...
        BEASTMEN_BANNER                 = 81,    -- There is a beastmen's banner.
        ITEM_CANNOT_BE_OBTAINED         = 6566,  -- You cannot obtain the item. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE      = 6568,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                   = 6570,  -- Obtained: <item>.
        GIL_OBTAINED                    = 6571,  -- Obtained <number> gil.
        KEYITEM_OBTAINED                = 6573,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                    = 6574,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                  = 6579,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY         = 6584,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET           = 6599,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS             = 7181, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY         = 7182, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                    = 7183, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET          = 7231,  -- You can't fish here.
        CONQUEST                        = 7484,  -- You've earned conquest points!
        YOU_CANNOT_ENTER_DYNAMIS        = 7882,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL  = 7884,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE        = 7894,  -- There is an unusual arrangement of branches here.
        PLAYER_OBTAINS_ITEM             = 8577,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM           = 8578,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM        = 8579,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP            = 8580,  -- You already possess that temporary item.
        NO_COMBINATION                  = 8585,  -- You were unable to enter a combination.
        REGIME_REGISTERED               = 10763, -- New training regime registered!
        COMMON_SENSE_SURVIVAL           = 12789, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        GARGANTUA_PH =
        {
            [17232078] = 17232079, -- 339 -0.472 -20
        },
        KIRATA_PH    =
        {
            [17232042] = 17232044, -- 75.797 -0.335 -323.659
            [17232043] = 17232044, -- 69.336 -0.234 -276.561
        },
        NUE_PH       =
        {
            [17231969] = 17231971, -- -342.830 -100.584 168.662
            [17231970] = 17231971, -- -322.000 -100.000 116.000
        },
        HUMBABA      = 17232094,
    },
    npc =
    {
        CASKET_BASE     = 17232174,
        MIRROR_POND_J8  = 17232197,
        OVERSEER_BASE   = 17232208, -- Parledaire_RK in npc_list
    },
}

return zones[ xi.zone.BEAUCEDINE_GLACIER]
