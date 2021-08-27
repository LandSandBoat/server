-----------------------------------
-- Area: Aydeewa_Subterrane
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.AYDEEWA_SUBTERRANE] =
{
    text =
    {
        NOTHING_HAPPENS         = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY = 6403, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET   = 6418, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET  = 7050, -- You can't fish here.
        MINING_IS_POSSIBLE_HERE = 7321, -- Mining is possible here if you have <item>.
        BLOOD_STAINS            = 8030, -- The ground is smeared with bloodstains...
        DRAWS_NEAR              = 8031, -- Something draws near!
        COMMON_SENSE_SURVIVAL   = 8903, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BLUESTREAK_GYUGYUROON_PH =
        {
            [17055941] = 17056156, -- -221.7 13.762 -346.83
            [17055942] = 17056156, -- -219 14.003 -364.83
        },
        NOSFERATU          = 17056157,
        PANDEMONIUM_WARDEN = 17056168,
        CHIGRE             = 17056186,
    },
    npc =
    {
    },
}

return zones[xi.zone.AYDEEWA_SUBTERRANE]
