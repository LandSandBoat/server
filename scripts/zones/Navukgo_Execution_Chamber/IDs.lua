-----------------------------------
-- Area: Navukgo_Execution_Chamber
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.NAVUKGO_EXECUTION_CHAMBER] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        KARABABA_ENOUGH         = 7629, -- That's quite enough...
        KARABABA_ROUGH          = 7630, -- Time for me to start playing rough!
        KARABARA_FIRE           = 7631, -- Fuel for the fire! It doesn't pay to invoke my ire!
        KARABARA_ICE            = 7632, -- Well, if you won't play nice, I'll put your sorry hide on ice!
        KARABARA_WIND           = 7633, -- This battle is growing stale. How about we have a refreshing gale!
        KARABARA_EARTH          = 7634, -- Sometimes it comes as quite a shock, how much damage you can deal with simple rock!
        KARABARA_LIGHTNING      = 7635, -- How I love to rip things asunder! Witness the power of lightning and thunder!
        KARABARA_WATER          = 7636, -- Water is more dangerous than most expect. Never fear, I'll teach you respect!
        KARABABA_QUIT           = 7644, -- What a completely useless shield. It's time for me to quit the field.
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

return zones[tpz.zone.NAVUKGO_EXECUTION_CHAMBER]
