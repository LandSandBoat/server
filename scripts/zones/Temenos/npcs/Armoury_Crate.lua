-----------------------------------
-- Area: Temenos
-- NPC:  Armoury Crate
-----------------------------------

require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/limbus")

-----------------------------------

local loot =
{
    -- northern tower floor 1
    [130] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1954, droprate = 159},
            {itemid = 1940, droprate = 146},
            {itemid = 1932, droprate = 85},
            {itemid = 1956, droprate = 171},
            {itemid = 1934, droprate = 110},
            {itemid = 2658, droprate = 220},
            {itemid = 2716, droprate = 98},
        },
    },
    -- northern tower floor 2
    [131] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1932, droprate = 333},
            {itemid = 1954, droprate = 200},
            {itemid = 1950, droprate = 100},
            {itemid = 1940, droprate = 90},
            {itemid = 1942, droprate = 70},
            {itemid = 1934, droprate = 90},
            {itemid = 1936, droprate = 100},
            {itemid = 1958, droprate = 90},
            {itemid = 2656, droprate = 67},
            {itemid = 1956, droprate = 167},
        },
    },
    -- northern tower floor 3
    [132] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1956, droprate = 27},
            {itemid = 1932, droprate = 324},
            {itemid = 1950, droprate = 80},
            {itemid = 1934, droprate = 189},
            {itemid = 1930, droprate = 50},
        },
        {
            {itemid = 1940, droprate = 27},
            {itemid = 1936, droprate = 81},
            {itemid = 1944, droprate = 80},
            {itemid = 1958, droprate = 81},
            {itemid = 2658, droprate = 270},
            {itemid = 2714, droprate = 108},
        },
    },
    -- northern tower floor 4
    [133] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1942, droprate = 90},
            {itemid = 1934, droprate = 435},
            {itemid = 1956, droprate = 80},
            {itemid = 1940, droprate = 174},
            {itemid = 1958, droprate = 87},
            {itemid = 1954, droprate = 90},
            {itemid = 1936, droprate = 87},
            {itemid = 1930, droprate = 43},
            {itemid = 2656, droprate = 27},
            {itemid = 2658, droprate = 261},
        },
    },
    -- northern tower floor 5
    [134] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1954, droprate = 67},
            {itemid = 1940, droprate = 353},
            {itemid = 1936, droprate = 87},
            {itemid = 1956, droprate = 110},
            {itemid = 1958, droprate = 87},
            {itemid = 1942, droprate = 50},
            {itemid = 1950, droprate = 60},
            {itemid = 1932, droprate = 59},
            {itemid = 2716, droprate = 100},
            {itemid = 2714, droprate = 110},
        },
    },
    -- northern tower floor 6
    [135] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1954, droprate = 263},
            {itemid = 1932, droprate = 59},
            {itemid = 1942, droprate = 53},
            {itemid = 1934, droprate = 60},
            {itemid = 1956, droprate = 526},
        },
        {
            {itemid = 1930, droprate = 60},
            {itemid = 1936, droprate = 53},
            {itemid = 1950, droprate = 158},
            {itemid = 2716, droprate = 105},
        },
    },
    -- northern tower floor 7
    [136] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1956, droprate = 240},
            {itemid = 1932, droprate = 120},
            {itemid = 1940, droprate = 200},
        },
        {
            {itemid = 1934, droprate = 40},
            {itemid = 1954, droprate = 120},
            {itemid = 2658, droprate = 200},
            {itemid = 2716, droprate = 80},
        },
        {
            {itemid = 1875, droprate = 100},
            {itemid = 2127, droprate = 55},
        },
        {
            {itemid = 1904, droprate = 1000},
        },
    },
    -- western tower floor 1
    [137] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1948, droprate = 172},
            {itemid = 1938, droprate = 138},
            {itemid = 1952, droprate = 138},
            {itemid = 1958, droprate = 207},
            {itemid = 1930, droprate = 241},
            {itemid = 2656, droprate = 172},
        },
    },
    -- western tower floor 2
    [138] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1948, droprate = 179},
            {itemid = 1938, droprate = 571},
            {itemid = 1944, droprate = 71},
            {itemid = 1952, droprate = 179},
        },
        {
            {itemid = 1946, droprate = 120},
            {itemid = 1934, droprate = 71},
            {itemid = 1930, droprate = 143},
            {itemid = 2660, droprate = 143},
        },
    },
    -- western tower floor 3
    [139] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1948, droprate = 536},
            {itemid = 1952, droprate = 107},
            {itemid = 1938, droprate = 60},
            {itemid = 1934, droprate = 110},
            {itemid = 1930, droprate = 80},
            {itemid = 2660, droprate = 90},
        },
        {
            {itemid = 1946, droprate = 71},
            {itemid = 1944, droprate = 103},
            {itemid = 1958, droprate = 160},
            {itemid = 1954, droprate = 36},
            {itemid = 2656, droprate = 250},
            {itemid = 2716, droprate = 350},
        },
    },
    -- western tower floor 4
    [140] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1952, droprate = 533},
            {itemid = 1946, droprate = 90},
            {itemid = 1938, droprate = 133},
            {itemid = 1932, droprate = 90},
        },
        {
            {itemid = 1958, droprate = 10},
            {itemid = 1954, droprate = 133},
            {itemid = 1944, droprate = 133},
            {itemid = 1930, droprate = 133},
            {itemid = 2660, droprate = 33},
        },
    },
    -- western tower floor 5
    [141] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1954, droprate = 59},
            {itemid = 1930, droprate = 294},
            {itemid = 1946, droprate = 59},
            {itemid = 1934, droprate = 78},
            {itemid = 2716, droprate = 59},
        },
        {
            {itemid = 1958, droprate = 176},
            {itemid = 1938, droprate = 59},
            {itemid = 1948, droprate = 25},
            {itemid = 1932, droprate = 118},
            {itemid = 2656, droprate = 294},
        },
    },
    -- western tower floor 6
    [142] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1954, droprate = 200},
            {itemid = 1958, droprate = 400},
            {itemid = 1948, droprate = 100},
            {itemid = 1934, droprate = 150},
        },
        {
            {itemid = 1932, droprate = 50},
            {itemid = 1930, droprate = 60},
            {itemid = 1938, droprate = 200},
            {itemid = 1944, droprate = 60},
            {itemid = 1952, droprate = 200},
        },
    },
    -- western tower floor 7
    [143] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1948, droprate = 36},
            {itemid = 1952, droprate = 143},
            {itemid = 1930, droprate = 143},
            {itemid = 1958, droprate = 214},
            {itemid = 1938, droprate = 71},
            {itemid = 2656, droprate = 321},
        },
        {
            {itemid = 1875, droprate = 100},
            {itemid = 2127, droprate = 55},
        },
        {
            {itemid = 1906, droprate = 1000},
        },
    },
    -- eastern tower floor 1
    [144] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1944, droprate = 65},
            {itemid = 1936, droprate = 97},
            {itemid = 1946, droprate = 40},
            {itemid = 1942, droprate = 95},
            {itemid = 2660, droprate = 194},
            {itemid = 2714, droprate = 32},
            {itemid = 1950, droprate = 161},
            {itemid = 2716, droprate = 190},
            {itemid = 2656, droprate = 210},
        },
    },
    -- eastern tower floor 2
    [145] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1936, droprate = 367},
            {itemid = 1952, droprate = 70},
            {itemid = 1950, droprate = 40},
            {itemid = 1942, droprate = 333},
            {itemid = 1958, droprate = 20},
        },
        {
            {itemid = 1956, droprate = 106},
            {itemid = 1938, droprate = 33},
            {itemid = 1944, droprate = 76},
            {itemid = 1948, droprate = 95},
            {itemid = 2658, droprate = 67},
            {itemid = 1946, droprate = 133},
        },
    },
    -- eastern tower floor 3
    [146] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1942, droprate = 625},
            {itemid = 1944, droprate = 102},
            {itemid = 1950, droprate = 42},
            {itemid = 1952, droprate = 83},
            {itemid = 1946, droprate = 50},
        },
        {
            {itemid = 1940, droprate = 83},
            {itemid = 1936, droprate = 70},
            {itemid = 1938, droprate = 42},
            {itemid = 1948, droprate = 42},
            {itemid = 2660, droprate = 292},
        },
    },
    -- eastern tower floor 4
    [147] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1950, droprate = 417},
            {itemid = 1956, droprate = 75},
            {itemid = 1944, droprate = 208},
            {itemid = 1940, droprate = 167},
        },
        {
            {itemid = 1946, droprate = 62},
            {itemid = 1936, droprate = 69},
            {itemid = 2660, droprate = 208},
            {itemid = 1952, droprate = 42},
            {itemid = 2658, droprate = 83},
        },
    },
    -- eastern tower floor 5
    [148] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1944, droprate = 208},
            {itemid = 1938, droprate = 42},
            {itemid = 1946, droprate = 36},
            {itemid = 1940, droprate = 83},
            {itemid = 1942, droprate = 20},
        },
        {
            {itemid = 1952, droprate = 94},
            {itemid = 1956, droprate = 42},
            {itemid = 1936, droprate = 49},
            {itemid = 1950, droprate = 167},
            {itemid = 2714, droprate = 458},
        },
    },
    -- eastern tower floor 6
    [149] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1942, droprate = 68},
            {itemid = 1948, droprate = 74},
            {itemid = 1936, droprate = 259},
            {itemid = 1940, droprate = 74},
            {itemid = 1956, droprate = 74},
            {itemid = 1950, droprate = 62},
        },
        {
            {itemid = 2656, droprate = 150},
            {itemid = 1938, droprate = 76},
            {itemid = 1952, droprate = 53},
            {itemid = 2658, droprate = 111},
            {itemid = 2714, droprate = 370},
            {itemid = 1946, droprate = 333},
        },
    },
    -- eastern tower floor 7
    [150] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1942, droprate = 38},
            {itemid = 1950, droprate = 67},
            {itemid = 1944, droprate = 100},
            {itemid = 1936, droprate = 233},
            {itemid = 1946, droprate = 80},
            {itemid = 2660, droprate = 333},
            {itemid = 2714, droprate = 67},
        },
        {
            {itemid = 1875, droprate = 100},
            {itemid = 2127, droprate = 55},
        },
        {
            {itemid = 1905, droprate = 1000},
        },
    },
    -- central temenos floor 1
    [151] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1930, droprate = 265},
            {itemid = 1938, droprate = 118},
            {itemid = 1948, droprate = 147},
            {itemid = 1958, droprate = 147},
            {itemid = 1952, droprate = 118},
            {itemid = 2656, droprate = 235},
        },
        {
            {itemid = 1986, droprate = 1000},
        },
    },
    -- central temenos floor 2
    [152] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1944, droprate = 250},
            {itemid = 1936, droprate = 94},
            {itemid = 1950, droprate = 63},
            {itemid = 1942, droprate = 125},
            {itemid = 1946, droprate = 63},
            {itemid = 2660, droprate = 281},
            {itemid = 2714, droprate = 125},
        },
        {
            {itemid = 1908, droprate = 1000},
        },
    },
    -- central temenos floor 3
    [153] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1934, droprate = 53},
            {itemid = 1940, droprate = 132},
            {itemid = 1954, droprate = 105},
            {itemid = 1932, droprate = 211},
            {itemid = 1956, droprate = 211},
            {itemid = 1930, droprate = 100},
            {itemid = 2658, droprate = 211},
            {itemid = 2716, droprate = 105},
        },
        {
            {itemid = 1907, droprate = 1000},
        },
    },
    -- central temenos floor 4
    [154] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1920, droprate = 659},
            {itemid = 1924, droprate = 394},
            {itemid = 1923, droprate = 388},
            {itemid = 1922, droprate = 404},
        },
        {
            {itemid = 1924, droprate = 394},
            {itemid = 1922, droprate = 402},
            {itemid = 1920, droprate = 659},
            {itemid = 1923, droprate = 383},
        },
        {
            {itemid = 1921, droprate = 265},
            {itemid = 1875, droprate = 100},
        },
    },
    -- central temenos floor 5
    [155] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1934, droprate = 200},
            {itemid = 1930, droprate = 200},
            {itemid = 1958, droprate = 200},
            {itemid = 2658, droprate = 400},
            {itemid = 1940, droprate = 200},
        },
    },
}

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player, npc, trade)
end

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player, npc)
    local battlefield = player:getBattlefield()
    if not battlefield then
        return
    end
    local  CofferID = npc:getID()
    local  CofferType=0
    local  lootID=0
    local  InstanceRegion=0
    local  addtime=0
    local  DespawnOtherCoffer=false
    local  MimicID=0
    local X = npc:getXPos()
    local Y = npc:getYPos()
    local Z = npc:getZPos()

    for coffer = 1, #ARMOURY_CRATES_LIST_TEMENOS, 2 do
        if (ARMOURY_CRATES_LIST_TEMENOS[coffer] == CofferID-16928768) then
            CofferType=ARMOURY_CRATES_LIST_TEMENOS[coffer+1][1]
            InstanceRegion=ARMOURY_CRATES_LIST_TEMENOS[coffer+1][2]
            addtime=ARMOURY_CRATES_LIST_TEMENOS[coffer+1][3]
            DespawnOtherCoffer=ARMOURY_CRATES_LIST_TEMENOS[coffer+1][4]
            MimicID=ARMOURY_CRATES_LIST_TEMENOS[coffer+1][5]
            lootID=ARMOURY_CRATES_LIST_TEMENOS[coffer+1][6]
        end
    end
    local coffer = CofferID-16928768

    if (CofferType == cTIME) then
        tpz.battlefield.ExtendTimeLimit(battlefield, addtime)
    elseif (CofferType == cITEM) then
        if (InstanceRegion == Central_Temenos_4th_Floor and coffer~=79) then
            local randmimic = math.random(1, 24)
            if ( randmimic < 19) then
                local MimicList={16928986, 16928987, 16928988, 16928989, 16928990, 16928991, 16928992, 16928993, 16928994, 16928995, 16928996, 16928997, 16928998, 16928999, 16929000, 16929001, 16929002, 16929003}
                GetMobByID(MimicList[randmimic]):setSpawn(X, Y, Z)
                SpawnMob(MimicList[randmimic]):setPos(X, Y, Z)
                GetMobByID(MimicList[randmimic]):updateClaim(player)
            else
                battlefield:setLocalVar("loot", 1)
                battlefield:spawnLoot(npc)
                tpz.battlefield.HandleLootRolls(battlefield, loot[lootID], nil, npc)
            end
            -- despawn les coffer du meme groupe
            for coffer = 1, #ARMOURY_CRATES_LIST_TEMENOS, 2 do
                if (ARMOURY_CRATES_LIST_TEMENOS[coffer+1][5] == MimicID) then
                    GetNPCByID(16928768+ARMOURY_CRATES_LIST_TEMENOS[coffer]):setStatus(tpz.status.DISAPPEAR)
                end
            end
        else
            battlefield:setLocalVar("loot", 1)
            battlefield:spawnLoot(npc)
            tpz.battlefield.HandleLootRolls(battlefield, loot[lootID], nil, npc)
        end
    elseif (CofferType == cRESTORE) then
        tpz.battlefield.HealPlayers(battlefield)
    elseif (CofferType == cMIMIC) then
        if (coffer == 284) then
            GetMobByID(16928844):setSpawn(X, Y, Z)
            SpawnMob(16928844):setPos(X, Y, Z)
            GetMobByID(16928844):updateClaim(player)
        elseif (coffer == 321) then
            GetMobByID(16928853):setSpawn(X, Y, Z)
            SpawnMob(16928853):setPos(X, Y, Z)
            GetMobByID(16928853):updateClaim(player)
        elseif (coffer == 348) then
            GetMobByID(16928862):setSpawn(X, Y, Z)
            SpawnMob(16928862):setPos(X, Y, Z)
            GetMobByID(16928862):updateClaim(player)
        elseif (coffer == 360) then
            GetMobByID(16928871):setSpawn(X, Y, Z)
            SpawnMob(16928871):setPos(X, Y, Z)
            GetMobByID(16928871):updateClaim(player)
        elseif (coffer == 393) then
            GetMobByID(16928880):setSpawn(X, Y, Z)
            SpawnMob(16928880):setPos(X, Y, Z)
            GetMobByID(16928880):updateClaim(player)
        elseif (coffer == 127) then
            GetMobByID(16928889):setSpawn(X, Y, Z)
            SpawnMob(16928889):setPos(X, Y, Z)
            GetMobByID(16928889):updateClaim(player)
        elseif (coffer == 123) then
            GetMobByID(16928894):setSpawn(X, Y, Z)
            SpawnMob(16928894):setPos(X, Y, Z)
            GetMobByID(16928894):updateClaim(player)
        end
    end
    if (DespawnOtherCoffer == true) then
        HideArmouryCrates(InstanceRegion, TEMENOS)
        if (InstanceRegion==Temenos_Eastern_Tower) then --despawn mob of the current floor
            if (coffer == 173 or coffer == 215 or coffer == 284 or coffer == 40) then
                --floor 1
                if (GetMobAction(16928840) > 0) then DespawnMob(16928840); end
                if (GetMobAction(16928841) > 0) then DespawnMob(16928841); end
                if (GetMobAction(16928842) > 0) then DespawnMob(16928842); end
                if (GetMobAction(16928843) > 0) then DespawnMob(16928843); end
                GetNPCByID(16929228):setStatus(tpz.status.NORMAL)
            elseif (coffer == 174 or coffer == 216 or coffer == 321 or coffer == 45) then
                --floor 2
                if (GetMobAction(16928849) > 0) then DespawnMob(16928849); end
                if (GetMobAction(16928850) > 0) then DespawnMob(16928850); end
                if (GetMobAction(16928851) > 0) then DespawnMob(16928851); end
                if (GetMobAction(16928852) > 0) then DespawnMob(16928852); end
                GetNPCByID(16929229):setStatus(tpz.status.NORMAL)
            elseif (coffer == 181 or coffer == 217 or coffer == 348 or coffer == 46) then
                --floor 3
                if (GetMobAction(16928858) > 0) then DespawnMob(16928858); end
                if (GetMobAction(16928859) > 0) then DespawnMob(16928859); end
                if (GetMobAction(16928860) > 0) then DespawnMob(16928860); end
                if (GetMobAction(16928861) > 0) then DespawnMob(16928861); end
                GetNPCByID(16929230):setStatus(tpz.status.NORMAL)
            elseif (coffer == 182 or coffer == 236 or coffer == 360 or coffer == 47) then
                --floor 4
                if (GetMobAction(16928867) > 0) then DespawnMob(16928867); end
                if (GetMobAction(16928868) > 0) then DespawnMob(16928868); end
                if (GetMobAction(16928869) > 0) then DespawnMob(16928869); end
                if (GetMobAction(16928870) > 0) then DespawnMob(16928870); end
                GetNPCByID(16929231):setStatus(tpz.status.NORMAL)
            elseif (coffer == 183 or coffer == 261 or coffer == 393 or coffer == 68) then
                --floor 5
                if (GetMobAction(16928876) > 0) then DespawnMob(16928876); end
                if (GetMobAction(16928877) > 0) then DespawnMob(16928877); end
                if (GetMobAction(16928878) > 0) then DespawnMob(16928878); end
                if (GetMobAction(16928879) > 0) then DespawnMob(16928879); end
                GetNPCByID(16929232):setStatus(tpz.status.NORMAL)
            elseif (coffer == 277 or coffer == 190 or coffer ==  127 or coffer == 69) then
                --floor 6
                if (GetMobAction(16928885) > 0) then DespawnMob(16928885); end
                if (GetMobAction(16928886) > 0) then DespawnMob(16928886); end
                if (GetMobAction(16928887) > 0) then DespawnMob(16928887); end
                if (GetMobAction(16928888) > 0) then DespawnMob(16928888); end
                GetNPCByID(16929233):setStatus(tpz.status.NORMAL)
            elseif (coffer == 70 or coffer == 123) then
                --floor 7
                if (GetMobAction(16928892) > 0) then DespawnMob(16928892); end
                if (GetMobAction(16928893) > 0) then DespawnMob(16928893); end
                GetNPCByID(16929234):setStatus(tpz.status.NORMAL)
            end
        end
    end
    npc:setStatus(tpz.status.DISAPPEAR)
end

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player, csid, option)
end

-----------------------------------
-- onEventFinish Action
-----------------------------------

function onEventFinish(player, csid, option)
end
