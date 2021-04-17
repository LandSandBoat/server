-----------------------------------
-- Area: Abyssea-Tahrongi
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ABYSSEA_TAHRONGI] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CRUOR_TOTAL             = 6987, -- Obtained <number> cruor. (Total: <number>)
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CRUOR_OBTAINED          = 7496, -- <name> obtained <number> cruor.
    },
    mob =
    {
    },
    npc =
    {
        QM_POPS =
        {
            -- TODO: the first item, e.g. 'qm1', is unused and will be meaningless once I (Wren) finish entity-QC on all Abyssea zones.
            -- When that is done, I will rewrite Abyssea global and adjust and neaten this table
            --  [16961954] = { 'qm1',           {2915},                                                                                                                     {}, 16961917}, -- Halimede
            --  [16961955] = { 'qm2',           {2916},                                                                                                                     {}, 16961918}, -- Vetehinen
            --  [16961956] = { 'qm3', {2917, 2945, 2946},                                                                                                                     {}, 16961919}, -- Ophanim
            --  [16961957] = { 'qm4',           {2918},                                                                                                                     {}, 16961920}, -- Cannered Noz
            --  [16961958] = { 'qm5',      {2919, 2947},                                                                                                                     {}, 16961921}, -- Treble Noctules
            --  [16961959] = { 'qm6',           {2920},                                                                                                                     {}, 16961922}, -- Gancanagh
            --  [16961960] = { 'qm7',      {2921, 2948},                                                                                                                     {}, 16961923}, -- Hedetet
            --  [16961961] = { 'qm8',           {2922},                                                                                                                     {}, 16961924}, -- Abas
            --  [16961962] = { 'qm9',      {2923, 2949},                                                                                                                     {}, 16961925}, -- Alectryon
            --  [16961963] = {'qm10',           {2924},                                                                                                                     {}, 16961926}, -- Tefnet
            --  [16961964] = {'qm11',      {2925, 2950},                                                                                                                     {}, 16961927}, -- Muscaliet
            --  [16961965] = {'qm12',           {2926},                                                                                                                     {}, 16961928}, -- Lachrymater
            --  [16961966] = {'qm13',               {},         { xi.ki.VEINOUS_HECTEYES_EYELID, xi.ki.TORN_BAT_WING, xi.ki.GORY_SCORPION_CLAW, xi.ki.MOSSY_ADAMANTOISE_SHELL}, 16961929}, -- Chloris
            --  [16961967] = {'qm14',               {}, { xi.ki.FAT_LINED_COCKATRICE_SKIN, xi.ki.SODDEN_SANDWORM_HUSK, xi.ki.LUXURIANT_MANTICORE_MANE, xi.ki.STICKY_GNAT_WING}, 16961930}, -- Glavoid
            --  [16961968] = {'qm15',               {},                                                     { xi.ki.OVERGROWN_MANDRAGORA_FLOWER, xi.ki.CHIPPED_SANDWORM_TOOTH}, 16961931}, -- Lacovie
            --  [16961969] = {'qm16',               {},         { xi.ki.VEINOUS_HECTEYES_EYELID, xi.ki.TORN_BAT_WING, xi.ki.GORY_SCORPION_CLAW, xi.ki.MOSSY_ADAMANTOISE_SHELL}, 16961946}, -- Chloris
            --  [16961970] = {'qm17',               {}, { xi.ki.FAT_LINED_COCKATRICE_SKIN, xi.ki.SODDEN_SANDWORM_HUSK, xi.ki.LUXURIANT_MANTICORE_MANE, xi.ki.STICKY_GNAT_WING}, 16961947}, -- Glavoid
            --  [16961971] = {'qm18',               {},                                                     { xi.ki.OVERGROWN_MANDRAGORA_FLOWER, xi.ki.CHIPPED_SANDWORM_TOOTH}, 16961948}, -- Lacovie
            --  [16961972] = {'qm19',               {},         { xi.ki.VEINOUS_HECTEYES_EYELID, xi.ki.TORN_BAT_WING, xi.ki.GORY_SCORPION_CLAW, xi.ki.MOSSY_ADAMANTOISE_SHELL}, 16961949}, -- Chloris
            --  [16961973] = {'qm20',               {}, { xi.ki.FAT_LINED_COCKATRICE_SKIN, xi.ki.SODDEN_SANDWORM_HUSK, xi.ki.LUXURIANT_MANTICORE_MANE, xi.ki.STICKY_GNAT_WING}, 16961950}, -- Glavoid
            --  [16961974] = {'qm21',               {},                                                     { xi.ki.OVERGROWN_MANDRAGORA_FLOWER, xi.ki.CHIPPED_SANDWORM_TOOTH}, 16961951}, -- Lacovie
        },
    },
}

return zones[xi.zone.ABYSSEA_TAHRONGI]
