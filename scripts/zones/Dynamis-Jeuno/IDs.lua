-----------------------------------
-- Area: Dynamis-Jeuno
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.DYNAMIS_JEUNO] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6390, -- Obtained: <item>.
        GIL_OBTAINED            = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7063, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN      = 7222, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND     = 7223, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1   = 7224, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2   = 7225, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED    = 7227, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE        = 7239, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            {minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = {17547301, 17547302, 17547303}},
            {minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = 17547389},
            {minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = 17547390},
            {minutes = 15, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = 17547420},
            {minutes = 15, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = 17547467},
        },
        REFILL_STATUE =
        {
            {
                {mob = 17547295, eye = xi.dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547296, eye = xi.dynamis.eye.BLUE },
                {mob = 17547297, eye = xi.dynamis.eye.GREEN},
            },
            {
                {mob = 17547391, eye = xi.dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547392, eye = xi.dynamis.eye.BLUE },
                {mob = 17547393, eye = xi.dynamis.eye.GREEN},
            },
            {
                {mob = 17547421, eye = xi.dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547422, eye = xi.dynamis.eye.BLUE },
                {mob = 17547423, eye = xi.dynamis.eye.GREEN},
            },
            {
                {mob = 17547456, eye = xi.dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547457, eye = xi.dynamis.eye.BLUE },
                {mob = 17547458, eye = xi.dynamis.eye.GREEN},
            },
        },
        -- https://www.dropbox.com/s/p3zpuq93bs2vw90/Dynamis%20Jeuno%20IDs%20Groups%20Mechanics.zip?dl=0
        REFILL_MOB_GROUP =
        {
            {mob = {17547304, 17547305}}, -- WAR or THF
            {mob = 17547306}, -- RNG
            {mob = {17547307, 17547308}}, -- PLD or WHM
            {mob = 17547309}, -- THF
            {mob = 17547310}, -- RDM
            {mob = {17547383, 17547384}}, -- SAM or NIN
            {mob = {17547385, 17547386}}, -- WHM or BRD
            {mob = {17547375, 17547376}}, -- MNK or DRK
            {mob = 17547379}, -- WAR
            {mob = 17547380}, -- WHM
            {mob = {17547270, 17547271}}, -- BLM or RDM
            {mob = 17547272}, -- BST
            {mob = 17547371}, -- PLD
            {mob = {17547372, 17547373}}, -- BLM or SMN
            {mob = {17547367, 17547368}}, -- SAM or NIN
            {mob = 17547369}, -- BST
            {mob = {17547363, 17547364}}, -- WAR or PLD
            {mob = 17547365}, -- BST
            {mob = {17547360, 17547362}}, -- THF or RNG
            {mob = 17547361}, -- DRK
            {mob = 17547357}, -- WAR
            {mob = {17547358, 17547359}}, -- BLM or BRD
            {mob = 17547350}, -- MNK
            {mob = {17547351, 17547352}}, -- WHM or DRK
            {mob = {17547353, 17547354}}, -- PLD or NIN
            {mob = 17547346}, -- RNG
            {mob = {17547347, 17547348}}, -- RNG or BST
            {mob = 17547343}, -- MNK
            {mob = {17547344, 17547345}}, -- RDM or BRD
            {mob = {17547339, 17547340}}, -- THF or RNG
            {mob = 17547341}, -- BST
            {mob = {17547334, 17547336}}, -- WHM or RDM
            {mob = 17547335}, -- BLM
            {mob = {17547330, 17547331}}, -- SAM or BRD
            {mob = {17547325, 17547326}}, -- THF or BRD
            {mob = {17547332, 17547327}}, -- DRG or SMN
            {mob = {17547319, 17547321}}, -- WHM or RDM
            {mob = 17547320}, -- BLM
            {mob = {17547314, 17547315, 17547316}}, -- WAR or MNK or SAM
            {mob = 17547317}, -- SMN
            {mob = {17547285, 17547288}}, -- RNG or SAM
            {mob = 17547286}, -- SMN
            {mob = {17547289, 17547290}}, -- PLD or NIN
            {mob = 17547274}, -- DRK
            {mob = {17547275, 17547276}}, -- PLD or NIN
            {mob = 17547278}, -- MNK
            {mob = {17547279, 17547280}}, -- WHM or BRD
            {mob = {17547292, 17547293}}, -- PLD or NIN
            {mob = {17547281, 17547282}}, -- DRK or DRG
            {mob = 17547284}, -- RDM
            {mob = {17547398, 17547400}}, -- WAR or THF
            {mob = 17547399}, -- MNK
            {mob = 17547401}, -- WHM
            {mob = {17547403, 17547404}}, -- WAR or MNK
            {mob = 17547405}, -- THF
            {mob = 17547406}, -- BLM
            {mob = {17547408, 17547409}}, -- WAR or MNK
            {mob = {17547414, 17547415}}, -- WAR or MNK
            {mob = {17547416, 17547417}}, -- WHM or BLM
            {mob = {17547418, 17547419}}, -- RDM or THF
            {mob = 17547410}, -- THF
            {mob = {17547411, 17547412, 17547413}}, -- RDM or WHM or BLM
            {mob = 17547425}, -- DRK
            {mob = {17547426, 17547428}}, -- DRG or BST
            {mob = 17547430}, -- BRD
            {mob = 17547431}, -- SAM
            {mob = 17547432}, -- PLD
            {mob = 17547433}, -- BRD
            {mob = 17547436}, -- SMN
            {mob = {17547435, 17547434}}, -- SAM or DRK
            {mob = {17547441, 17547442}}, -- DRK or SAM
            {mob = 17547443}, -- SMN
            {mob = 17547445}, -- BRD
            {mob = 17547446}, -- SAM
            {mob = 17547447}, -- PLD
            {mob = 17547448}, -- BRD
            {mob = 17547449}, -- DRK
            {mob = {17547450, 17547452}}, -- BST or DRG
            {mob = 17547459}, -- RNG
            {mob = 17547460}, -- NIN
            {mob = 17547461}, -- RNG
            {mob = 17547462}, -- NIN
            {mob = 17547463}, -- RNG
            {mob = 17547464}, -- NIN
            {mob = 17547465}, -- RNG
            {mob = 17547466}, -- NIN
            {mob = {17547469, 17547470, 17547471}}, -- WAR or MNK or THF
            {mob = {17547475, 17547476, 17547477}}, -- WHM or BLM or RDM
            {mob = {17547481, 17547482, 17547483}}, -- PLD or DRK or BST
            {mob = 17547489}, -- RNG
            {mob = 17547491}, -- NIN
            {mob = {17547377, 17547381, 17547387, 17547378, 17547382, 17547388}}, -- Buffrix Eargone or Humnox Drumbelly
            {mob = {17547298, 17547299, 17547300}}, -- Smeltix Thickhide or Jabkix Pigeonpecs or Wasabix Callusdigit
            {mob = {17547322, 17547337}}, -- Morgmox Moldnoggin
            {mob = {17547324, 17547329}}, -- Sparkpox Sweatbrow
            {mob = {17547394, 17547395, 17547396}}, -- Ticktox Beadeyes or Lurklox Dhalmelneck or Trailblix Goatmug
            {mob = {17547355, 17547356}}, -- Elixmix Hooknose or Bandrix Rockjaw
            {mob = {17547402, 17547407}}, -- Kikklix Longslegs
            {mob = {17547424, 17547440}}, -- Karashix Swollenskull
        },
        HERMITRIX_TOOTHROT_PH      = {[17547310] = 17547311}, -- Vanguard_Enchanter
        GABBLOX_MAGPIETONGUE_PH    = {[17547275] = 17547277}, -- Vanguard_Armorer
        TUFFIX_LOGLIMBS_PH         = {[17547289] = 17547291}, -- Vanguard_Armorer
        CLOKTIX_LONGNAIL_PH        = {[17547292] = 17547294}, -- Vanguard_Armorer
        WYRMWIX_SNAKESPECS_PH      = {[17547321] = 17547312}, -- Vanguard_Enchanter
        RUTRIX_HAMGAMS_PH          = {[17547452] = 17547454}, -- Vanguard_Dragontamer
        MORTILOX_WARTPAWS_PH       = {[17547443] = 17547438}, -- Vanguard_Necromancer
        SLYSTIX_MEGAPEEPERS_PH     = {[17547491] = 17547492}, -- Vanguard_Hitman
        PROWLOX_BARRELBELLY_PH     = {[17547489] = 17547490}, -- Vanguard_Ambusher
        SCRUFFIX_SHAGGYCHEST_PH    = {[17547481] = 17547485}, -- Vanguard_Armorer
        TYMEXOX_NINEFINGERS_PH     = {[17547482] = 17547486}, -- Vanguard_Tinkerer
        BLAZOX_BONEYBOD_PH         = {[17547483] = 17547487}, -- Vanguard_Pathfinder
        ANVILIX_SOOTWRISTS_PH      = {[17547469] = 17547472}, -- Vanguard_Smithy
        BOOTRIX_JAGGEDELBOW_PH     = {[17547470] = 17547473}, -- Vanguard_Pitfighter
        MOBPIX_MUCOUSMOUTH_PH      = {[17547471] = 17547474}, -- Vanguard_Welldigger
        DISTILIX_STICKYTOES_PH     = {[17547475] = 17547478}, -- Vanguard_Alchemist
        EREMIX_SNOTTYNOSTRIL_PH    = {[17547476] = 17547479}, -- Vanguard_Shaman
        JABBROX_GRANNYGUISE_PH     = {[17547477] = 17547480}, -- Vanguard_Enchanter
    },
    npc =
    {
        QM =
        {
            [17547509] =
            {
                param = {3356, 3419, 3420, 3421, 3422, 3423},
                trade =
                {
                    {item = 3356,                           mob = 17547265}, -- Goblin Golem
                    {item = {3419, 3420, 3421, 3422, 3423}, mob = 17547499}, -- Arch Goblin Golem
                }
            },
            [17547510] = {trade = {{item = 3392, mob = 17547493}}}, -- Quicktrix Hexhands
            [17547511] = {trade = {{item = 3393, mob = 17547494}}}, -- Feralox Honeylips
            [17547512] = {trade = {{item = 3394, mob = 17547496}}}, -- Scourquix Scaleskin
            [17547513] = {trade = {{item = 3395, mob = 17547498}}}, -- Wilywox Tenderpalm
        },
    },
}

return zones[xi.zone.DYNAMIS_JEUNO]
