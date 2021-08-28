-----------------------------------
-- Area: Abyssea-Grauberg
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ABYSSEA_GRAUBERG] =
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
        EXITING_ABYSSEA_OFFSET  = 7331, -- Exiting in <number> [minute/minutes].
        NO_VISITANT_WARD        = 7337, -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_SEARING_IN = 7338, -- Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD       = 7339, -- Returning to the Searing Ward now.
        CRUOR_OBTAINED          = 7499, -- <name> obtained <number> cruor.
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
            --  [17818091] = {'qm11',               {}, {xi.ki.WARPED_CHARIOT_PLATE, xi.ki.SHATTERED_IRON_GIANT_CHAIN}, 17818051}, -- Raja
            --  [17818092] = {'qm12',               {},                                    {xi.ki.VENOMOUS_HYDRA_FANG}, 17818052}, -- Alfard
            --  [17818093] = {'qm13',               {},                                      {xi.ki.VACANT_BUGARD_EYE}, 17818053}, -- Azdaja
            --  [17818094] = {'qm14',               {},                              {xi.ki.VARIEGATED_URAGNITE_SHELL}, 17818054}, -- Amphitrite
            --  [17818095] = {'qm15',               {}, {xi.ki.WARPED_CHARIOT_PLATE, xi.ki.SHATTERED_IRON_GIANT_CHAIN}, 17818055}, -- Raja
            --  [17818096] = {'qm16',               {},                                    {xi.ki.VENOMOUS_HYDRA_FANG}, 17818056}, -- Alfard
            --  [17818097] = {'qm17',               {},                                      {xi.ki.VACANT_BUGARD_EYE}, 17818057}, -- Azdaja
            --  [17818098] = {'qm18',               {},                              {xi.ki.VARIEGATED_URAGNITE_SHELL}, 17818058}, -- Amphitrite
            --  [17818099] = {'qm19',               {}, {xi.ki.WARPED_CHARIOT_PLATE, xi.ki.SHATTERED_IRON_GIANT_CHAIN}, 17818059}, -- Raja
            --  [17818100] = {'qm20',               {},                                    {xi.ki.VENOMOUS_HYDRA_FANG}, 17818060}, -- Alfard
            --  [17818101] = {'qm21',               {},                                      {xi.ki.VACANT_BUGARD_EYE}, 17818061}, -- Azdaja
            --  [17818102] = {'qm22',               {},                              {xi.ki.VARIEGATED_URAGNITE_SHELL}, 17818062}, -- Amphitrite
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

return zones[xi.zone.ABYSSEA_GRAUBERG]
