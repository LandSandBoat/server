-----------------------------------
-- Area: Valley_of_Sorrows
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.VALLEY_OF_SORROWS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED    = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE = 6387,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED              = 6389,  -- Obtained: <item>.
        GIL_OBTAINED               = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6392,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED             = 6398,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY    = 6403,  -- There is nothing out of the ordinary here.
        AURA_THREATENS             = 6407,  -- An aura of irrepressible might threatens to overwhelm you...
        FELLOW_MESSAGE_OFFSET      = 6418,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS        = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE              = 7050,  -- Tallying conquest results...
        SOMETHING_BURRIED          = 7309,  -- It looks like something was buried here.
        PLAYER_OBTAINS_ITEM        = 7499,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM      = 7500,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM   = 7501,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP       = 7502,  -- You already possess that temporary item.
        NO_COMBINATION             = 7507,  -- You were unable to enter a combination.
        REGIME_REGISTERED          = 9685,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL      = 10804, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        ADAMANTOISE   = 17301537,
        ASPIDOCHELONE = 17301538,
    },
    npc =
    {
        CASKET_BASE    = 17301544,
        ADAMANTOISE_QM = 17301567,
    },
}

return zones[ xi.zone.VALLEY_OF_SORROWS]
