-----------------------------------
-- Area: Abyssea-Grauberg
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ABYSSEA_GRAUBERG] =
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
            --  [17818081] = { 'qm1',      {3260, 3266},                                                              {}, 17818041}, -- Ironclad Sunderer
            --  [17818082] = { 'qm2', {3261, 3262, 3268},                                                              {}, 17818042}, -- Ningishzida
            --  [17818083] = { 'qm3',      {3263, 3272},                                                              {}, 17818043}, -- Teugghia
            --  [17818084] = { 'qm4',      {3264, 3274},                                                              {}, 17818044}, -- Bomblix Flamefinger
            --  [17818085] = { 'qm5',           {3265},                                                              {}, 17818045}, -- Teekesselchen
            --  [17818086] = { 'qm6',           {3267},                                                              {}, 17818046}, -- Minaruja
            --  [17818087] = { 'qm7',           {3269},                                                              {}, 17818047}, -- Xibalba
            --  [17818088] = { 'qm8',           {3270},                                                              {}, 17818048}, -- Ika-Roa
            --  [17818089] = { 'qm9',           {3271},                                                              {}, 17818049}, -- Lorelei
            --  [17818090] = {'qm10',           {3273},                                                              {}, 17818050}, -- Burstrox Powderpate
            --  [17818091] = {'qm11',               {}, {tpz.ki.WARPED_CHARIOT_PLATE, tpz.ki.SHATTERED_IRON_GIANT_CHAIN}, 17818051}, -- Raja
            --  [17818092] = {'qm12',               {},                                    {tpz.ki.VENOMOUS_HYDRA_FANG}, 17818052}, -- Alfard
            --  [17818093] = {'qm13',               {},                                      {tpz.ki.VACANT_BUGARD_EYE}, 17818053}, -- Azdaja
            --  [17818094] = {'qm14',               {},                              {tpz.ki.VARIEGATED_URAGNITE_SHELL}, 17818054}, -- Amphitrite
            --  [17818095] = {'qm15',               {}, {tpz.ki.WARPED_CHARIOT_PLATE, tpz.ki.SHATTERED_IRON_GIANT_CHAIN}, 17818055}, -- Raja
            --  [17818096] = {'qm16',               {},                                    {tpz.ki.VENOMOUS_HYDRA_FANG}, 17818056}, -- Alfard
            --  [17818097] = {'qm17',               {},                                      {tpz.ki.VACANT_BUGARD_EYE}, 17818057}, -- Azdaja
            --  [17818098] = {'qm18',               {},                              {tpz.ki.VARIEGATED_URAGNITE_SHELL}, 17818058}, -- Amphitrite
            --  [17818099] = {'qm19',               {}, {tpz.ki.WARPED_CHARIOT_PLATE, tpz.ki.SHATTERED_IRON_GIANT_CHAIN}, 17818059}, -- Raja
            --  [17818100] = {'qm20',               {},                                    {tpz.ki.VENOMOUS_HYDRA_FANG}, 17818060}, -- Alfard
            --  [17818101] = {'qm21',               {},                                      {tpz.ki.VACANT_BUGARD_EYE}, 17818061}, -- Azdaja
            --  [17818102] = {'qm22',               {},                              {tpz.ki.VARIEGATED_URAGNITE_SHELL}, 17818062}, -- Amphitrite
        },
        HARVESTING =
        {
            17818220,
            17818221,
            17818222,
            17818223,
            17818224,
            17818225,
        },
    },
}

return zones[tpz.zone.ABYSSEA_GRAUBERG]
