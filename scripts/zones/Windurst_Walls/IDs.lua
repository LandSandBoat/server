-----------------------------------
-- Area: Windurst_Walls
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.WINDURST_WALLS] =
{
    text =
    {
        CONQUEST_BASE                  = 0,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED        = 6542, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6546, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6548, -- Obtained: <item>.
        GIL_OBTAINED                   = 6549, -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6551, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6552, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL            = 6553, -- You do not have enough gil.
        ITEMS_OBTAINED                 = 6557, -- You obtain <number> <item>!
        YOU_MUST_WAIT_ANOTHER_N_DAYS   = 6584, -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS            = 6587, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6588, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 6589, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOU_LEARNED_TRUST              = 6611, -- You learned Trust: <name>!
        HOMEPOINT_SET                  = 6639, -- Home point set!
        MOG_LOCKER_OFFSET              = 6813, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        ITEM_DELIVERY_DIALOG           = 6966, -- We can deliver goods to your residence or to the residences of your friends.
        FISHING_MESSAGE_OFFSET         = 7062, -- You can't fish here.
        DOORS_SEALED_SHUT              = 7737, -- The doors are firmly sealed shut.
        MOGHOUSE_EXIT                  = 8194, -- You have learned your way through the back alleys of Windurst! Now you can exit to any area from your residence.
        SCAVNIX_SHOP_DIALOG            = 8678, -- <Pshoooooowaaaaa> I'm goood Goblin from underwooorld.  I find lotshhh of gooodieshhh.  You want try shhhome chipshhh? Cheap for yooou.
        RETRIBUTION_LEARNED            = 9066, -- You have learned the weapon skill Retribution!
        YOU_CANNOT_ENTER_DYNAMIS       = 9089, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 9091, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 9103, -- The strands of grass here have been tied together.
        TEAR_IN_FABRIC_OF_SPACE        = 10838, -- There appears to be a tear in the fabric of space...
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.WINDURST_WALLS]
