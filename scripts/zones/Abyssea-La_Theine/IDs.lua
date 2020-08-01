-----------------------------------
-- Area: Abyssea-La_Theine
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ABYSSEA_LA_THEINE] =
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
            --  [17318473] = { 'qm1', {2891},                                                                                                                      {}, 17318434}, -- Dozing Dorian
            --  [17318474] = { 'qm2', {2892},                                                                                                                      {}, 17318435}, -- Trudging Thomas
            --  [17318475] = { 'qm3', {2893},                                                                                                                      {}, 17318436}, -- Megantereon
            --  [17318476] = { 'qm4', {2894},                                                                                                                      {}, 17318437}, -- Adamastor
            --  [17318477] = { 'qm5', {2895},                                                                                                                      {}, 17318438}, -- Pantagruel
            --  [17318478] = { 'qm6', {2896},                                                                                                                      {}, 17318439}, -- Grandgousier
            --  [17318479] = { 'qm7', {2897},                                                                                                                      {}, 17318440}, -- La Theine Liege
            --  [17318480] = { 'qm8', {2898},                                                                                                                      {}, 17318441}, -- Baba Yaga
            --  [17318481] = { 'qm9', {2899},                                                                                                                      {}, 17318442}, -- Nguruvilu
            --  [17318482] = {'qm10', {2900},                                                                                                                      {}, 17318443}, -- Poroggo Dom Juan
            --  [17318483] = {'qm11', {2901},                                                                                                                      {}, 17318444}, -- Toppling Tuber
            --  [17318484] = {'qm12', {2902},                                                                                                                      {}, 17318445}, -- Lugarhoo
            --  [17318485] = {'qm13',     {},                                    {tpz.ki.DENTED_GIGAS_SHIELD, tpz.ki.WARPED_GIGAS_ARMBAND, tpz.ki.SEVERED_GIGAS_COLLAR}, 17318446}, -- Briareus
            --  [17318486] = {'qm14',     {},                                                                {tpz.ki.PELLUCID_FLY_EYE, tpz.ki.SHIMMERING_PIXIE_PINION}, 17318447}, -- Carabosse
            --  [17318487] = {'qm15',     {}, {tpz.ki.MARBLED_MUTTON_CHOP, tpz.ki.BLOODIED_SABER_TOOTH, tpz.ki.GLITTERING_PIXIE_CHOKER, tpz.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318448}, -- Hadhayosh
            --  [17318488] = {'qm16',     {},                                    {tpz.ki.DENTED_GIGAS_SHIELD, tpz.ki.WARPED_GIGAS_ARMBAND, tpz.ki.SEVERED_GIGAS_COLLAR}, 17318456}, -- Briareus
            --  [17318489] = {'qm17',     {},                                                                {tpz.ki.PELLUCID_FLY_EYE, tpz.ki.SHIMMERING_PIXIE_PINION}, 17318457}, -- Carabosse
            --  [17318490] = {'qm18',     {}, {tpz.ki.MARBLED_MUTTON_CHOP, tpz.ki.BLOODIED_SABER_TOOTH, tpz.ki.GLITTERING_PIXIE_CHOKER, tpz.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318458}, -- Hadhayosh
            --  [17318491] = {'qm19',     {},                                    {tpz.ki.DENTED_GIGAS_SHIELD, tpz.ki.WARPED_GIGAS_ARMBAND, tpz.ki.SEVERED_GIGAS_COLLAR}, 17318459}, -- Briareus
            --  [17318492] = {'qm20',     {},                                                                {tpz.ki.PELLUCID_FLY_EYE, tpz.ki.SHIMMERING_PIXIE_PINION}, 17318460}, -- Carabosse
            --  [17318493] = {'qm21',     {}, {tpz.ki.MARBLED_MUTTON_CHOP, tpz.ki.BLOODIED_SABER_TOOTH, tpz.ki.GLITTERING_PIXIE_CHOKER, tpz.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318461}, -- Hadhayosh
        },
    },
}

return zones[tpz.zone.ABYSSEA_LA_THEINE]
