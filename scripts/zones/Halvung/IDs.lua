-----------------------------------
-- Area: Halvung
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.HALVUNG] =
{
    text =
    {
        NOTHING_HAPPENS         = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        WIDE_TRENCH             = 7902, -- There is a wide trench around the gate here. There are three keyholes of differing sizes inside the trench.
        KEY_BREAKS              = 7903, -- The <item> breaks!
        MINING_IS_POSSIBLE_HERE = 7925, -- Mining is possible here if you have <item>.
        BLUE_FLAMES             = 7964, -- You can see blue flames flickering from a hole in the ground here...
        DULL_PIECE              = 8039, -- A dull piece of metal lies on the ground. It appears to be a bracelet of sorts, but the layers of grime covering its surface render it wholly unwearable.
        LIFT_LEVER              = 8042, -- You lift the lever with all your might!
        COMMON_SENSE_SURVIVAL   = 8103, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BIG_BOMB               = 17031401,
        GURFURLUR_THE_MENACING = 17031592,
        DEXTROSE               = 17031598,
        REACTON                = 17031599,
        ACHAMOTH               = 17031600,
    },
    npc =
    {
        LEVER_AB_DOOR          = 17031668,
        LEVER_CD_DOOR          = 17031672,
        LEVER_EF_DOOR          = 17031676,
        LEVER_GH_DOOR          = 17031680,
        LEVER_IJ_DOOR          = 17031684,
        MINING =
        {
            17031715,
            17031716,
            17031717,
            17031718,
            17031719,
            17031720,
        },
    },
}

return zones[xi.zone.HALVUNG]
