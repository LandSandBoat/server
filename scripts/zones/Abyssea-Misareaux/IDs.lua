-----------------------------------
-- Area: Abyssea-Misareaux
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ABYSSEA_MISAREAUX] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CRUOR_TOTAL             = 6986, -- Obtained <number> cruor. (Total: <number>)
        FISHING_MESSAGE_OFFSET  = 7049, -- You can't fish here.
        CRUOR_OBTAINED          = 7495, -- <name> obtained <number> cruor.
    },
    mob =
    {
    },
    npc =
    {
        QM_POPS =
        {
            --  [17662556] = { 'qm1',      {3085},                                                                                     {}, 17662464}, -- Minax Bugard
            --  [17662557] = { 'qm2',      {3086},                                                                                     {}, 17662465}, -- Sirrush
            --  [17662558] = { 'qm3',      {3087},                                                                                     {}, 17662466}, -- Funeral Apkallu
            --  [17662559] = { 'qm4',      {3088},                                                                                     {}, 17662467}, -- Manohra
            --  [17662560] = { 'qm5',      {3089},                                                                                     {}, 17662468}, -- Cep-Kamuy
            --  [17662561] = { 'qm6',      {3090},                                                                                     {}, 17662469}, -- Ironclad Observer
            --  [17662562] = { 'qm7',      {3091},                                                                                     {}, 17662470}, -- Nehebkau
            --  [17662563] = { 'qm8',      {3092},                                                                                     {}, 17662471}, -- Avalerion
            --  [17662564] = { 'qm9', {3093, 3094},                                                                                     {}, 17662472}, -- Karkatakam
            --  [17662565] = {'qm10',      {3095},                                                                                     {}, 17662473}, -- Nonno
            --  [17662566] = {'qm11',      {3096},                                                                                     {}, 17662474}, -- Tuskertrap
            --  [17662567] = {'qm12',      {3097},                                                                                     {}, 17662475}, -- Npfundlwa
            --  [17662568] = {'qm13',          {},                             {tpz.ki.GLISTENING_OROBON_LIVER, tpz.ki.DOFFED_POROGGO_HAT}, 17662476}, -- Cirein-Croin
            --  [17662569] = {'qm14',          {},          {tpz.ki.JAGGED_APKALLU_BEAK, tpz.ki.CLIPPED_BIRD_WING, tpz.ki.BLOODIED_BAT_FUR}, 17662477}, -- Amhuluk
            --  [17662570] = {'qm15',          {}, {tpz.ki.BLOODSTAINED_BUGARD_FANG, tpz.ki.GNARLED_LIZARD_NAIL, tpz.ki.MOLTED_PEISTE_SKIN}, 17662478}, -- Sobek
            --  [17662571] = {'qm16',          {},                           {tpz.ki.BLAZING_CLUSTER_SOUL, tpz.ki.SCALDING_IRONCLAD_SPIKE}, 17662479}, -- Ironclad Pulverizor
            --  [17662572] = {'qm17',          {},                             {tpz.ki.GLISTENING_OROBON_LIVER, tpz.ki.DOFFED_POROGGO_HAT}, 17662481}, -- Cirein-Croin
            --  [17662573] = {'qm18',          {},          {tpz.ki.JAGGED_APKALLU_BEAK, tpz.ki.CLIPPED_BIRD_WING, tpz.ki.BLOODIED_BAT_FUR}, 17662482}, -- Amhuluk
            --  [17662574] = {'qm19',          {}, {tpz.ki.BLOODSTAINED_BUGARD_FANG, tpz.ki.GNARLED_LIZARD_NAIL, tpz.ki.MOLTED_PEISTE_SKIN}, 17662483}, -- Sobek
            --  [17662575] = {'qm20',          {},                           {tpz.ki.BLAZING_CLUSTER_SOUL, tpz.ki.SCALDING_IRONCLAD_SPIKE}, 17662484}, -- Ironclad Pulverizor
            --  [17662576] = {'qm21',          {},                             {tpz.ki.GLISTENING_OROBON_LIVER, tpz.ki.DOFFED_POROGGO_HAT}, 17662486}, -- Cirein-Croin
            --  [17662577] = {'qm22',          {},          {tpz.ki.JAGGED_APKALLU_BEAK, tpz.ki.CLIPPED_BIRD_WING, tpz.ki.BLOODIED_BAT_FUR}, 17662487}, -- Amhuluk
            --  [17662578] = {'qm23',          {}, {tpz.ki.BLOODSTAINED_BUGARD_FANG, tpz.ki.GNARLED_LIZARD_NAIL, tpz.ki.MOLTED_PEISTE_SKIN}, 17662488}, -- Sobek
            --  [17662579] = {'qm24',          {},                           {tpz.ki.BLAZING_CLUSTER_SOUL, tpz.ki.SCALDING_IRONCLAD_SPIKE}, 17662489}, -- Ironclad Pulverizor
        },
    },
}

return zones[tpz.zone.ABYSSEA_MISAREAUX]
