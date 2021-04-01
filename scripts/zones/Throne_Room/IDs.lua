-----------------------------------
-- Area: Throne_Room
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.THRONE_ROOM] =
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
        NO_HIDE_AWAY            = 7699, -- I have not been hiding away from my troubles!
        FEEL_MY_PAIN            = 7700, -- Feel my twenty years of pain!
        YOUR_ANSWER             = 7701, -- Is that your answer!?
        RETURN_TO_THE_DARKNESS  = 7702, -- Return with your soul to the darkness you came from!
        CANT_UNDERSTAND         = 7703, -- You--a man who has never lived bound by the chains of his country--how can you understand my pain!?
        BLADE_ANSWER            = 7704, -- Let my blade be the answer!
    },
    mob =
    {
        SHADOW_LORD_STAGE_2_OFFSET = 17453060,
        ZEID_BCNM_OFFSET           = 17453063,
    },
    npc =
    {
    },
}

return zones[ xi.zone.THRONE_ROOM]
