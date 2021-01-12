-----------------------------------
-- Area: Mog_Garden
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MOG_GARDEN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6389, -- Obtained: <item>.
        GIL_OBTAINED             = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6392, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL      = 6394, -- You do not have enough gil.
        ITEM_OBTAINEDX           = 6398, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY  = 6403, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS      = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET   = 7209, -- You can't fish here.
        STARS_ON_KEYITEM         = 7497, -- <number> star[/s] on your <item> [has/have] come aglow. A total of <number> star[/s] twinkle[s/] softly inside your <item>.
        MOGLOCKER_MESSAGE_OFFSET = 7513, -- Your particular paid period of Mog Locker patronage has been extended until the following time, kupo! Earth Time: #/#/# at #:#:#.
        RETRIEVE_DIALOG_ID       = 8564, -- You retrieve <item> from the porter moogle's care.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.MOG_GARDEN]
