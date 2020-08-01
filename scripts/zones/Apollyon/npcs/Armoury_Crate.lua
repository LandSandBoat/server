-----------------------------------
-- Area: Apollyon
-- NPC:  Armoury Crate
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/limbus")
require("scripts/globals/zone")
local ID = require("scripts/zones/Apollyon/IDs")

local loot =
{
    [1293] =
    {
        --  SE_Apollyon floor 1
        [1] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1939, droprate =  350}, -- RDM
                {itemid = 1941, droprate =  278}, -- THF
                {itemid = 1959, droprate =  174}, -- SMN
                {itemid = 1949, droprate =  200}, -- BRD
                {itemid = 1945, droprate =   47}, -- DRK
                {itemid = 1951, droprate =   49}, -- RNG
                {itemid = 1955, droprate =  200}, -- NIN
                {itemid = 2659, droprate =   62}, -- COR
                {itemid = 2715, droprate =  407}, -- DNC
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1939, droprate =  350}, -- RDM
                {itemid = 1941, droprate =  278}, -- THF
                {itemid = 1959, droprate =  174}, -- SMN
                {itemid = 1949, droprate =  200}, -- BRD
                {itemid = 1945, droprate =   47}, -- DRK
                {itemid = 1951, droprate =   49}, -- RNG
                {itemid = 1955, droprate =  200}, -- NIN
                {itemid = 2659, droprate =   62}, -- COR
                {itemid = 2715, droprate =  407}, -- DNC
            },
        },
        -- SE_Apollyon floor 2
        [2] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1959, droprate =  47}, -- SMN
                {itemid = 1949, droprate =  30}, -- BRD
                {itemid = 1943, droprate = 200}, -- PLD
                {itemid = 1947, droprate = 460}, -- BST
                {itemid = 2661, droprate = 400}, -- PUP
                {itemid = 1951, droprate =  20}, -- RNG
                {itemid = 1955, droprate =  80}, -- NIN
                {itemid = 1945, droprate =  90}, -- DRK
                {itemid = 2659, droprate = 100}, -- COR
                {itemid = 2715, droprate = 120}, -- DNC
            },
            {
                {itemid =    0, droprate = 999}, -- Nothing
                {itemid = 1959, droprate =  47}, -- SMN
                {itemid = 1949, droprate =  30}, -- BRD
                {itemid = 1943, droprate = 200}, -- PLD
                {itemid = 1947, droprate = 460}, -- BST
                {itemid = 2661, droprate = 400}, -- PUP
                {itemid = 1951, droprate =  20}, -- RNG
                {itemid = 1955, droprate =  80}, -- NIN
                {itemid = 1945, droprate =  90}, -- DRK
                {itemid = 2659, droprate = 100}, -- COR
                {itemid = 2715, droprate = 120}, -- DNC
            },
        },
        -- SE_Apollyon floor 3
        [3] =
        {   
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 999}, -- Nothing
                {itemid = 1955, droprate =  59}, -- NIN
                {itemid = 1959, droprate = 139}, -- SMN
                {itemid = 1949, droprate =  39}, -- BRD
                {itemid = 1681, droprate =  39}, -- Light Steel
                {itemid =  645, droprate =  39}, -- Darksteel Ore
                {itemid = 1933, droprate = 627}, -- MNK
            },
            {
                {itemid =    0, droprate = 500}, -- Nothing
                {itemid = 1945, droprate = 159}, -- DRK
                {itemid = 1951, droprate = 139}, -- RNG
                {itemid = 2659, droprate =  39}, -- COR
                {itemid =  664, droprate =  20}, -- Darksteel Sheet
                {itemid =  646, droprate =  20}, -- Adaman Ore
                {itemid = 1931, droprate = 200}, -- WAR
            },
        },
        -- SE_Apollyon floor 4
        [4] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1935, droprate = 220}, -- WHM
                {itemid = 1937, droprate = 300}, -- BLM
                {itemid = 1957, droprate = 260}, -- DRG
                {itemid = 1953, droprate = 340}, -- SAM
                {itemid = 2657, droprate = 220}, -- BLU
                {itemid = 2717, droprate = 180}, -- SCH
                {itemid = 1931, droprate = 300}, -- WAR
            },
            {
                {itemid = 1935, droprate = 220}, -- WHM
                {itemid = 1937, droprate = 300}, -- BLM
                {itemid = 1957, droprate = 260}, -- DRG
                {itemid = 1953, droprate = 340}, -- SAM
                {itemid = 2657, droprate = 220}, -- BLU
                {itemid = 2717, droprate = 180}, -- SCH
                {itemid = 1931, droprate = 300}, -- WAR
            },
            {
                {itemid = 1909, droprate = 1000}, -- Smalt Chip
            },
            {
                {itemid = 2127, droprate =  59}, -- Metal Chip
                {itemid =    0, droprate = 100}, -- Nothing
            },
        },
    },
    [1292] =
    {
        -- NE_Apollyon floor 1
        [1] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1953, droprate = 304}, -- SAM
                {itemid = 1943, droprate =  18}, -- PLD
                {itemid = 1941, droprate = 200}, -- THF
                {itemid = 2715, droprate = 200}, -- DNC
                {itemid = 2661, droprate =  36}, -- PUP
                {itemid = 1933, droprate =  18}, -- MNK
                {itemid = 1939, droprate =  36}, -- RDM
                {itemid = 1935, droprate = 411}, -- WHM
                {itemid = 2717, droprate = 482}, -- SCH
                {itemid = 1947, droprate =  18}, -- BST
            },
            {
                {itemid =    0, droprate = 1000}, -- SAM
                {itemid = 1953, droprate =  304}, -- SAM
                {itemid = 1943, droprate =   18}, -- PLD
                {itemid = 1941, droprate =  200}, -- THF
                {itemid = 2715, droprate =  200}, -- DNC
                {itemid = 2661, droprate =   36}, -- PUP
                {itemid = 1933, droprate =   18}, -- MNK
                {itemid = 1939, droprate =   36}, -- RDM
                {itemid = 1935, droprate =  411}, -- WHM
                {itemid = 2717, droprate =  482}, -- SCH
                {itemid = 1947, droprate =   18}, -- BST
            },
        },
        -- NE_Apollyon floor 2
        [2] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1947, droprate =  26}, -- BST
                {itemid = 1933, droprate =  53}, -- MNK
                {itemid = 1943, droprate =  26}, -- PLD
                {itemid = 2661, droprate =  26}, -- PUP
                {itemid = 1937, droprate = 395}, -- BLM
                {itemid = 1957, droprate = 289}, -- DRG
                {itemid = 1941, droprate =  53}, -- THF
                {itemid = 1939, droprate = 112}, -- RDM
                {itemid = 2657, droprate = 477}, -- BLU
            },
            {
                {itemid =    0, droprate =  1000}, -- Nothing
                {itemid = 1947, droprate =    26}, -- BST
                {itemid = 1933, droprate =    53}, -- MNK
                {itemid = 1943, droprate =    26}, -- PLD
                {itemid = 2661, droprate =    26}, -- PUP
                {itemid = 1937, droprate =   395}, -- BLM
                {itemid = 1957, droprate =   289}, -- DRG
                {itemid = 1941, droprate =    53}, -- THF
                {itemid = 1939, droprate =   112}, -- RDM
                {itemid = 2657, droprate =   477}, -- BLU
            },
        },
        -- NE_Apollyon floor 3
        [3] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1931, droprate =  788}, -- WAR
                {itemid = 1939, droprate =   30}, -- RDM
                {itemid = 1953, droprate =  130}, -- SAM
                {itemid = 1957, droprate =  100}, -- DRG
                {itemid = 1947, droprate =   90}, -- BST
                {itemid = 1933, droprate =   30}, -- MNK
                {itemid = 1941, droprate =   99}, -- THF
                {itemid = 2661, droprate =   61}, -- PUP
                {itemid = 2715, droprate =   30}, -- DNC
                {itemid = 1943, droprate =  160}, -- PLD
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1931, droprate =  788}, -- WAR
                {itemid = 1939, droprate =   30}, -- RDM
                {itemid = 1953, droprate =  130}, -- SAM
                {itemid = 1957, droprate =  100}, -- DRG
                {itemid = 1947, droprate =   90}, -- BST
                {itemid = 1933, droprate =   30}, -- MNK
                {itemid = 1941, droprate =   99}, -- THF
                {itemid = 2661, droprate =   61}, -- PUP
                {itemid = 2715, droprate =   30}, -- DNC
                {itemid = 1943, droprate =  160}, -- PLD
            },
            {
                {itemid =    0, droprate = 180}, -- Nothing
                {itemid = 1633, droprate =  30}, -- Clot Plasma
                {itemid =  821, droprate =  40}, -- Rainbow Thread
                {itemid = 1311, droprate =  50}, -- Oxblood
                {itemid = 1883, droprate =  40}, -- Shell Powder
                {itemid = 2004, droprate =  20}, -- Carapace Powder
            },
            {
                {itemid =    0, droprate = 180}, -- Nothing
                {itemid = 1633, droprate =  30}, -- Clot Plasma
                {itemid =  821, droprate =  40}, -- Rainbow Thread
                {itemid = 1311, droprate =  50}, -- Oxblood
                {itemid = 1883, droprate =  40}, -- Shell Powder
                {itemid = 2004, droprate =  20}, -- Carapace Powder
            },
        },
        -- NE_Apollyon floor 4
        [4] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },  
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1949, droprate = 326}, -- BRD
                {itemid = 1945, droprate = 256}, -- DRK
                {itemid = 1951, droprate = 395}, -- RNG
                {itemid = 1959, droprate = 279}, -- SMN
                {itemid = 1955, droprate = 256}, -- NIN
                {itemid = 2659, droprate = 326}, -- COR
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1949, droprate =  326}, -- BRD
                {itemid = 1945, droprate =  256}, -- DRK
                {itemid = 1951, droprate =  395}, -- RNG
                {itemid = 1959, droprate =  279}, -- SMN
                {itemid = 1955, droprate =  256}, -- NIN
                {itemid = 2659, droprate =  326}, -- COR
            },
        },
        -- NE_Apollyon floor 5
        [5] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },  
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1910, droprate = 1000}, -- Smoky Chip
            },
            {
                {itemid =    0, droprate = 100}, -- Nothing
                {itemid = 2127, droprate =  59}, -- Metal Chip
            },
        },
    },
    [1291] =
    {
        -- SW_Apollyon floor 1
        [1] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1949, droprate = 464}, -- BRD
                {itemid = 1945, droprate = 250}, -- DRK
                {itemid = 1953, droprate = 110}, -- SAM
                {itemid = 1937, droprate =  71}, -- BLM
                {itemid = 1931, droprate = 180}, -- WAR
                {itemid = 2657, droprate = 210}, -- BLU
                {itemid = 2717, droprate = 111}, -- SCH
                {itemid = 1935, droprate = 107}, -- WHM
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1949, droprate =  464}, -- BRD
                {itemid = 1945, droprate =  250}, -- DRK
                {itemid = 1953, droprate =  110}, -- SAM
                {itemid = 1937, droprate =   71}, -- BLM
                {itemid = 1931, droprate =  180}, -- WAR
                {itemid = 2657, droprate =  210}, -- BLU
                {itemid = 2717, droprate =  111}, -- SCH
                {itemid = 1935, droprate =  107}, -- WHM
            },
        },
        -- SW_Apollyon floor 2
        [2] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1951, droprate = 154}, -- RNG
                {itemid = 1935, droprate =  95}, -- WHM
                {itemid = 1959, droprate = 269}, -- SMN
                {itemid = 1937, droprate = 106}, -- BLM
                {itemid = 1931, droprate =  77}, -- WAR
                {itemid = 2659, droprate = 423}, -- COR
                {itemid = 1957, droprate = 110}, -- DRG
            },
            {
                {itemid =    0, droprate = 999}, -- Nothing
                {itemid = 1951, droprate = 154}, -- RNG
                {itemid = 1935, droprate =  95}, -- WHM
                {itemid = 1959, droprate = 269}, -- SMN
                {itemid = 1937, droprate = 106}, -- BLM
                {itemid = 1931, droprate =  77}, -- WAR
                {itemid = 2659, droprate = 423}, -- COR
                {itemid = 1957, droprate = 110}, -- DRG
            },
        },
        -- SW_Apollyon floor 3
        [3] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 120}, -- Nothing
                {itemid = 1931, droprate = 120}, -- WAR
                {itemid = 1955, droprate = 595}, -- NIN
                {itemid = 1957, droprate = 100}, -- DRG
                {itemid = 1937, droprate =  24}, -- BLM
                {itemid = 1953, droprate =  48}, -- SAM
                {itemid = 1935, droprate =  24}, -- WHM
                {itemid = 2657, droprate =  24}, -- BLU
                {itemid = 2717, droprate =  71}, -- SCH
            },
            {
                {itemid =    0, droprate = 120}, -- Nothing
                {itemid = 1931, droprate = 120}, -- WAR
                {itemid = 1955, droprate = 595}, -- NIN
                {itemid = 1957, droprate = 100}, -- DRG
                {itemid = 1937, droprate =  24}, -- BLM
                {itemid = 1953, droprate =  48}, -- SAM
                {itemid = 1935, droprate =  24}, -- WHM
                {itemid = 2657, droprate =  24}, -- BLU
                {itemid = 2717, droprate =  71}, -- SCH
            }, 
            {
                {itemid =    0, droprate = 638}, -- Nothing
                {itemid = 1311, droprate =  32}, -- Oxblood
                {itemid = 1883, droprate =  40}, -- Shell Powder
                {itemid = 1681, droprate =  31}, -- Light Steel
                {itemid = 1633, droprate =  71}, -- Clot Plasma
                {itemid =  645, droprate =  31}, -- Darksteel Ore
                {itemid =  664, droprate =  63}, -- Darksteel Sheet
                {itemid =  646, droprate =  31}, -- Adaman Ore
                {itemid =  821, droprate =  63}, -- Rainbow Thread
            },
        },
        -- SW_Apollyon floor 4
        [4] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1941, droprate = 468}, -- THF
                {itemid = 1947, droprate = 340}, -- BST
                {itemid = 1933, droprate = 255}, -- MNK
                {itemid = 1939, droprate = 191}, -- RDM
                {itemid = 1943, droprate = 170}, -- PLD
                {itemid = 2661, droprate = 340}, -- PUP
                {itemid = 2715, droprate = 170}, -- DNC
            },
            {
                {itemid =    0, droprate = 400}, -- Nothing
                {itemid = 1941, droprate = 468}, -- THF
                {itemid = 1947, droprate = 340}, -- BST
                {itemid = 1933, droprate = 255}, -- MNK
                {itemid = 1939, droprate = 191}, -- RDM
                {itemid = 1943, droprate = 170}, -- PLD
                {itemid = 2661, droprate = 340}, -- PUP
                {itemid = 2715, droprate = 170}, -- DNC
            },
            {
                {itemid = 1987, droprate = 1000}, -- Charcoal Chip
            },
            {
                {itemid = 2127, droprate =  59}, -- Metal Chip
                {itemid =    0, droprate = 100}, -- Nothing
            },
        },
    },
    [1290] =
    {
        -- NW_Apollyon floor 1
        [1] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 100}, -- Nothing
                {itemid = 1937, droprate =  25}, -- BLM
                {itemid = 2657, droprate = 175}, -- BLU
                {itemid = 1957, droprate = 100}, -- DRG
                {itemid = 1943, droprate =  25}, -- PLD
                {itemid = 1953, droprate = 250}, -- SAM
                {itemid = 2717, droprate =  75}, -- SCH
                {itemid = 1931, droprate = 225}, -- WAR
                {itemid = 1935, droprate =  50}, -- WHM
            },
        },
        -- NW_Apollyon floor 2
        [2] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 100}, -- Nothing
                {itemid = 1943, droprate = 235}, -- PLD
                {itemid = 2659, droprate =  59}, -- COR
                {itemid = 1945, droprate = 235}, -- DRK
                {itemid = 1955, droprate = 147}, -- NIN
                {itemid = 1951, droprate = 118}, -- RNG
                {itemid = 1959, droprate = 176}, -- SMN
                {itemid = 1935, droprate = 110}, -- WHM
            },
        },
        -- NW_Apollyon floor 3
        [3] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
                {itemid =    0, droprate = 1000}, -- Nothing
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
                {itemid =    0, droprate = 1000}, -- Nothing
            },
            {   
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
                {itemid =    0, droprate = 1000}, -- Nothing
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
                {itemid =    0, droprate = 1000}, -- Nothing
            },  
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
                {itemid =    0, droprate = 1000}, -- Nothing
            },
            {
                {itemid = 1947, droprate = 133}, -- BST
                {itemid = 1933, droprate = 133}, -- MNK
                {itemid = 1943, droprate = 133}, -- PLD
                {itemid = 2661, droprate = 133}, -- PUP
                {itemid = 1939, droprate = 110}, -- RDM
                {itemid = 1941, droprate = 400}, -- THF
            },
            {
                {itemid =    0, droprate = 400}, -- Nothing
                {itemid =  646, droprate =  50}, -- Adaman Ore
                {itemid = 1633, droprate =  50}, -- Clot Plasma
                {itemid =  664, droprate =  50}, -- Darksteel Sheet
                {itemid =  645, droprate =  50}, -- Darksteel Ore
                {itemid = 1311, droprate =  50}, -- Oxblood
                {itemid = 1681, droprate =  50}, -- Light Steel
                {itemid =  821, droprate =  50}, -- Rainbow Thread
                {itemid = 1883, droprate =  50}, -- Shell Powder
            },
            {
                {itemid =    0, droprate = 400}, -- Nothing
                {itemid =  646, droprate =  50}, -- Adaman Ore
                {itemid = 1633, droprate =  50}, -- Clot Plasma
                {itemid =  664, droprate =  50}, -- Darksteel Sheet
                {itemid =  645, droprate =  50}, -- Darksteel Ore
                {itemid = 1311, droprate =  50}, -- Oxblood
                {itemid = 1681, droprate =  50}, -- Light Steel
                {itemid =  821, droprate =  50}, -- Rainbow Thread
                {itemid = 1883, droprate =  50}, -- Shell Powder
            },
        },
        -- NW_Apollyon floor 4
        [4] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },  
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
                {itemid =    0, droprate = 1000}, -- Nothing
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
                {itemid =    0, droprate = 1000}, -- Nothing
            },
            {
                {itemid =    0, droprate = 100}, -- Nothing
                {itemid = 1937, droprate =  80}, -- BLM
                {itemid = 2657, droprate =  70}, -- BLU
                {itemid = 1949, droprate =  48}, -- BRD
                {itemid = 1947, droprate =  30}, -- BST
                {itemid = 2659, droprate =  25}, -- COR
                {itemid = 1957, droprate =  19}, -- DRG
                {itemid = 1945, droprate =  48}, -- DRK
                {itemid = 1933, droprate =  90}, -- MNK
                {itemid = 1955, droprate = 100}, -- NIN
                {itemid = 2661, droprate =  48}, -- PUP
                {itemid = 1939, droprate = 136}, -- RDM
                {itemid = 1951, droprate =  80}, -- RNG
                {itemid = 1953, droprate = 110}, -- SAM
                {itemid = 1959, droprate =  95}, -- SMN
                {itemid = 2715, droprate = 123}, -- DNC
                {itemid = 1935, droprate =  48}, -- WHM
            },
        },
        -- NW_Apollyon floor 5
        [5] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1937, droprate = 109}, -- BLM
                {itemid = 2657, droprate = 152}, -- BLU
                {itemid = 1949, droprate = 283}, -- BRD
                {itemid = 1947, droprate = 109}, -- BST
                {itemid = 2659, droprate =  65}, -- COR
                {itemid = 2715, droprate = 130}, -- DNC
                {itemid = 1957, droprate =  65}, -- DRG
                {itemid = 1945, droprate = 174}, -- DRK
                {itemid = 1933, droprate = 130}, -- MNK
                {itemid = 1955, droprate = 196}, -- NIN
                {itemid = 1943, droprate = 174}, -- PLD
                {itemid = 2661, droprate = 174}, -- PUP
                {itemid = 1939, droprate = 109}, -- RDM
                {itemid = 1951, droprate = 130}, -- RNG
                {itemid = 1953, droprate = 304}, -- SAM
                {itemid = 2717, droprate =  87}, -- SCH
                {itemid = 1959, droprate = 217}, -- SMN
                {itemid = 1941, droprate = 174}, -- THF
                {itemid = 1931, droprate = 130}, -- WAR
                {itemid = 1935, droprate = 109}, -- WHM
            },
            {
                {itemid = 1937, droprate = 109}, -- BLM
                {itemid = 2657, droprate = 152}, -- BLU
                {itemid = 1949, droprate = 283}, -- BRD
                {itemid = 1947, droprate = 109}, -- BST
                {itemid = 2659, droprate =  65}, -- COR
                {itemid = 2715, droprate = 130}, -- DNC
                {itemid = 1957, droprate =  65}, -- DRG
                {itemid = 1945, droprate = 174}, -- DRK
                {itemid = 1933, droprate = 130}, -- MNK
                {itemid = 1955, droprate = 196}, -- NIN
                {itemid = 1943, droprate = 174}, -- PLD
                {itemid = 2661, droprate = 174}, -- PUP
                {itemid = 1939, droprate = 109}, -- RDM
                {itemid = 1951, droprate = 130}, -- RNG
                {itemid = 1953, droprate = 304}, -- SAM
                {itemid = 2717, droprate =  87}, -- SCH
                {itemid = 1959, droprate = 217}, -- SMN
                {itemid = 1941, droprate = 174}, -- THF
                {itemid = 1931, droprate = 130}, -- WAR
                {itemid = 1935, droprate = 109}, -- WHM
            },
            {
                {itemid =    0, droprate = 300}, -- Nothing
                {itemid = 1937, droprate = 109}, -- BLM
                {itemid = 2657, droprate = 152}, -- BLU
                {itemid = 1949, droprate = 283}, -- BRD
                {itemid = 1947, droprate = 109}, -- BST
                {itemid = 2659, droprate =  65}, -- COR
                {itemid = 2715, droprate = 130}, -- DNC
                {itemid = 1957, droprate =  65}, -- DRG
                {itemid = 1945, droprate = 174}, -- DRK
                {itemid = 1933, droprate = 130}, -- MNK
                {itemid = 1955, droprate = 196}, -- NIN
                {itemid = 1943, droprate = 174}, -- PLD
                {itemid = 2661, droprate = 174}, -- PUP
                {itemid = 1939, droprate = 109}, -- RDM
                {itemid = 1951, droprate = 130}, -- RNG
                {itemid = 1953, droprate = 304}, -- SAM
                {itemid = 2717, droprate =  87}, -- SCH
                {itemid = 1959, droprate = 217}, -- SMN
                {itemid = 1941, droprate = 174}, -- THF
                {itemid = 1931, droprate = 130}, -- WAR
                {itemid = 1935, droprate = 109}, -- WHM
            },
            {
                {itemid = 1988, droprate = 1000}, -- Magenta Chip
            },
            {
                {itemid = 2127, droprate =  59}, -- Metal Chip
                {itemid =    0, droprate = 100}, -- Nothing
            },
        },
    },
    [1294] =
    {
        -- CS_Apollyon
        [1] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 2127, droprate =  59}, -- Metal Chip
                {itemid =    0, droprate = 100}, -- Nothing
            },
        },
    },
    [1296] =
    {
        -- omega
        [1] =
        {
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid =    0, droprate = 1000}, -- Nothing
                {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
            },
            {
                {itemid = 1925, droprate = 659}, -- Omega's Eye
                {itemid = 1927, droprate = 394}, -- Omega's Foreleg
                {itemid = 1928, droprate = 388}, -- Omega's Hinf Leg
                {itemid = 1929, droprate = 404}, -- Omega's Tail
            },
            {
                {itemid = 1928, droprate = 394}, -- Omega's Hind Leg
                {itemid = 1929, droprate = 402}, -- Omega's Tail
                {itemid = 1925, droprate = 659}, -- Omega's Eye
                {itemid = 1927, droprate = 383}, -- Omega's Foreleg
            },
            {
                {itemid =    0, droprate = 735}, -- Nothing
                {itemid = 1926, droprate = 265}, -- Omega's Heart
            },
        },
    },
}

function onTrade(player,npc,trade)
end

function onTrigger(player, npc)
    local battlefield = player:getBattlefield()
    if not battlefield then
        return
    end
    local crateID = npc:getID()
    local model = npc:getModelId()
    local X = npc:getXPos()
    local Y = npc:getYPos()
    local Z = npc:getZPos()
    local bfid = battlefield:getID()
    local hold = false
    if npc:getLocalVar("open") == 0 then
        switch (bfid): caseof 
        {
            [1290] = function() -- NW Apollyon Crate Handling
                if crateID ~= ID.npc.APOLLYON_NW_CRATE[5] then
                    for i = 1, 4 do
                        for j = 1, 5 do
                            if crateID == ID.npc.APOLLYON_NW_CRATE[i][j] then
                                if model == 960 then
                                    tpz.battlefield.HealPlayers(battlefield)
                                elseif model == 961 then
                                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                elseif model == 962 then
                                    tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.APOLLYON)
                                end
                            end
                        end
                    end
                else
                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][5], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
            [1291] = function() -- SW Apollyon Crate Handling
                if crateID ~= ID.npc.APOLLYON_SW_CRATE[4] then
                    for i = 1, 3 do
                        if i == 3 then
                            local mimicSpawned = battlefield:getLocalVar("mimicSpawned")
                            if mimicSpawned ~= 7 then
                                local timePH = battlefield:getLocalVar("timePH")
                                local restorePH = battlefield:getLocalVar("restorePH")
                                local itemPH = battlefield:getLocalVar("itemPH")
                                for j = 0, 9 do
                                    if crateID == ID.npc.APOLLYON_SW_CRATE[i]+j then
                                        if crateID == restorePH then
                                            tpz.battlefield.HealPlayers(battlefield)
                                        elseif crateID == itemPH then
                                            tpz.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                        elseif crateID == timePH then
                                            tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.APOLLYON)
                                        else
                                            if mimicSpawned == 0 or mimicSpawned == 2 or mimicSpawned == 4 or mimicSpawned == 6 then
                                                npc:setStatus(tpz.status.DISAPPEAR)
                                                battlefield:setLocalVar("mimicSpawned", mimicSpawned+1)
                                                GetMobByID(ID.mob.APOLLYON_SW_MOB[3]):setSpawn(X, Y, Z)
                                                SpawnMob(ID.mob.APOLLYON_SW_MOB[3]):setPos(X, Y, Z)
                                                GetMobByID(ID.mob.APOLLYON_SW_MOB[3]):updateClaim(player)
                                            elseif mimicSpawned == 1 or mimicSpawned == 5 then
                                                npc:setStatus(tpz.status.DISAPPEAR)
                                                battlefield:setLocalVar("mimicSpawned", mimicSpawned+2)
                                                GetMobByID(ID.mob.APOLLYON_SW_MOB[3]+1):setSpawn(X, Y, Z)
                                                SpawnMob(ID.mob.APOLLYON_SW_MOB[3]+1):setPos(X, Y, Z)
                                                GetMobByID(ID.mob.APOLLYON_SW_MOB[3]+1):updateClaim(player)
                                            elseif mimicSpawned == 3 then
                                                npc:setStatus(tpz.status.DISAPPEAR)
                                                battlefield:setLocalVar("mimicSpawned", mimicSpawned+4)
                                                GetMobByID(ID.mob.APOLLYON_SW_MOB[3]+2):setSpawn(X, Y, Z)
                                                SpawnMob(ID.mob.APOLLYON_SW_MOB[3]+2):setPos(X, Y, Z)
                                                GetMobByID(ID.mob.APOLLYON_SW_MOB[3]+2):updateClaim(player)
                                            end
                                        end
                                    end
                                end
                            else
                                hold = true
                            end
                        else
                            for j = 0, 2 do
                                if crateID == ID.npc.APOLLYON_SW_CRATE[i]+j then
                                    if j ~= 0 then GetNPCByID(ID.npc.APOLLYON_SW_CRATE[i]):setStatus(tpz.status.DISAPPEAR) end
                                    if j ~= 1 then GetNPCByID(ID.npc.APOLLYON_SW_CRATE[i]+1):setStatus(tpz.status.DISAPPEAR) end
                                    if j ~= 2 then GetNPCByID(ID.npc.APOLLYON_SW_CRATE[i]+2):setStatus(tpz.status.DISAPPEAR) end
                                    if model == 960 then
                                        tpz.battlefield.HealPlayers(battlefield)
                                    elseif model == 961 then
                                        tpz.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                    elseif model == 962 then
                                        tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.APOLLYON)
                                    end
                                end
                            end
                        end
                    end
                else
                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][4], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
            [1292] = function() -- NE Apollyon Crate Handling
                if crateID ~= ID.npc.APOLLYON_NE_CRATE[5] then
                    for i = 1, 4 do
                        for j = 1, 5 do
                            if crateID == ID.npc.APOLLYON_NE_CRATE[i][j] then
                                if model == 960 then
                                    tpz.battlefield.HealPlayers(battlefield)
                                elseif model == 961 then
                                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                elseif model == 962 then
                                    tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.APOLLYON)
                                end
                            end
                        end
                    end
                else
                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][5], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
            [1293] = function() -- SE Apollyon Crate Handling
                if crateID ~= ID.npc.APOLLYON_SE_CRATE[4] then
                    for i = 1, 3 do
                        for j = 0, 2 do
                            if crateID == ID.npc.APOLLYON_SE_CRATE[i]+j then
                                if model == 960 then
                                    tpz.battlefield.HealPlayers(battlefield)
                                elseif model == 961 then
                                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                elseif model == 962 then
                                    tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.APOLLYON)
                                end
                            end
                        end
                    end
                else
                    for i = 1, 8 do
                        GetMobByID(ID.mob.APOLLYON_SE_MOB[4]+i):setStatus(tpz.status.DISAPPEAR)
                    end
                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][4], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
            [1294] = function() -- CS Apollyon Crate Handling
                if crateID ~= ID.npc.APOLLYON_CS_CRATE then
                    tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.APOLLYON)
                else
                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][1], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
            [1296] = function() -- Central Apollyon Crate Handling
                tpz.limbus.handleLootRolls(battlefield, loot[bfid][1], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
        }
        if not hold then
            npc:entityAnimationPacket("open")
            npc:setLocalVar("open", 1)
            npc:timer(15000, function(npc)
                npc:entityAnimationPacket("kesu")
            end)
            npc:timer(16000, function(npc)
                npc:setStatus(tpz.status.DISAPPEAR)
                npc:timer(500, function(mob)
                    npc:setLocalVar("open", 0)
                end)
            end)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
