-----------------------------------
-- Area: Mog_Garden
-----------------------------------
zones = zones or {}

zones[xi.zone.MOG_GARDEN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6400, -- You do not have enough gil.
        ITEM_OBTAINEDX                = 6404, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6409, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7232, -- You can't fish here.
        STARS_ON_KEYITEM              = 7521, -- <number> star[/s] on your <item> [has/have] come aglow. A total of <number> star[/s] twinkle[s/] softly inside your <item>.
        MOGLOCKER_MESSAGE_OFFSET      = 7537, -- Your particular paid period of Mog Locker patronage has been extended until the following time, kupo! Earth Time: #/#/# at #:#:#.
        RETRIEVE_DIALOG_ID            = 8588, -- You retrieve <item> from the porter moogle's care.
    },
    mob =
    {
    },
    npc =
    {
        GREEN_THUMB_MOOGLE = GetFirstID('Green_Thumb_Moogle'),
        MOG_DINGHY         = GetFirstID('Mog_Dinghy'),
        PORTER_MOOGLE      = GetFirstID('Porter_Moogle'),
    },
}

return zones[xi.zone.MOG_GARDEN]
