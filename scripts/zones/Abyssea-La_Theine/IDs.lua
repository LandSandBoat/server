-----------------------------------
-- Area: Abyssea-La_Theine
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.ABYSSEA_LA_THEINE] =
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
        FISHING_MESSAGE_OFFSET  = 7050, -- You can't fish here.
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
            --  [17318485] = {'qm13',     {},                                    { xi.ki.DENTED_GIGAS_SHIELD, xi.ki.WARPED_GIGAS_ARMBAND, xi.ki.SEVERED_GIGAS_COLLAR}, 17318446}, -- Briareus
            --  [17318486] = {'qm14',     {},                                                                { xi.ki.PELLUCID_FLY_EYE, xi.ki.SHIMMERING_PIXIE_PINION}, 17318447}, -- Carabosse
            --  [17318487] = {'qm15',     {}, { xi.ki.MARBLED_MUTTON_CHOP, xi.ki.BLOODIED_SABER_TOOTH, xi.ki.GLITTERING_PIXIE_CHOKER, xi.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318448}, -- Hadhayosh
            --  [17318488] = {'qm16',     {},                                    { xi.ki.DENTED_GIGAS_SHIELD, xi.ki.WARPED_GIGAS_ARMBAND, xi.ki.SEVERED_GIGAS_COLLAR}, 17318456}, -- Briareus
            --  [17318489] = {'qm17',     {},                                                                { xi.ki.PELLUCID_FLY_EYE, xi.ki.SHIMMERING_PIXIE_PINION}, 17318457}, -- Carabosse
            --  [17318490] = {'qm18',     {}, { xi.ki.MARBLED_MUTTON_CHOP, xi.ki.BLOODIED_SABER_TOOTH, xi.ki.GLITTERING_PIXIE_CHOKER, xi.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318458}, -- Hadhayosh
            --  [17318491] = {'qm19',     {},                                    { xi.ki.DENTED_GIGAS_SHIELD, xi.ki.WARPED_GIGAS_ARMBAND, xi.ki.SEVERED_GIGAS_COLLAR}, 17318459}, -- Briareus
            --  [17318492] = {'qm20',     {},                                                                { xi.ki.PELLUCID_FLY_EYE, xi.ki.SHIMMERING_PIXIE_PINION}, 17318460}, -- Carabosse
            --  [17318493] = {'qm21',     {}, { xi.ki.MARBLED_MUTTON_CHOP, xi.ki.BLOODIED_SABER_TOOTH, xi.ki.GLITTERING_PIXIE_CHOKER, xi.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318461}, -- Hadhayosh
        },
    },
}

return zones[ xi.zone.ABYSSEA_LA_THEINE]
