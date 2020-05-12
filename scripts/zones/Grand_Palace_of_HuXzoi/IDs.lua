-----------------------------------
-- Area: Grand_Palace_of_HuXzoi
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.GRAND_PALACE_OF_HUXZOI] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CONQUEST_BASE           = 7071, -- Tallying conquest results...
        HOMEPOINT_SET           = 7453, -- Home point set!
    },
    mob =
    {
        JAILER_OF_TEMPERANCE_PH =
        {
            16916489, -- -420 -1 757
            16916508, --  -43 -1 460
            16916525, -- -260 -1.5 43
            16916541, -- -580 -1.5 43
            16916560, -- -797 -1.5 460
        },
        IXGHRAH                 = 16916813,
        JAILER_OF_TEMPERANCE    = 16916814,
        IXAERN_MNK              = 16916815,
    },
    npc =
    {
        IXAERN_MNK_QM = 16916819,
    },
}

return zones[tpz.zone.GRAND_PALACE_OF_HUXZOI]
