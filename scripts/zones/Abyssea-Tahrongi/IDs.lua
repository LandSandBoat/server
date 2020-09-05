-----------------------------------
-- Area: Abyssea-Tahrongi
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ABYSSEA_TAHRONGI] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CRUOR_TOTAL             = 6986, -- Obtained <number> cruor. (Total: <number>)
        CRUOR_OBTAINED          = 7495, -- <name> obtained <number> cruor.
    },
    mob =
    {
    },
    npc =
    {
        QM_POPS =
        {
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
            --  [16961966] = {'qm13',               {},         {tpz.ki.VEINOUS_HECTEYES_EYELID, tpz.ki.TORN_BAT_WING, tpz.ki.GORY_SCORPION_CLAW, tpz.ki.MOSSY_ADAMANTOISE_SHELL}, 16961929}, -- Chloris
            --  [16961967] = {'qm14',               {}, {tpz.ki.FAT_LINED_COCKATRICE_SKIN, tpz.ki.SODDEN_SANDWORM_HUSK, tpz.ki.LUXURIANT_MANTICORE_MANE, tpz.ki.STICKY_GNAT_WING}, 16961930}, -- Glavoid
            --  [16961968] = {'qm15',               {},                                                     {tpz.ki.OVERGROWN_MANDRAGORA_FLOWER, tpz.ki.CHIPPED_SANDWORM_TOOTH}, 16961931}, -- Lacovie
            --  [16961969] = {'qm16',               {},         {tpz.ki.VEINOUS_HECTEYES_EYELID, tpz.ki.TORN_BAT_WING, tpz.ki.GORY_SCORPION_CLAW, tpz.ki.MOSSY_ADAMANTOISE_SHELL}, 16961946}, -- Chloris
            --  [16961970] = {'qm17',               {}, {tpz.ki.FAT_LINED_COCKATRICE_SKIN, tpz.ki.SODDEN_SANDWORM_HUSK, tpz.ki.LUXURIANT_MANTICORE_MANE, tpz.ki.STICKY_GNAT_WING}, 16961947}, -- Glavoid
            --  [16961971] = {'qm18',               {},                                                     {tpz.ki.OVERGROWN_MANDRAGORA_FLOWER, tpz.ki.CHIPPED_SANDWORM_TOOTH}, 16961948}, -- Lacovie
            --  [16961972] = {'qm19',               {},         {tpz.ki.VEINOUS_HECTEYES_EYELID, tpz.ki.TORN_BAT_WING, tpz.ki.GORY_SCORPION_CLAW, tpz.ki.MOSSY_ADAMANTOISE_SHELL}, 16961949}, -- Chloris
            --  [16961973] = {'qm20',               {}, {tpz.ki.FAT_LINED_COCKATRICE_SKIN, tpz.ki.SODDEN_SANDWORM_HUSK, tpz.ki.LUXURIANT_MANTICORE_MANE, tpz.ki.STICKY_GNAT_WING}, 16961950}, -- Glavoid
            --  [16961974] = {'qm21',               {},                                                     {tpz.ki.OVERGROWN_MANDRAGORA_FLOWER, tpz.ki.CHIPPED_SANDWORM_TOOTH}, 16961951}, -- Lacovie
        },
    },
}

return zones[tpz.zone.ABYSSEA_TAHRONGI]
