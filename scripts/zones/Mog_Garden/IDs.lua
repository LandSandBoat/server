-----------------------------------
-- Area: Mog_Garden
-----------------------------------
zones = zones or {}

-- TODO:
-- Server need NPC <17924154>
-- Server need NPC <17924155>
-- Server need NPC <17924156>
-- Server need NPC <17924157>
-- Server need NPC <17924162>
-- Server need NPC <17924163>
-- Server need NPC <17924164>
-- Server need NPC <17924165>
-- Server need NPC <17924170>
-- Server need NPC <17924171>
-- Server need NPC <17924172>
-- Server need NPC <17924119>
-- Server need NPC <17924120>
-- Server need NPC <17924121>
-- Server need NPC <17924122>
-- Server need NPC <17924123>
-- Server need NPC <17924223>
-- Server need NPC <17924224>
-- Server need NPC <17924225>
-- Server need NPC <17924227>
-- Server need NPC <17924229>
-- Server need NPC <17924234>
-- Server need NPC <17924235>

zones[xi.zone.MOG_GARDEN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6395, -- You do not have enough gil.
        ITEM_OBTAINEDX                = 6399, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7219, -- You can't fish here.
        STARS_ON_KEYITEM              = 7507, -- <number> star[/s] on your <item> [has/have] come aglow. A total of <number> star[/s] twinkle[s/] softly inside your <item>.
        MOGLOCKER_MESSAGE_OFFSET      = 7523, -- Your particular paid period of Mog Locker patronage has been extended until the following time, kupo! Earth Time: #/#/# at #:#:#.
        RETRIEVE_DIALOG_ID            = 8574, -- You retrieve <item> from the porter moogle's care.
    },
    mob =
    {
    },
    npc =
    {
        GREEN_THUMB_MOOGLE = 17924124,
        MOG_DINGHY         = 17924125,
        PORTER_MOOGLE      = 17924220,
    },
}

return zones[xi.zone.MOG_GARDEN]
