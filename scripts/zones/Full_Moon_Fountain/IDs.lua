-----------------------------------
-- Area: Full_Moon_Fountain
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.FULL_MOON_FOUNTAIN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7050, -- Tallying conquest results...
        UNABLE_TO_PROTECT       = 7367, -- You were unable to protect Ajido-Marujido. Now leaving the battlefield.
        PLAY_TIME_IS_OVER       = 7753, -- Play time is over! Powers of dark mana, answer my call!
        YOU_SHOULD_BE_THANKFUL  = 7754, -- You should be thankful. I'll give you a shortaru trip back to the hell you came from!
        DONT_GIVE_UP            = 7755, -- Don't give up, adventurer! You are Windurst's guiding star, our beacon of hope!
    },
    mob =
    {
        MOON_READING_OFFSET = 17473540,
    },
    npc =
    {
    },
}

return zones[ xi.zone.FULL_MOON_FOUNTAIN]
