-----------------------------------
-- Area: Navukgo_Execution_Chamber
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.NAVUKGO_EXECUTION_CHAMBER] =
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
        KARABABA_ENOUGH         = 7630, -- That's quite enough...
        KARABABA_ROUGH          = 7631, -- Time for me to start playing rough!
        KARABARA_FIRE           = 7632, -- Fuel for the fire! It doesn't pay to invoke my ire!
        KARABARA_ICE            = 7633, -- Well, if you won't play nice, I'll put your sorry hide on ice!
        KARABARA_WIND           = 7634, -- This battle is growing stale. How about we have a refreshing gale!
        KARABARA_EARTH          = 7635, -- Sometimes it comes as quite a shock, how much damage you can deal with simple rock!
        KARABARA_LIGHTNING      = 7636, -- How I love to rip things asunder! Witness the power of lightning and thunder!
        KARABARA_WATER          = 7637, -- Water is more dangerous than most expect. Never fear, I'll teach you respect!
        KARABABA_QUIT           = 7645, -- What a completely useless shield. It's time for me to quit the field.
    },
    mob =
    {
        KARABABA_OFFSET = 17039401,
        IMMORTAL_FLAN2  = 17039375, -- IMMORTAL_FLAN1 always pops in battlefield, other flans pop depending on party size
        IMMORTAL_FLAN3  = 17039376,
        IMMORTAL_FLAN4  = 17039377,
        IMMORTAL_FLAN5  = 17039378,
        IMMORTAL_FLAN6  = 17039379,
    },
    npc =
    {
    },
}

return zones[ xi.zone.NAVUKGO_EXECUTION_CHAMBER]
