-----------------------------------
-- Area: Abyssea-Vunkerl
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ABYSSEA_VUNKERL] =
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
            --  [17666576] = { 'qm1', {3098},                                                                                          {}, 17666487}, -- Khalkotaur
            --  [17666577] = { 'qm2', {3099},                                                                                          {}, 17666488}, -- Quasimodo
            --  [17666578] = { 'qm3', {3100},                                                                                          {}, 17666489}, -- Iku-Turso
            --  [17666579] = { 'qm4', {3101},                                                                                          {}, 17666490}, -- Dvalinn
            --  [17666580] = { 'qm5', {3102},                                                                                          {}, 17666491}, -- Kadraeth the Hatespawn
            --  [17666581] = { 'qm6', {3103},                                                                                          {}, 17666492}, -- Rakshas
            --  [17666582] = { 'qm7', {3104},                                                                                          {}, 17666493}, -- Seps
            --  [17666583] = { 'qm8', {3105},                                                                                          {}, 17666494}, -- Xan
            --  [17666584] = { 'qm9', {3106},                                                                                          {}, 17666495}, -- Chhir Batti
            --  [17666585] = {'qm10', {3107},                                                                                          {}, 17666496}, -- Armillaria
            --  [17666586] = {'qm11', {3108},                                                                                          {}, 17666497}, -- Pascerpot
            --  [17666587] = {'qm12', {3109},                                                                                          {}, 17666498}, -- Gnawtooth Gary
            --  [17666588] = {'qm13',     {},     {xi.ki.INGROWN_TAURUS_NAIL, xi.ki.OSSIFIED_GARGOUILLE_HAND, xi.ki.IMBRUED_VAMPYR_FANG}, 17666499}, -- Bukhis
            --  [17666589] = {'qm14',     {},                               {xi.ki.GLOSSY_SEA_MONK_SUCKER, xi.ki.SHIMMERING_PUGIL_SCALE}, 17666500}, -- Sedna
            --  [17666590] = {'qm15',     {}, {xi.ki.DECAYED_DVERGR_TOOTH, xi.ki.PULSATING_SOULFLAYER_BEARD, xi.ki.CHIPPED_IMPS_OLIFANT}, 17666501}, -- Durinn
            --  [17666591] = {'qm16',     {},                                 {xi.ki.MALODOROUS_MARID_FUR, xi.ki.WARPED_SMILODON_CHOKER}, 17666502}, -- Karkadann
            --  [17666592] = {'qm17',     {},     {xi.ki.INGROWN_TAURUS_NAIL, xi.ki.OSSIFIED_GARGOUILLE_HAND, xi.ki.IMBRUED_VAMPYR_FANG}, 17666503}, -- Bukhis
            --  [17666593] = {'qm18',     {},                               {xi.ki.GLOSSY_SEA_MONK_SUCKER, xi.ki.SHIMMERING_PUGIL_SCALE}, 17666504}, -- Sedna
            --  [17666594] = {'qm19',     {}, {xi.ki.DECAYED_DVERGR_TOOTH, xi.ki.PULSATING_SOULFLAYER_BEARD, xi.ki.CHIPPED_IMPS_OLIFANT}, 17666505}, -- Durinn
            --  [17666595] = {'qm20',     {},                                 {xi.ki.MALODOROUS_MARID_FUR, xi.ki.WARPED_SMILODON_CHOKER}, 17666506}, -- Karkadann
            --  [17666596] = {'qm21',     {},     {xi.ki.INGROWN_TAURUS_NAIL, xi.ki.OSSIFIED_GARGOUILLE_HAND, xi.ki.IMBRUED_VAMPYR_FANG}, 17666507}, -- Bukhis
            --  [17666597] = {'qm22',     {},                               {xi.ki.GLOSSY_SEA_MONK_SUCKER, xi.ki.SHIMMERING_PUGIL_SCALE}, 17666508}, -- Sedna
            --  [17666598] = {'qm23',     {}, {xi.ki.DECAYED_DVERGR_TOOTH, xi.ki.PULSATING_SOULFLAYER_BEARD, xi.ki.CHIPPED_IMPS_OLIFANT}, 17666509}, -- Durinn
            --  [17666599] = {'qm24',     {},                                 {xi.ki.MALODOROUS_MARID_FUR, xi.ki.WARPED_SMILODON_CHOKER}, 17666510}, -- Karkadann
        },
    },
}

return zones[xi.zone.ABYSSEA_VUNKERL]
