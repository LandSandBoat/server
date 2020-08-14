-----------------------------------
-- Area: Abyssea-Vunkerl
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ABYSSEA_VUNKERL] =
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
            --  [17666588] = {'qm13',     {},     {tpz.ki.INGROWN_TAURUS_NAIL, tpz.ki.OSSIFIED_GARGOUILLE_HAND, tpz.ki.IMBRUED_VAMPYR_FANG}, 17666499}, -- Bukhis
            --  [17666589] = {'qm14',     {},                               {tpz.ki.GLOSSY_SEA_MONK_SUCKER, tpz.ki.SHIMMERING_PUGIL_SCALE}, 17666500}, -- Sedna
            --  [17666590] = {'qm15',     {}, {tpz.ki.DECAYED_DVERGR_TOOTH, tpz.ki.PULSATING_SOULFLAYER_BEARD, tpz.ki.CHIPPED_IMPS_OLIFANT}, 17666501}, -- Durinn
            --  [17666591] = {'qm16',     {},                                 {tpz.ki.MALODOROUS_MARID_FUR, tpz.ki.WARPED_SMILODON_CHOKER}, 17666502}, -- Karkadann
            --  [17666592] = {'qm17',     {},     {tpz.ki.INGROWN_TAURUS_NAIL, tpz.ki.OSSIFIED_GARGOUILLE_HAND, tpz.ki.IMBRUED_VAMPYR_FANG}, 17666503}, -- Bukhis
            --  [17666593] = {'qm18',     {},                               {tpz.ki.GLOSSY_SEA_MONK_SUCKER, tpz.ki.SHIMMERING_PUGIL_SCALE}, 17666504}, -- Sedna
            --  [17666594] = {'qm19',     {}, {tpz.ki.DECAYED_DVERGR_TOOTH, tpz.ki.PULSATING_SOULFLAYER_BEARD, tpz.ki.CHIPPED_IMPS_OLIFANT}, 17666505}, -- Durinn
            --  [17666595] = {'qm20',     {},                                 {tpz.ki.MALODOROUS_MARID_FUR, tpz.ki.WARPED_SMILODON_CHOKER}, 17666506}, -- Karkadann
            --  [17666596] = {'qm21',     {},     {tpz.ki.INGROWN_TAURUS_NAIL, tpz.ki.OSSIFIED_GARGOUILLE_HAND, tpz.ki.IMBRUED_VAMPYR_FANG}, 17666507}, -- Bukhis
            --  [17666597] = {'qm22',     {},                               {tpz.ki.GLOSSY_SEA_MONK_SUCKER, tpz.ki.SHIMMERING_PUGIL_SCALE}, 17666508}, -- Sedna
            --  [17666598] = {'qm23',     {}, {tpz.ki.DECAYED_DVERGR_TOOTH, tpz.ki.PULSATING_SOULFLAYER_BEARD, tpz.ki.CHIPPED_IMPS_OLIFANT}, 17666509}, -- Durinn
            --  [17666599] = {'qm24',     {},                                 {tpz.ki.MALODOROUS_MARID_FUR, tpz.ki.WARPED_SMILODON_CHOKER}, 17666510}, -- Karkadann
        },
    },
}

return zones[tpz.zone.ABYSSEA_VUNKERL]
