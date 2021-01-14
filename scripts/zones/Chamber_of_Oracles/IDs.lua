-----------------------------------
-- Area: Chamber_of_Oracles
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.CHAMBER_OF_ORACLES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED          = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6389, -- Obtained: <item>.
        GIL_OBTAINED                     = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS              = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                     = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                    = 7050, -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7211, -- You cannot enter the battlefield at present. Please wait a little longer.
        PLACED_INTO_THE_PEDESTAL         = 7619, -- It appears that something should be placed into this pedestal.
        YOU_PLACE_THE                    = 7620, -- You place the <item> into the pedestal.
        IS_SET_IN_THE_PEDESTAL           = 7621, -- The <item> is set in the pedestal.
        HAS_LOST_ITS_POWER               = 7622, -- The <item> has lost its power.
        YOU_DECIDED_TO_SHOW_UP           = 7641, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY      = 7642, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY            = 7643, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS      = 7644, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER     = 7645, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP            = 7646, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING      = 7647, -- Ungh... That'll hurt in the morning...
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.CHAMBER_OF_ORACLES]
