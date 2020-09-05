-----------------------------------
-- Area: Temenos
-- NPC:  Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/zone")
local ID = require("scripts/zones/Temenos/IDs")

local loot =
{
    -- northern tower floor 1
    [1299] = 
    {
        [1] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 250},
                {itemid = 1954, droprate = 159},
                {itemid = 1940, droprate = 146},
                {itemid = 1932, droprate =  85},
                {itemid = 1956, droprate = 171},
                {itemid = 1934, droprate = 110},
                {itemid = 2658, droprate = 220},
                {itemid = 2716, droprate =  98},
            },
            {
                {itemid =    0, droprate = 250},
                {itemid = 1954, droprate = 159},
                {itemid = 1940, droprate = 146},
                {itemid = 1932, droprate =  85},
                {itemid = 1956, droprate = 171},
                {itemid = 1934, droprate = 110},
                {itemid = 2658, droprate = 220},
                {itemid = 2716, droprate =  98},
            },
        },
    -- northern tower floor 2
        [2] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 400},
                {itemid = 1932, droprate = 333},
                {itemid = 1954, droprate = 200},
                {itemid = 1950, droprate = 100},
                {itemid = 1940, droprate =  90},
                {itemid = 1942, droprate =  70},
                {itemid = 1934, droprate =  90},
                {itemid = 1936, droprate = 100},
                {itemid = 1958, droprate =  90},
                {itemid = 2656, droprate =  67},
                {itemid = 1956, droprate = 167},
            },
            {
                {itemid =    0, droprate = 400},
                {itemid = 1932, droprate = 333},
                {itemid = 1954, droprate = 200},
                {itemid = 1950, droprate = 100},
                {itemid = 1940, droprate =  90},
                {itemid = 1942, droprate =  70},
                {itemid = 1934, droprate =  90},
                {itemid = 1936, droprate = 100},
                {itemid = 1958, droprate =  90},
                {itemid = 2656, droprate =  67},
                {itemid = 1956, droprate = 167},
            },
        },
    -- northern tower floor 3
        [3] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1956, droprate =  27},
                {itemid = 1932, droprate = 324},
                {itemid = 1950, droprate =  80},
                {itemid = 1934, droprate = 189},
                {itemid = 1930, droprate =  50},
                {itemid = 1940, droprate =  27},
                {itemid = 1936, droprate =  81},
                {itemid = 1944, droprate =  80},
                {itemid = 1958, droprate =  81},
                {itemid = 2658, droprate = 270},
                {itemid = 2714, droprate = 108},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1956, droprate =  27},
                {itemid = 1932, droprate = 324},
                {itemid = 1950, droprate =  80},
                {itemid = 1934, droprate = 189},
                {itemid = 1930, droprate =  50},
                {itemid = 1940, droprate =  27},
                {itemid = 1936, droprate =  81},
                {itemid = 1944, droprate =  80},
                {itemid = 1958, droprate =  81},
                {itemid = 2658, droprate = 270},
                {itemid = 2714, droprate = 108},
            },
        },
    -- northern tower floor 4
        [4] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1942, droprate =  90},
                {itemid = 1934, droprate = 435},
                {itemid = 1956, droprate =  80},
                {itemid = 1940, droprate = 174},
                {itemid = 1958, droprate =  87},
                {itemid = 1954, droprate =  90},
                {itemid = 1936, droprate =  87},
                {itemid = 1930, droprate =  43},
                {itemid = 2656, droprate =  27},
                {itemid = 2658, droprate = 261},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1942, droprate =  90},
                {itemid = 1934, droprate = 435},
                {itemid = 1956, droprate =  80},
                {itemid = 1940, droprate = 174},
                {itemid = 1958, droprate =  87},
                {itemid = 1954, droprate =  90},
                {itemid = 1936, droprate =  87},
                {itemid = 1930, droprate =  43},
                {itemid = 2656, droprate =  27},
                {itemid = 2658, droprate = 261},
            },
        },
    -- northern tower floor 5
        [5] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 200},
                {itemid = 1954, droprate =  67},
                {itemid = 1940, droprate = 353},
                {itemid = 1936, droprate =  87},
                {itemid = 1956, droprate = 110},
                {itemid = 1958, droprate =  87},
                {itemid = 1942, droprate =  50},
                {itemid = 1950, droprate =  60},
                {itemid = 1932, droprate =  59},
                {itemid = 2716, droprate = 100},
                {itemid = 2714, droprate = 110},
            },
            {
                {itemid =    0, droprate = 200},
                {itemid = 1954, droprate =  67},
                {itemid = 1940, droprate = 353},
                {itemid = 1936, droprate =  87},
                {itemid = 1956, droprate = 110},
                {itemid = 1958, droprate =  87},
                {itemid = 1942, droprate =  50},
                {itemid = 1950, droprate =  60},
                {itemid = 1932, droprate =  59},
                {itemid = 2716, droprate = 100},
                {itemid = 2714, droprate = 110},
            },
        },
    -- northern tower floor 6
        [6] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1954, droprate = 263},
                {itemid = 1932, droprate =  59},
                {itemid = 1942, droprate =  53},
                {itemid = 1934, droprate =  60},
                {itemid = 1956, droprate = 526},
                {itemid = 1930, droprate =  60},
                {itemid = 1936, droprate =  53},
                {itemid = 1950, droprate = 158},
                {itemid = 2716, droprate = 105},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1954, droprate = 263},
                {itemid = 1932, droprate =  59},
                {itemid = 1942, droprate =  53},
                {itemid = 1934, droprate =  60},
                {itemid = 1956, droprate = 526},
                {itemid = 1930, droprate =  60},
                {itemid = 1936, droprate =  53},
                {itemid = 1950, droprate = 158},
                {itemid = 2716, droprate = 105},
            },
        },
    -- northern tower floor 7
        [7] =
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
                {itemid = 1934, droprate =  40},
                {itemid = 1954, droprate = 120},
                {itemid = 2658, droprate = 200},
                {itemid = 2716, droprate =  80},
            },
            {
                {itemid = 1904, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 100},
                {itemid = 2127, droprate =  55},
            },
        },
    },
    -- western tower floor 1
    [1298] = {
        [1] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 100},
                {itemid = 1948, droprate = 172},
                {itemid = 1938, droprate = 138},
                {itemid = 1952, droprate = 138},
                {itemid = 1958, droprate = 207},
                {itemid = 1930, droprate = 241},
                {itemid = 2656, droprate = 172},
            },
        },
    -- western tower floor 2
        [2] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1948, droprate = 179},
                {itemid = 1938, droprate = 571},
                {itemid = 1944, droprate =  71},
                {itemid = 1952, droprate = 179},
                {itemid = 1946, droprate = 120},
                {itemid = 1934, droprate =  71},
                {itemid = 1930, droprate = 143},
                {itemid = 2660, droprate = 143},
            },
            {
                {itemid =    0, droprate = 200},
                {itemid = 1948, droprate = 179},
                {itemid = 1938, droprate = 571},
                {itemid = 1944, droprate =  71},
                {itemid = 1952, droprate = 179},
                {itemid = 1946, droprate = 120},
                {itemid = 1934, droprate =  71},
                {itemid = 1930, droprate = 143},
                {itemid = 2660, droprate = 143},
            },
        },
    -- western tower floor 3
        [3] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1948, droprate = 536},
                {itemid = 1952, droprate = 107},
                {itemid = 1938, droprate =  60},
                {itemid = 1934, droprate = 110},
                {itemid = 1930, droprate =  80},
                {itemid = 2660, droprate =  90},
                {itemid = 1946, droprate =  71},
                {itemid = 1944, droprate = 103},
                {itemid = 1958, droprate = 160},
                {itemid = 1954, droprate =  36},
                {itemid = 2656, droprate = 250},
                {itemid = 2716, droprate = 350},
            },
            {
                {itemid =    0, droprate = 750},
                {itemid = 1948, droprate = 536},
                {itemid = 1952, droprate = 107},
                {itemid = 1938, droprate =  60},
                {itemid = 1934, droprate = 110},
                {itemid = 1930, droprate =  80},
                {itemid = 2660, droprate =  90},
                {itemid = 1946, droprate =  71},
                {itemid = 1944, droprate = 103},
                {itemid = 1958, droprate = 160},
                {itemid = 1954, droprate =  36},
                {itemid = 2656, droprate = 250},
                {itemid = 2716, droprate = 350},
            },
        },
    -- western tower floor 4
        [4] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1952, droprate = 533},
                {itemid = 1946, droprate =  90},
                {itemid = 1938, droprate = 133},
                {itemid = 1932, droprate =  90},
                {itemid = 1958, droprate =  10},
                {itemid = 1954, droprate = 133},
                {itemid = 1944, droprate = 133},
                {itemid = 1930, droprate = 133},
                {itemid = 2660, droprate =  33},
            },
            {
                {itemid =    0, droprate = 500},
                {itemid = 1952, droprate = 533},
                {itemid = 1946, droprate =  90},
                {itemid = 1938, droprate = 133},
                {itemid = 1932, droprate =  90},
                {itemid = 1958, droprate =  10},
                {itemid = 1954, droprate = 133},
                {itemid = 1944, droprate = 133},
                {itemid = 1930, droprate = 133},
                {itemid = 2660, droprate =  33},
            },
        },
    -- western tower floor 5
        [5] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1954, droprate =  59},
                {itemid = 1930, droprate = 294},
                {itemid = 1946, droprate =  59},
                {itemid = 1934, droprate =  78},
                {itemid = 1958, droprate = 176},
                {itemid = 1938, droprate =  59},
                {itemid = 1948, droprate =  25},
                {itemid = 1932, droprate = 118},
                {itemid = 2656, droprate = 294},
            },
            {
                {itemid =    0, droprate = 200},
                {itemid = 1954, droprate =  59},
                {itemid = 1930, droprate = 294},
                {itemid = 1946, droprate =  59},
                {itemid = 1934, droprate =  78},
                {itemid = 1958, droprate = 176},
                {itemid = 1938, droprate =  59},
                {itemid = 1948, droprate =  25},
                {itemid = 1932, droprate = 118},
                {itemid = 2656, droprate = 294},
            },
        },
    -- western tower floor 6
        [6] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1954, droprate = 200},
                {itemid = 1958, droprate = 400},
                {itemid = 1948, droprate = 100},
                {itemid = 1934, droprate = 150},
                {itemid = 1932, droprate =  50},
                {itemid = 1930, droprate =  60},
                {itemid = 1938, droprate = 200},
                {itemid = 1944, droprate =  60},
                {itemid = 1952, droprate = 200},
            },
            {
                {itemid =    0, droprate = 400},
                {itemid = 1954, droprate = 200},
                {itemid = 1958, droprate = 400},
                {itemid = 1948, droprate = 100},
                {itemid = 1934, droprate = 150},
                {itemid = 1932, droprate =  50},
                {itemid = 1930, droprate =  60},
                {itemid = 1938, droprate = 200},
                {itemid = 1944, droprate =  60},
                {itemid = 1952, droprate = 200},
            },
        },
    -- western tower floor 7
        [7] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1948, droprate =  36},
                {itemid = 1952, droprate = 143},
                {itemid = 1930, droprate = 143},
                {itemid = 1958, droprate = 214},
                {itemid = 1938, droprate =  71},
                {itemid = 2656, droprate = 321},
            },
            {
                {itemid = 1906, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 100},
                {itemid = 2127, droprate =  55},
            },
        },
    },
    -- eastern tower floor 1
    [1300] = {
        [1] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1944, droprate =  65},
                {itemid = 1936, droprate =  97},
                {itemid = 1946, droprate =  40},
                {itemid = 1942, droprate =  95},
                {itemid = 2660, droprate = 194},
                {itemid = 2714, droprate =  32},
                {itemid = 1950, droprate = 161},
            },
        },
    -- eastern tower floor 2
        [2] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1936, droprate = 367},
                {itemid = 1952, droprate =  70},
                {itemid = 1950, droprate =  40},
                {itemid = 1942, droprate = 333},
                {itemid = 1958, droprate =  20},
                {itemid = 1956, droprate = 106},
                {itemid = 1938, droprate =  33},
                {itemid = 1944, droprate =  76},
                {itemid = 1948, droprate =  95},
                {itemid = 2658, droprate =  67},
                {itemid = 1946, droprate = 133},
            },
            {
                {itemid =    0, droprate = 350},
                {itemid = 1936, droprate = 367},
                {itemid = 1952, droprate =  70},
                {itemid = 1950, droprate =  40},
                {itemid = 1942, droprate = 333},
                {itemid = 1958, droprate =  20},
                {itemid = 1956, droprate = 106},
                {itemid = 1938, droprate =  33},
                {itemid = 1944, droprate =  76},
                {itemid = 1948, droprate =  95},
                {itemid = 2658, droprate =  67},
                {itemid = 1946, droprate = 133},
            },
        },
    -- eastern tower floor 3
        [3] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1942, droprate = 625},
                {itemid = 1944, droprate = 102},
                {itemid = 1950, droprate =  42},
                {itemid = 1952, droprate =  83},
                {itemid = 1946, droprate =  50},
                {itemid = 1940, droprate =  83},
                {itemid = 1936, droprate =  70},
                {itemid = 1938, droprate =  42},
                {itemid = 1948, droprate =  42},
                {itemid = 2660, droprate = 292},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1942, droprate = 625},
                {itemid = 1944, droprate = 102},
                {itemid = 1950, droprate =  42},
                {itemid = 1952, droprate =  83},
                {itemid = 1946, droprate =  50},
                {itemid = 1940, droprate =  83},
                {itemid = 1936, droprate =  70},
                {itemid = 1938, droprate =  42},
                {itemid = 1948, droprate =  42},
                {itemid = 2660, droprate = 292},
            },
        },
    -- eastern tower floor 4
        [4] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1950, droprate = 417},
                {itemid = 1956, droprate =  75},
                {itemid = 1944, droprate = 208},
                {itemid = 1940, droprate = 167},
                {itemid = 1946, droprate =  62},
                {itemid = 1936, droprate =  69},
                {itemid = 2660, droprate = 208},
                {itemid = 1952, droprate =  42},
                {itemid = 2658, droprate =  83},
            },
            {
                {itemid =    0, droprate = 400},
                {itemid = 1950, droprate = 417},
                {itemid = 1956, droprate =  75},
                {itemid = 1944, droprate = 208},
                {itemid = 1940, droprate = 167},
                {itemid = 1946, droprate =  62},
                {itemid = 1936, droprate =  69},
                {itemid = 2660, droprate = 208},
                {itemid = 1952, droprate =  42},
                {itemid = 2658, droprate =  83},
            },
        },
    -- eastern tower floor 5
        [5] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1944, droprate = 208},
                {itemid = 1938, droprate =  42},
                {itemid = 1946, droprate =  36},
                {itemid = 1940, droprate =  83},
                {itemid = 1942, droprate =  20},
                {itemid = 1952, droprate =  94},
                {itemid = 1956, droprate =  42},
                {itemid = 1936, droprate =  49},
                {itemid = 1950, droprate = 167},
                {itemid = 2714, droprate = 458},
            },
            {
                {itemid =    0, droprate = 200},
                {itemid = 1944, droprate = 208},
                {itemid = 1938, droprate =  42},
                {itemid = 1946, droprate =  36},
                {itemid = 1940, droprate =  83},
                {itemid = 1942, droprate =  20},
                {itemid = 1952, droprate =  94},
                {itemid = 1956, droprate =  42},
                {itemid = 1936, droprate =  49},
                {itemid = 1950, droprate = 167},
                {itemid = 2714, droprate = 458},
            },
        },
    -- eastern tower floor 6
        [6] =
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
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1942, droprate =  68},
                {itemid = 1948, droprate =  74},
                {itemid = 1936, droprate = 259},
                {itemid = 1940, droprate =  74},
                {itemid = 1956, droprate =  74},
                {itemid = 1950, droprate =  62},
                {itemid = 2656, droprate = 150},
                {itemid = 1938, droprate =  76},
                {itemid = 1952, droprate =  53},
                {itemid = 2658, droprate = 111},
                {itemid = 2714, droprate = 370},
                {itemid = 1946, droprate = 333},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1942, droprate =  68},
                {itemid = 1948, droprate =  74},
                {itemid = 1936, droprate = 259},
                {itemid = 1940, droprate =  74},
                {itemid = 1956, droprate =  74},
                {itemid = 1950, droprate =  62},
                {itemid = 2656, droprate = 150},
                {itemid = 1938, droprate =  76},
                {itemid = 1952, droprate =  53},
                {itemid = 2658, droprate = 111},
                {itemid = 2714, droprate = 370},
                {itemid = 1946, droprate = 333},
            },
        },
    -- eastern tower floor 7
        [7] =
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
                {itemid = 1942, droprate =  38},
                {itemid = 1950, droprate =  67},
                {itemid = 1944, droprate = 100},
                {itemid = 1936, droprate = 233},
                {itemid = 1946, droprate =  80},
                {itemid = 2660, droprate = 333},
                {itemid = 2714, droprate =  67},
            },
            {
                {itemid = 1905, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 100},
                {itemid = 2127, droprate =  55},
            },
        },
    },
    -- central temenos basement
    [1301] =
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
    },
    -- central temenos floor 1
    [1303] =
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
    [1304] =
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
            {itemid = 1936, droprate =  94},
            {itemid = 1950, droprate =  63},
            {itemid = 1942, droprate = 125},
            {itemid = 1946, droprate =  63},
            {itemid = 2660, droprate = 281},
            {itemid = 2714, droprate = 125},
        },
        {
            {itemid = 1908, droprate = 1000},
        },
    },
    -- central temenos floor 3
    [1305]=
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
            {itemid = 1934, droprate =  53},
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
    [1306] = {
        [1] =
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
                {itemid =    0, droprate = 735},
            },
        },
    -- central temenos floor 4 side loot
        [2] =
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
    },
}

function onTrade(player, npc, trade)
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
            [1298] = function() -- Temenos West Crate Handling
                if crateID ~= ID.npc.TEMENOS_W_CRATE[7] then
                    for i = 1, 6 do
                        for j = 0, 2 do
                            if crateID == ID.npc.TEMENOS_W_CRATE[i]+j then
                                if model == 960 then
                                    tpz.battlefield.HealPlayers(battlefield)
                                elseif model == 961 then
                                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                elseif model == 962 then
                                    tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.TEMENOS)
                                end
                            end
                        end
                    end
                else
                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][7], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
            [1299] = function() -- Temenos North Crate Handling
                if crateID ~= ID.npc.TEMENOS_N_CRATE[7] then
                    for i = 1, 6 do
                        for j = 0, 2 do
                            if crateID == ID.npc.TEMENOS_N_CRATE[i]+j then
                                if j ~= 0 then GetNPCByID(ID.npc.TEMENOS_N_CRATE[i]):setStatus(tpz.status.DISAPPEAR) end
                                if j ~= 1 then GetNPCByID(ID.npc.TEMENOS_N_CRATE[i]+1):setStatus(tpz.status.DISAPPEAR) end
                                if j ~= 2 then GetNPCByID(ID.npc.TEMENOS_N_CRATE[i]+2):setStatus(tpz.status.DISAPPEAR) end
                                if model == 960 then
                                    tpz.battlefield.HealPlayers(battlefield)
                                elseif model == 961 then
                                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                elseif model == 962 then
                                    tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.TEMENOS)
                                end
                            end
                        end
                    end
                else
                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][7], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
            [1300] = function() -- Temenos East Crate Handling
                local spawnMimic = math.random(0,1) == 1
                if crateID ~= ID.npc.TEMENOS_E_CRATE[7] and crateID ~= ID.npc.TEMENOS_E_CRATE[7]+1 then
                    for i = 1, 6 do
                        local mask = battlefield:getLocalVar("crateMaskF"..i)
                        for j = 0, 3 do
                            if crateID == ID.npc.TEMENOS_E_CRATE[i]+j then
                                if GetMobByID(ID.mob.TEMENOS_E_MOB[i]+4):isDead() then
                                    battlefield:setLocalVar("crateOpenedF"..i, 1)
                                    if model ~= 961 or not (mask > 7 and spawnMimic) then
                                        if j ~= 0 then GetNPCByID(ID.npc.TEMENOS_E_CRATE[i]):setStatus(tpz.status.DISAPPEAR) end
                                        if j ~= 1 then GetNPCByID(ID.npc.TEMENOS_E_CRATE[i]+1):setStatus(tpz.status.DISAPPEAR) end
                                        if j ~= 2 then GetNPCByID(ID.npc.TEMENOS_E_CRATE[i]+2):setStatus(tpz.status.DISAPPEAR) end
                                        if j ~= 3 then GetNPCByID(ID.npc.TEMENOS_E_CRATE[i]+3):setStatus(tpz.status.DISAPPEAR) end
                                    end
                                    if GetMobByID(ID.mob.TEMENOS_E_MOB[i]):isAlive() then DespawnMob(ID.mob.TEMENOS_E_MOB[i]) end
                                    if GetMobByID(ID.mob.TEMENOS_E_MOB[i]+1):isAlive() then DespawnMob(ID.mob.TEMENOS_E_MOB[i]+1) end
                                    if GetMobByID(ID.mob.TEMENOS_E_MOB[i]+2):isAlive() then DespawnMob(ID.mob.TEMENOS_E_MOB[i]+2) end
                                    if GetMobByID(ID.mob.TEMENOS_E_MOB[i]+3):isAlive() then DespawnMob(ID.mob.TEMENOS_E_MOB[i]+3) end
                                    if model == 960 then
                                        tpz.battlefield.HealPlayers(battlefield)
                                        tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[i])
                                    elseif model == 961 then
                                        if mask > 7 and spawnMimic then
                                            battlefield:setLocalVar("crateMaskF"..i, mask-8)
                                            GetMobByID(ID.mob.TEMENOS_E_MOB[i]+4):setSpawn(X, Y, Z)
                                            SpawnMob(ID.mob.TEMENOS_E_MOB[i]+4):setPos(X, Y, Z)
                                            GetMobByID(ID.mob.TEMENOS_E_MOB[i]+4):updateClaim(player)
                                        else
                                            tpz.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                            tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[i])
                                        end
                                    elseif model == 962 then
                                        tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.TEMENOS)
                                        tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[i])
                                    end
                                else
                                    hold = true
                                    player:messageSpecial(ID.text.CANNOT_OPEN_CHEST)
                                end
                            end
                        end
                    end
                else
                    if GetMobByID(ID.mob.TEMENOS_E_MOB[7]+2):isDead() then
                        local otherCrate = ID.npc.TEMENOS_E_CRATE[7]
                        if crateID % 2 == 0 then otherCrate = otherCrate + 1 end
                        if spawnMimic and battlefield:getLocalVar("otherCrate") == 0 then
                            GetMobByID(ID.mob.TEMENOS_E_MOB[7]+2):setSpawn(X, Y, Z)
                            SpawnMob(ID.mob.TEMENOS_E_MOB[7]+2):setPos(X, Y, Z)
                            GetMobByID(ID.mob.TEMENOS_E_MOB[7]+2):updateClaim(player)
                            battlefield:setLocalVar("otherCrate", otherCrate)
                        else
                            GetNPCByID(otherCrate):setStatus(tpz.status.DISAPPEAR)
                            tpz.limbus.handleLootRolls(battlefield, loot[bfid][7], nil, npc)
                            battlefield:setLocalVar("cutsceneTimer", 10)
                            battlefield:setLocalVar("lootSeen", 1)
                        end
                    else
                        hold = true
                        player:messageSpecial(ID.text.CANNOT_OPEN_CHEST)
                    end
                end
            end,
            [1301] = function() -- Temenos Central Basement Crate Handling
                tpz.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1303] = function() -- Temenos Central F1 Crate Handling
                tpz.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1304] = function() -- Temenos Central F2 Crate Handling
                tpz.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1305] = function() -- Temenos Central F3 Crate Handling
                tpz.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1306] = function() -- Temenos Central F4 Crate Handling
                if crateID ~= ID.npc.TEMENOS_C_CRATE[4][1] then
                    local randmimic = math.random(1, 24)
                    if randmimic < 17 then
                        local MimicList =
                        {
                            ID.mob.TEMENOS_C_MOB[4]+20, ID.mob.TEMENOS_C_MOB[4]+21,
                            ID.mob.TEMENOS_C_MOB[4]+22, ID.mob.TEMENOS_C_MOB[4]+25,
                            ID.mob.TEMENOS_C_MOB[4]+26, ID.mob.TEMENOS_C_MOB[4]+27,
                            ID.mob.TEMENOS_C_MOB[4]+28, ID.mob.TEMENOS_C_MOB[4]+29,
                            ID.mob.TEMENOS_C_MOB[4]+30, ID.mob.TEMENOS_C_MOB[4]+31,
                            ID.mob.TEMENOS_C_MOB[4]+32, ID.mob.TEMENOS_C_MOB[4]+33,
                            ID.mob.TEMENOS_C_MOB[4]+34, ID.mob.TEMENOS_C_MOB[4]+35,
                            ID.mob.TEMENOS_C_MOB[4]+36, ID.mob.TEMENOS_C_MOB[4]+37,
                        }
                        GetMobByID(MimicList[randmimic]):setSpawn(X, Y, Z)
                        SpawnMob(MimicList[randmimic]):setPos(X, Y, Z)
                        GetMobByID(MimicList[randmimic]):updateClaim(player)
                    else
                        tpz.limbus.handleLootRolls(battlefield, loot[bfid][2], nil, npc)
                    end
                    for i = ID.npc.TEMENOS_C_CRATE[4][1]+2, ID.npc.TEMENOS_C_CRATE[4][1]+20 do
                        if ID.npc.TEMENOS_C_CRATE[4][crateID] == ID.npc.TEMENOS_C_CRATE[4][i] then
                            if crateID ~= i then
                                GetNPCByID(i):setStatus(tpz.status.DISAPPEAR)
                            end
                        end
                    end
                else
                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][1], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
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