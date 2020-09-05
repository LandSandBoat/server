-----------------------------------
-- Area: Abyssea-Altepa
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ABYSSEA_ALTEPA] =
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
            --  [17670591] = { 'qm1',      {3230, 3236},                                                          {}, 17670565}, -- Ironclad Smiter
            --  [17670592] = { 'qm2', {3231, 3232, 3238},                                                          {}, 17670567}, -- Amarok
            --  [17670593] = { 'qm3',      {3233, 3242},                                                          {}, 17670570}, -- Shaula
            --  [17670594] = { 'qm4',      {3234, 3244},                                                          {}, 17670571}, -- Emperador de Altepa
            --  [17670595] = { 'qm5',           {3235},                                                          {}, 17670572}, -- Tablilla
            --  [17670596] = { 'qm6',           {3237},                                                          {}, 17670574}, -- Sharabha
            --  [17670597] = { 'qm7',           {3239},                                                          {}, 17670576}, -- Waugyl
            --  [17670598] = { 'qm8',           {3240},                                                          {}, 17670577}, -- Chickcharney
            --  [17670599] = { 'qm9',           {3241},                                                          {}, 17670578}, -- Vadleany
            --  [17670600] = {'qm10',           {3243},                                                          {}, 17670579}, -- Bugul Noz
            --  [17670601] = {'qm11',               {}, {tpz.ki.BROKEN_IRON_GIANT_SPIKE, tpz.ki.RUSTED_CHARIOT_GEAR}, 17670551}, -- Rani
            --  [17670602] = {'qm12',               {},                           {tpz.ki.STEAMING_CERBERUS_TONGUE}, 17670552}, -- Orthus
            --  [17670603] = {'qm13',               {},                                {tpz.ki.BLOODIED_DRAGON_EAR}, 17670553}, -- Dragua
            --  [17670604] = {'qm14',               {},                              {tpz.ki.RESPLENDENT_ROC_QUILL}, 17670554}, -- Bennu
            --  [17670605] = {'qm15',               {}, {tpz.ki.BROKEN_IRON_GIANT_SPIKE, tpz.ki.RUSTED_CHARIOT_GEAR}, 17670555}, -- Rani
            --  [17670606] = {'qm16',               {},                           {tpz.ki.STEAMING_CERBERUS_TONGUE}, 17670556}, -- Orthus
            --  [17670607] = {'qm17',               {},                                {tpz.ki.BLOODIED_DRAGON_EAR}, 17670557}, -- Dragua
            --  [17670608] = {'qm18',               {},                              {tpz.ki.RESPLENDENT_ROC_QUILL}, 17670558}, -- Bennu
            --  [17670609] = {'qm19',               {}, {tpz.ki.BROKEN_IRON_GIANT_SPIKE, tpz.ki.RUSTED_CHARIOT_GEAR}, 17670559}, -- Rani
            --  [17670610] = {'qm20',               {},                           {tpz.ki.STEAMING_CERBERUS_TONGUE}, 17670560}, -- Orthus
            --  [17670611] = {'qm21',               {},                                {tpz.ki.BLOODIED_DRAGON_EAR}, 17670561}, -- Dragua
            --  [17670612] = {'qm22',               {},                              {tpz.ki.RESPLENDENT_ROC_QUILL}, 17670562}, -- Bennu
        },
    },
}

return zones[tpz.zone.ABYSSEA_ALTEPA]
