-- This file is called by roe.lua and require()'s no file, it should not be require()'d by any
-- other lua scripts, which should instead require() roe.lua directly.

local triggers = tpz.roe.triggers
local checks = tpz.roe.checks

-- Schedule for Timed Records.
local timedSchedule = {
-- 4-hour timeslots (6 per day) all days/times are in JST
--    00-04  04-08  08-12  12-16  16-20  20-00
    {     0,  4010,  4016,  4012,  4018,  4013}, -- Sunday
    {  4015,  4011,  4017,  4014,  4019,  4008}, -- Monday
    {  4016,  4012,  4018,  4013,     0,  4009}, -- Tuesday
    {  4017,  4014,  4019,  4008,     0,  4010}, -- Wednesday
    {  4018,  4013,     0,  4009,  4015,  4011}, -- Thursdsay
    {  4019,  4008,     0,  4010,  4016,  4012}, -- Friday
    {     0,  4009,  4015,  4011,  4017,  4014}, -- Saturday
}
-- Load timetable for timed records
if ENABLE_ROE_TIMED and ENABLE_ROE_TIMED > 0 then
    RoeParseTimed(timedSchedule)
end

local defaults = {
    check = checks.masterCheck, -- Check function should return true/false
    increment = 1,              -- Amount to increment per successful check
    notify = 1,                 -- Progress notifications shown every X increases
    goal = 1,                   -- Progress goal
    flags = {},                 -- Special flags. Possible values: "timed" "repeat" "daily"
    reqs = {},                  -- Other requirements. List of function names from above, with required values.
    reward = {},                -- Reward parameters give on completion. (See completeRecord directly below.)
}

-- All implemented records must have their entries in this table.
-- Records not in this table can't be taken.
tpz.roe.records =
{

  ----------------------------------------
  -- Tutorial -> Basics                 --
  ----------------------------------------

    [   1] = { -- First Step Forward
        reward =  { item = { {4376,6} }, keyItem = tpz.ki.MEMORANDOLL, sparks = 100, xp = 300 }
    },

    [   2] = { -- Vanquish 1 Enemy
        trigger = triggers.mobKill,
        reward =  { sparks = 100, xp = 500}
    },

    [   3] = { -- Undertake a FoV Training Regime
        reward =  { sparks = 100, xp = 500}
    },

    [   4] = { -- Heal without magic
        reward =  { sparks = 100, xp = 500}
    },

    [  11] = { -- Undertake a GoV Training Regime
        reward =  { sparks = 100, xp = 500}
    },

    [ 932] = { -- Call Forth an Alter Ego (gives Cipher: Valaineral)
        reward =  { sparks = 100, xp = 300, item = { 10116 } }
    },

    [ 933] = { -- Alter Ego: Valaineral (gives Cipher: Mihli)
        reward =  { sparks = 100, xp = 300, item = { 10115 } }
    },

    [ 934] = { -- Alter Ego: Mihli Aliapoh (gives Cipher: Tenzen)
        reward =  { sparks = 100, xp = 300, item = { 10114 } }
    },

    [ 935] = { -- Alter Ego: Tenzen (gives Cipher: Adelheid)
        reward =  { sparks = 100, xp = 300, item = { 10153 } }
    },

    [ 936] = { -- Alter Ego: Adelheid (gives Cipher: Joachim)
        reward =  { sparks = 100, xp = 300, item = { 10117 } }
    },

    [ 937] = { -- Alter Ego: Joachim
        reward =  { sparks = 100, xp = 500 }
    },

  ----------------------------------------
  -- Tutorial -> Intermediate           --
  ----------------------------------------
    --[[ TODO
    [1045] = { -- Achieve Level 99 (gives Kupon A-PK109 x5)
        reward =  { sparks = 200, xp = 300, item = { 8733, 5 } }
    },

    [1046] = { -- An Eminent Scholar (gives Kupon W-EMI)
        reward =  { sparks = 200, xp = 200, item = { 9188 } }
    },

    [1047] = { -- An Eminent Scholar 2 (gives Kupon A-EMI)
        reward =  { sparks = 200, xp = 200, item = { 9226 } }
    },

    [1048] = { -- An Eminent Scholar 3 (gives Kupon A-EMI)
        reward =  { sparks = 200, xp = 200, item = { 9226 } }
    },

    [1049] = { -- Always Stand on 117 (gives Cipher: Koru-Moru)
        reward =  { sparks = 200, xp = 300, item = { 10140 }  }
    },
    ]]

  --------------------------------------------
  -- Combat (Wide Area) -> Combat (General) --
  --------------------------------------------

    [  12] = { -- Vanquish Multiple Enemies I - 200
        trigger = triggers.mobKill,
        goal = 200,
        reqs = { mobXP = true },
        flags = set{"repeat"},
        reward = { sparks = 1000, xp = 5000, unity = 100 },
    },

    [  13] = { -- Vanquish Multiple Enemies II - 500
        trigger = triggers.mobKill,
        goal = 500,
        reqs = { mobXP = true },
        reward = { sparks = 2000, xp = 6000 , item = { 6180 } },
    },

    [  14] = { -- Vanquish Multiple Enemies III - 750
        trigger = triggers.mobKill,
        goal = 750,
        reqs = { mobXP = true },
        reward = { sparks = 5000, xp = 10000 , item = { 6183 } },
    },

    [  15] = { -- Level Sync to Vanquish I
        trigger = triggers.mobKill,
        goal = 200,
        reqs = { mobXP = true , levelSync = true},
        reward = { sparks = 2000, xp = 6000 , unity = 200 },
    },

    [ 117] = { -- Level Sync to Vanquish II
        trigger = triggers.mobKill,
        goal = 20,
        reqs = { mobXP = true , levelSync = true},
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 600 , unity = 20  },
    },

    [  16] = { -- Deal 500+ Damage
        trigger = triggers.dmgDealt,
        goal = 200,
        reqs = { dmgMin = 500 },
        flags = set{"repeat"},
        reward = { sparks = 1000, xp = 5000, unity = 100 },
    },

    [  17] = { -- Deal 1000+ Damage
        trigger = triggers.dmgDealt,
        goal = 150,
        reqs = { dmgMin = 1000 },
        reward = { sparks = 1000, xp = 5000 },
    },

    [  18] = { -- Deal 1500+ Damage
        trigger = triggers.dmgDealt,
        goal = 100,
        reqs = { dmgMin = 1500 },
        reward = { sparks = 1000, xp = 5000 },
    },

    [ 698] = { -- Deal 2000+ Damage
        trigger = triggers.dmgDealt,
        goal = 100,
        reqs = { dmgMin = 2000 },
        reward = { sparks = 2000, xp = 5000, item = { {8711, 6} } },
    },

    [  19] = { -- Deal 10-20 Damage
        trigger = triggers.dmgDealt,
        goal = 10,
        reqs = { dmgMin = 10, dmgMax = 20 },
        reward = { sparks = 300, xp = 2500 },
    },

    [  20] = { -- Deal 110-120 Damage
        trigger = triggers.dmgDealt,
        goal = 10,
        reqs = { dmgMin = 110, dmgMax = 120 },
        reward = { sparks = 300, xp = 1500 },
    },

    [  21] = { -- Deal 310-320 Damage
        trigger = triggers.dmgDealt,
        goal = 10,
        reqs = { dmgMin = 310, dmgMax = 320 },
        reward = { sparks = 300, xp = 1500 },
    },

    [  22] = { -- Deal 510-520 Damage
        trigger = triggers.dmgDealt,
        goal = 10,
        reqs = { dmgMin = 510, dmgMax = 520 },
        reward = { sparks = 300, xp = 1500 },
    },

    [  23] = { -- Deal 1110-1120 Damage
        trigger = triggers.dmgDealt,
        goal = 10,
        reqs = { dmgMin = 1110, dmgMax = 1120 },
        reward = { sparks = 300, xp = 1500, item = { {8711, 2} } },
    },

    [  29] = { -- Total Damage I
        trigger = triggers.dmgDealt,
        goal = 100000,
        increment = 0,
        notify = 5000,
        reward = { sparks = 1000, xp = 5000 , item = { 6181 } },
        check = function(self, player, params)
                if params.dmg and params.dmg > 0 then
                    params.progress = params.progress + params.dmg
                    return true
                end
                return false
            end
    },

    [  30] = { -- Total Damage II
        trigger = triggers.dmgDealt,
        goal = 200000,
        increment = 0,
        notify = 10000,
        reward = { sparks = 3000, xp = 7000 , item = { 6184 } },
        check = function(self, player, params)
                if params.dmg and params.dmg > 0 then
                    params.progress = params.progress + params.dmg
                    return true
                end
                return false
            end
    },

    [ 696] = { -- Total Damage III
        trigger = triggers.dmgDealt,
        goal = 300000,
        increment = 0,
        notify = 10000,
        reward = { sparks = 3000, xp = 7000 , item = { 6184 } },
        check = function(self, player, params)
                if params.dmg and params.dmg > 0 then
                    params.progress = params.progress + params.dmg
                    return true
                end
                return false
            end
    },

    [  33] = { -- Total Damage Taken I
        trigger = triggers.dmgTaken,
        goal = 10000,
        increment = 0,
        notify = 500,
        reward = { sparks = 1000, xp = 1000, item = { {8711, 2} } },
        check = function(self, player, params)
                if params.dmg and params.dmg > 0 then
                    params.progress = params.progress + params.dmg
                    return true
                end
                return false
            end
    },

    [  34] = { -- Total Damage Taken II
        trigger = triggers.dmgTaken,
        goal = 20000,
        increment = 0,
        notify = 1000,
        reward = { sparks = 3000, xp = 5000, item = { {8711, 4} } },
        check = function(self, player, params)
                if params.dmg and params.dmg > 0 then
                    params.progress = params.progress + params.dmg
                    return true
                end
                return false
            end
    },

    [ 697] = { -- Total Damage Taken III
        trigger = triggers.dmgTaken,
        goal = 30000,
        increment = 0,
        notify = 1000,
        reward = { sparks = 3000, xp = 5000, item = { {8711, 6} } },
        check = function(self, player, params)
                if params.dmg and params.dmg > 0 then
                    params.progress = params.progress + params.dmg
                    return true
                end
                return false
            end
    },

    [  45] = { -- Weapon Skills 1
        trigger = triggers.wSkillUse,
        goal = 100,
        reward = { sparks = 500, xp = 2500 },
    },

  --------------------------------------------
  -- Crafting: General                      --
  --------------------------------------------

    [  57] = { -- Total Successful Synthesis Attempts
        trigger = triggers.synthSuccess,
        goal = 30,
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 500, unity = 10 },
    },

  --------------------------------------------
  -- Combat (Wide Area) -> Spoils 1         --
  --------------------------------------------

    [  71] = { -- Spoils - Fire Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4096 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  72] = { -- Spoils - Ice Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4097 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  73] = { -- Spoils - Wind Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4098 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  74] = { -- Spoils - Earth Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4099 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  75] = { -- Spoils - Lightning Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4100 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  76] = { -- Spoils - Water Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4101 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  77] = { -- Spoils - Light Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4102 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  78] = { -- Spoils - Dark Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4103 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  84] = { -- Spoils - Flame Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3297 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  85] = { -- Spoils - Snow Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3298 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  86] = { -- Spoils - Breeze Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3299 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  87] = { -- Spoils - Soil Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3300 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  88] = { -- Spoils - Thunder Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3301 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  89] = { -- Spoils - Aqua Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3302 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  90] = { -- Spoils - Light Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3303 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  91] = { -- Spoils - Shadow Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3304 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  92] = { -- Spoils - Ifritite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3520 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  93] = { -- Spoils - Shivite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3521 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  94] = { -- Spoils - Garudite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3522 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  95] = { -- Spoils - Titanite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3523 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  96] = { -- Spoils - Ramuite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3524 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  97] = { -- Spoils - Leviatite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3525 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  98] = { -- Spoils - Carbite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3526 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

    [  99] = { -- Spoils - Fenrite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3527 } },
        flags = set{"repeat"},
        reward = { sparks = 200, xp = 1000, unity = 20 },
    },

  --------------------------------------------
  -- Combat (Wide Area) -> Spoils 2         --
  --------------------------------------------

    [ 120] = { -- Spoils - Bat Wing
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 922 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 121] = { -- Spoils - Black Tiger Fang
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 884 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 122] = { -- Spoils - Flint Stone
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 768 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 123] = { -- Spoils - Rabbit Hide
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 856 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 124] = { -- Spoils - Honey
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 4370 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 125] = { -- Spoils - Sheepskin
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 505 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 126] = { -- Spoils - Lizard Skin
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 852 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 127] = { -- Spoils - Beetle Shell
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 889 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 128] = { -- Spoils - Zeruhn Soot
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 560 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 129] = { -- Spoils - Silver Name Tag
        trigger = triggers.itemLooted,
        goal = 1,
        reqs = { itemID = set{ 13116 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 130] = { -- Spoils - Quadav Helm
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 501 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 132] = { -- Spoils - Treant Bulb
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 953 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 133] = { -- Spoils - Wild Onion
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 4387 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 134] = { -- Spoils - Sleepshroom
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 4374 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 135] = { -- Spoils - Sand Bat Fang
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 1015 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 136] = { -- Spoils - Zinc Ore
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 642 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 137] = { -- Spoils - Giant Bird Feather
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 842 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 138] = { -- Spoils - Three-leaf Mandragora Bud
        trigger = triggers.itemLooted,
        goal = 1,
        reqs = { itemID = set{ 1154 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 139] = { -- Spoils - Four-leaf Mandragora Bud
        trigger = triggers.itemLooted,
        goal = 1,
        reqs = { itemID = set{ 4369 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 140] = { -- Spoils - Cornette
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 17344 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 141] = { -- Spoils - Yuhtunga Sulfur
        trigger = triggers.itemLooted,
        goal = 1,
        reqs = { itemID = set{ 934 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 142] = { -- Spoils - Snobby Letter
        trigger = triggers.itemLooted,
        goal = 1,
        reqs = { itemID = set{ 1150 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 143] = { -- Spoils - Yagudo Bead Necklace
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 498 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 144] = { -- Spoils - Woozyshroom
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 4373 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 145] = { -- Spoils - Beehive Chip
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 912 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 146] = { -- Spoils - Remi Shell
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 1016 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

    [ 147] = { -- Spoils - Twinstone Earring
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 13360 } },
        flags = set{"repeat"},
        reward = { sparks = 100, xp = 300, unity = 10 },
    },

  ----------------------------------------
  -- Combat (Region) - Original Areas 1 --
  ----------------------------------------

    [ 215] = { -- Conflict: West Ronfaure
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{100} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 500, unity = 5, item = { 4439 } },
    },

    [ 216] = { -- Subjugation: Jaggedy-Eared Jack
        trigger = triggers.mobKill,
        reqs = { mobID = set{17187111} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 217] = { -- Conflict: East Ronfaure
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{101} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 500, unity = 5, item = { 12577 } },
    },

    [ 218] = { -- Subjugation: Swamfisk
        trigger = triggers.mobKill,
        reqs = { mobID = set{17191189, 17191291} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 219] = { -- Conflict: Ghelsba Outpost
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{140} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 500, unity = 5, item = { 13331 } },
    },

    [ 220] = { -- Subjugation: Thousandarm Deshglesh
        trigger = triggers.mobKill,
        reqs = { mobID = set{17350826} },
        reward = { sparks = 250, xp = 550 },
    },

    [ 221] = { -- Conflict: Fort Ghelsba
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{141} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 500, unity = 5, item = { 13333 } },
    },

    [ 222] = { -- Subjugation: Hundredscar Hajwaj
        trigger = triggers.mobKill,
        reqs = { mobID = set{17354828} },
        reward = { sparks = 500, xp = 1000 },
    },

    [ 223] = { -- Conflict: Yughott Grotto
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{142} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 500, unity = 5, item = { 13336 } },
    },

    [ 224] = { -- Subjugation: Ashmaker Gotblut
        trigger = triggers.mobKill,
        reqs = { mobID = set{17358932} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 225] = { -- Conflict: King Ranperre's Tomb
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{190} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 100, unity = 5, item = { 13443 } },
    },

    [ 226] = { -- Subjugation: Barbastelle
        trigger = triggers.mobKill,
        reqs = { mobID = set{17555721} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 227] = { -- Conflict: Bostaunieux Oubliette
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{167} },
        flags = set{"repeat"},
        reward = { sparks = 15, xp = 100, unity = 5, item = { 11532 } },
    },

    [ 228] = { -- Subjugation: Bloodsucker
        trigger = triggers.mobKill,
        reqs = { mobID = set{17461478} },
        reward = { sparks = 500, xp = 1000 },
    },

    [ 229] = { -- Conflict: Valkurm Dunes
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{103} },
        flags = set{"repeat"},
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13456 } },
    },

    [ 230] = { -- Subjugation: Valkurm Emperor
        trigger = triggers.mobKill,
        reqs = { mobID = set{17199438} },
        reward = { sparks = 250, xp = 550 },
    },

    [ 231] = { -- Conflict: Konschtat Highlands
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{108} },
        flags = set{"repeat"},
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13472 } },
    },

    [ 232] = { -- Subjugation: Bendigeit Vran
        trigger = triggers.mobKill,
        reqs = { mobID = set{17220001} },
        reward = { sparks = 250, xp = 600 },
    },

    [ 233] = { -- Conflict: Gusgen Mines
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{196} },
        flags = set{"repeat"},
        reward = { sparks = 11, xp = 100, unity = 5, item = { 13471 } },
    },

    [ 234] = { -- Subjugation: Juggler Hecatomb
        trigger = triggers.mobKill,
        reqs = { mobID = set{17580248} },
        reward = { sparks = 250, xp = 600 },
    },

    [ 235] = { -- Conflict: La Theine Plateau
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{102} },
        flags = set{"repeat"},
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13444 } },
    },

    [ 236] = { -- Subjugation: Bloodtear Baldurf
        trigger = triggers.mobKill,
        reqs = { mobID = set{17195318} },
        reward = { sparks = 500, xp = 1000 },
    },


    [ 237] = { -- Conflict: Ordelle's Caves
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{193} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 100, unity = 5, item = { 13470 } },
    },

    [ 238] = { -- Subjugation: Morbolger
        trigger = triggers.mobKill,
        reqs = { mobID = set{17568127} },
        reward = { sparks = 500, xp = 1000 },
    },

  ----------------------------------------
  -- Combat (Region) - Original Areas 2 --
  ----------------------------------------

    [ 239] = { -- Conflict: Jugner Forest
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{104} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { {4381, 12} } },
    },

    [ 240] = { -- Subjugation: King Arthro
        trigger = triggers.mobKill,
        reqs = { mobID = set{17203216} },
        reward = { sparks = 500, xp = 1000 },
    },

    [ 241] = { -- Conflict: Batallia Downs
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{105} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13685 } },
    },

    [ 242] = { -- Subjugation: Lumber Jack
        trigger = triggers.mobKill,
        reqs = { mobID = set{17207308} },
        reward = { sparks = 500, xp = 1000 },
    },

    [ 243] = { -- Conflict: Eldieme Necropolis
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{195} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 100, unity = 5, item = { 13198 } },
    },

    [ 244] = { -- Subjugation: Cwn Cyrff
        trigger = triggers.mobKill,
        reqs = { mobID = set{17576054} },
        reward = { sparks = 250, xp = 800 },
    },

    [ 245] = { -- Conflict: Davoi
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{149} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 12554 } },
    },

    [ 246] = { -- Subjugation: Hawkeyed Dnatbat
        trigger = triggers.mobKill,
        reqs = { mobID = set{17387567} },
        reward = { sparks = 250, xp = 600 },
    },

    [ 247] = { -- Conflict: N. Gustaberg
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{106} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 500, unity = 5, item = { 4488 } },
    },

    [ 248] = { -- Subjugation: Maighdean Uaine
        trigger = triggers.mobKill,
        reqs = { mobID = set{17211702, 17211714} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 249] = { -- Conflict: S. Gustaberg
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{107} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 500, unity = 5, item = { 12592 } },
    },

    [ 250] = { -- Subjugation: Carnero
        trigger = triggers.mobKill,
        reqs = { mobID = set{17215613, 17215626} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 251] = { -- Conflict: Zeruhn Mines
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{172} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 100, unity = 5, item = { 13335 } },
    },

    [ 252] = { -- Conflict: Palborough Mines
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{143} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 500, unity = 5, item = { 13330 } },
    },

    [ 253] = { -- Subjugation: Zi-Ghi Bone-eater
        trigger = triggers.mobKill,
        reqs = { mobID = set{17363208} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 254] = { -- Conflict: Dangruf Wadi
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{191} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 100, unity = 5, item = { 13473 } },
    },

    [ 255] = { -- Subjugation: Teporingo
        trigger = triggers.mobKill,
        reqs = { mobID = set{17559584} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 256] = { -- Conflict: Pashhow Marshlands
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{109} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { {5721, 12} } },
    },

    [ 257] = { -- Subjugation: Ni'Zho Bladebender
        trigger = triggers.mobKill,
        reqs = { mobID = set{17223797} },
        reward = { sparks = 250, xp = 700 },
    },

    [ 258] = { -- Conflict: Rolanberry Fields
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{110} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { 15487 } },
    },

    [ 259] = { -- Subjugation: Simurgh
        trigger = triggers.mobKill,
        reqs = { mobID = set{17228242} },
        reward = { sparks = 250, xp = 1000 },
    },

    [ 260] = { -- Conflict: Crawler's Nest
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{197} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 100, unity = 5, item = { 13271 } },
    },

    [ 261] = { -- Subjugation: Demonic Tiphia
        trigger = triggers.mobKill,
        reqs = { mobID = set{17584398} },
        reward = { sparks = 250, xp = 800 },
    },

    [ 262] = { -- Conflict: Beadeaux
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{147} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13703 } },
    },

    [ 263] = { -- Subjugation: Zo'Khu Blackcloud
        trigger = triggers.mobKill,
        reqs = { mobID = set{17379564} },
        reward = { sparks = 250, xp = 700 },
    },

  ----------------------------------------
  -- Combat (Region) - Original Areas 3 --
  ----------------------------------------

    [ 264] = { -- Conflict: West Sarutabaruta
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{115} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 500, unity = 5, item = { 4498 } },
    },

    [ 265] = { -- Subjugation: Nunyenunc
        trigger = triggers.mobKill,
        reqs = { mobID = set{17248517} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 266] = { -- Conflict: East Sarutabaruta
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{116} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 500, unity = 5, item = { 12601 } },
    },

    [ 267] = { -- Subjugation: Spiny Spipi
        trigger = triggers.mobKill,
        reqs = { mobID = set{17252657} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 268] = { -- Conflict: Giddeus
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{145} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 500, unity = 5, item = { 13337 } },
    },

    [ 269] = { -- Subjugation: Hoo Mjuu the Torrent
        trigger = triggers.mobKill,
        reqs = { mobID = set{17371515} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 270] = { -- Conflict: Toraimarai Canal
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{169} },
        flags = set{"repeat"},
        reward = { sparks = 15, xp = 100, unity = 5, item = { 13586 } },
    },

    [ 271] = { -- Subjugation: Oni Carcass
        trigger = triggers.mobKill,
        reqs = { mobID = set{17469587} },
        reward = { sparks = 250, xp = 800 },
    },

    [ 272] = { -- Conflict: Inner Horutoto Ruins
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{192} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 100, unity = 5, item = { 13332 } },
    },

    [ 273] = { -- Subjugation: Maltha
        trigger = triggers.mobKill,
        reqs = { mobID = set{17563749} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 274] = { -- Conflict: Outer Horutoto Ruins
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{194} },
        flags = set{"repeat"},
        reward = { sparks = 10, xp = 100, unity = 5, item = { 13334 } },
    },

    [ 275] = { -- Subjugation: Bomb King
        trigger = triggers.mobKill,
        reqs = { mobID = set{17572094, 17572142, 17572146} },
        reward = { sparks = 250, xp = 500 },
    },

    [ 276] = { -- Conflict: Buburimu Peninsula
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{118} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13474 } },
    },

    [ 277] = { -- Subjugation: Helldiver
        trigger = triggers.mobKill,
        reqs = { mobID = set{17260907} },
        reward = { sparks = 250, xp = 600 },
    },

    [ 278] = { -- Conflict: Tahrongi Canyon
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{117} },
        flags = set{"repeat"},
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13468 } },
    },

    [ 279] = { -- Subjugation: Serpopard Ishtar
        trigger = triggers.mobKill,
        reqs = { mobID = set{17256563, 17256690} },
        reward = { sparks = 250, xp = 600 },
    },

    [ 280] = { -- Conflict: Maze of Shakhrami
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{198} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 100, unity = 5, item = { 13321 } },
    },

    [ 281] = { -- Subjugation: Argus
        trigger = triggers.mobKill,
        reqs = { mobID = set{17588674} },
        reward = { sparks = 500, xp = 1000 },
    },

    [ 282] = { -- Conflict: Meriphataud Mountains
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{119} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { {4413, 12} } },
    },

    [ 283] = { -- Subjugation: Daggerclaw Dracos
        trigger = triggers.mobKill,
        reqs = { mobID = set{17264818} },
        reward = { sparks = 250, xp = 600 },
    },

    [ 284] = { -- Conflict: Sauromugue Champaign
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{120} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13577 } },
    },

    [ 285] = { -- Subjugation: Roc
        trigger = triggers.mobKill,
        reqs = { mobID = set{17269106} },
        reward = { sparks = 500, xp = 1000 },
    },

    [ 286] = { -- Conflict: Garlaige Citadel
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{200} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 100, unity = 5, item = { 15907 } },
    },

    [ 287] = { -- Subjugation: Serket
        trigger = triggers.mobKill,
        reqs = { mobID = set{17596720} },
        reward = { sparks = 500, xp = 1000 },
    },

    [ 288] = { -- Conflict: Castle Oztroja
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{151} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13723 } },
    },

    [ 289] = { -- Subjugation: Lii Jixa the Somnolist
        trigger = triggers.mobKill,
        reqs = { mobID = set{17395896} },
        reward = { sparks = 250, xp = 800 },
    },

  ----------------------------------------
  -- Combat (Region) - Original Areas 4 --
  ----------------------------------------

    [ 290] = { -- Conflict: Beaucedine Glacier
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{111} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 700, unity = 5, item = { 16261 } },
    },

    [ 291] = { -- Subjugation: Nue
        trigger = triggers.mobKill,
        reqs = { mobID = set{17231971} },
        reward = { sparks = 250, xp = 700 },
    },

    [ 292] = { -- Conflict: Ranguemont Pass
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{166} },
        flags = set{"repeat"},
        reward = { sparks = 11, xp = 100, unity = 5, item = { 13323 } },
    },

    [ 293] = { -- Subjugation: Gloom Eye
        trigger = triggers.mobKill,
        reqs = { mobID = set{17457204} },
        reward = { sparks = 250, xp = 700 },
    },

    [ 294] = { -- Conflict: Fei'Yin
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{204} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 100, unity = 5, item = { 13324 } },
    },

    [ 295] = { -- Subjugation: Goliath
        trigger = triggers.mobKill,
        reqs = { mobID = set{17613046, 17613048, 17613052, 17613054} },
        reward = { sparks = 250, xp = 800 },
    },

    [ 296] = { -- Conflict: Xarcabard
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{112} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 700, unity = 5, item = { 13315 } },
    },

    [ 297] = { -- Subjugation: Biast
        trigger = triggers.mobKill,
        reqs = { mobID = set{17235988} },
        reward = { sparks = 500, xp = 1000 },
    },

    [ 298] = { -- Conflict: Castle Zvahl Baileys
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{161} },
        flags = set{"repeat"},
        reward = { sparks = 15, xp = 750, unity = 5, item = { 13688 } },
    },

    [ 299] = { -- Subjugation: Duke Haborym
        trigger = triggers.mobKill,
        reqs = { mobID = set{17436923} },
        reward = { sparks = 500, xp = 1000 },
    },

    [ 300] = { -- Conflict: Castle Zvahl Keep
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{162} },
        flags = set{"repeat"},
        reward = { sparks = 15, xp = 750, unity = 5, item = { 13689 } },
    },

    [ 301] = { -- Subjugation: Baron Vapula
        trigger = triggers.mobKill,
        reqs = { mobID = set{17440963} },
        reward = { sparks = 250, xp = 800 },
    },

    [ 302] = { -- Conflict: Qufim Island
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{126} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 16301 } },
    },

    [ 303] = { -- Subjugation: Dosetsu Tree
        trigger = triggers.mobKill,
        reqs = { mobID = set{17293640} },
        reward = { sparks = 500, xp = 1000 },
    },

    [ 304] = { -- Conflict: Lower Delkfutt's Tower
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{184} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 100, unity = 5, item = { {5147, 12} } },
    },

    [ 305] = { -- Subjugation: Epialtes
        trigger = triggers.mobKill,
        reqs = { mobID = set{17530881} },
        reward = { sparks = 250, xp = 700 },
    },

    [ 306] = { -- Conflict: Middle Delkfutt's Tower
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{157} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 100, unity = 5, item = { {5149, 12} } },
    },

    [ 307] = { -- Subjugation: Ogygos
        trigger = triggers.mobKill,
        reqs = { mobID = set{17420592} },
        reward = { sparks = 250, xp = 700 },
    },

    [ 308] = { -- Conflict: Upper Delkfutt's Tower
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{158} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 100, unity = 5, item = { {5757, 12} } },
    },

    [ 309] = { -- Subjugation: Enkelados
        trigger = triggers.mobKill,
        reqs = { mobID = set{17424385, 17424423} },
        reward = { sparks = 250, xp = 800 },
    },

    [ 380] = { -- Conflict: Behemoth's Dominion
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{127} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 100, unity = 5, item = { {4398, 12} } },
    },

  ----------------------------------------
  -- Combat (Region) - Adoulin 1        --
  ----------------------------------------

  ----------------------------------------
  -- Combat (Region) - Adoulin 2        --
  ----------------------------------------

  ----------------------------------------
  -- Combat (Region) - Zilart 1         --
  ----------------------------------------

    [ 390] = { -- Conflict: Sanctuary of Zi'Tah
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{121} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { {4151, 12} } },
    },

    [ 392] = { -- Conflict: Ro'Maeve
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{122} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 800, unity = 5, item = { {4156, 12} } },
    },

    [ 394] = { -- Conflict: Boyahda Tree
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{153} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 100, unity = 5, item = { {4166, 12} } },
    },

    [ 396] = { -- Conflict: Dragon's Aery
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{154} },
        flags = set{"repeat"},
        reward = { sparks = 17, xp = 850, unity = 5, item = { 4136 } },
    },

    [ 398] = { -- Conflict: Eastern Altepa Desert
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{114} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { {4164, 12} } },
    },

    [ 400] = { -- Conflict: Western Altepa Desert
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{125} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 700, unity = 5, item = { {4165, 12} } },
    },

    [ 402] = { -- Conflict: Quicksand Caves
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{208} },
        flags = set{"repeat"},
        reward = { sparks = 15, xp = 100, unity = 5, item = { 13637 } },
    },

    [ 404] = { -- Conflict: Gustav Tunnel
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{212} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 100, unity = 5, item = { 13579 } },
    },

    [ 406] = { -- Conflict: Kuftal Tunnel
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{174} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 100, unity = 5, item = { 16233 } },
    },

    [ 408] = { -- Conflict: Cape Terrigan
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{113} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 800, unity = 5, item = { 16263 } },
    },

    [ 410] = { -- Conflict: Valley of Sorrows
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{128} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 800, unity = 5, item = { 13108 } },
    },

    [ 412] = { -- Conflict: Yuhtunga Jungle
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{123} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13125 } },
    },

  ----------------------------------------
  -- Combat (Region) - Zilart 2         --
  ----------------------------------------

    [ 414] = { -- Conflict: Sea Serpent Grotto
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{176 } },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 100, unity = 5, item = { 13207 } },
    },

    [ 416] = { -- Conflict: Yhoator Jungle
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{124} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13273 } },
    },

    [ 418] = { -- Conflict: Temple of Uggalepih
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{159} },
        flags = set{"repeat"},
        reward = { sparks = 15, xp = 100, unity = 5, item = { 15913 } },
    },

    [ 420] = { -- Conflict: Den of Rancor
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{160} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 100, unity = 5, item = { 13208 } },
    },

    [ 422] = { -- Conflict: Ifrit's Cauldron
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{205} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 100, unity = 5, item = { 13344 } },
    },

    [ 424] = { -- Conflict: Ru'Aun Gardens
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{130} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13346 } },
    },

    [ 426] = { -- Conflict: Ve'Lugannon Palace
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{177} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 100, unity = 7, item = { 13348 } },
    },

    [ 428] = { -- Conflict: Shrine of Ru'Avitau
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{178} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 100, unity = 7, item = { 13343 } },
    },

    [ 430] = { -- Conflict: Labyrinth of Onzozo
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{213} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 700, unity = 5, item = { 13345 } },
    },

    [ 432] = { -- Conflict: Korroloka Tunnel
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{173} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13347 } },
    },

  ----------------------------------------
  -- Combat (Region) - Promathia 1      --
  ----------------------------------------

    [ 434] = { -- Conflict: Oldton Movalpolos
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{11} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13350 } },
    },

    [ 436] = { -- Conflict: Newton Movalpolos
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{12} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 800, unity = 5, item = { 13349 } },
    },

    [ 438] = { -- Conflict: Lufaise Meadows
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{24} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 14725 } },
    },

    [ 440] = { -- Conflict: Misareaux Coast
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{25} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13417 } },
    },

    [ 442] = { -- Conflict: Phomiuna Aqueducts
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{27} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13325 } },
    },

    [ 444] = { -- Conflict: Riverne - Site #A01
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{30} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13461 } },
    },

    [ 446] = { -- Conflict: Riverne - Site #B01
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{29} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 700, unity = 5, item = { 15813 } },
    },

    [ 448] = { -- Conflict: Sacrarium
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{28} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 700, unity = 5, item = { 13485 } },
    },

    [ 450] = { -- Conflict: Promyvion - Holla
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{16} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13487 } },
    },

    [ 452] = { -- Conflict: Promyvion - Dem
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{18} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13489 } },
    },

    [ 454] = { -- Conflict: Promyvion - Mea
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{20} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13484 } },
    },

    [ 456] = { -- Conflict: Yuhtunga Jungle
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{22} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 700, unity = 5, item = { 13486 } },
    },

  ----------------------------------------
  -- Combat (Region) - Promathia 2      --
  ----------------------------------------

    [ 458] = { -- Conflict: Al'Taieu
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{33} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13488 } },
    },

    [ 460] = { -- Conflict: Grand Palace of Hu'Xzoi
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{34} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13491 } },
    },

    [ 462] = { -- Conflict: Garden of Ru'Hmet
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{35} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 17285 } },
    },

    [ 464] = { -- Conflict: Carpenters' Landing
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{2} },
        flags = set{"repeat"},
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13490 } },
    },

    [ 468] = { -- Conflict: Bibiki Bay
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{4} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13546 } },
    },

    [ 472] = { -- Conflict: Attohwa Chasm
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{7} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13464 } },
    },

    [ 474] = { -- Conflict: Pso'Xja
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{9} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 700, unity = 5, item = { 13445 } },
    },

    [ 476] = { -- Conflict: Uleguerand Range
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{5} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 800, unity = 5, item = { 13591 } },
    },

  ----------------------------------------
  -- Combat (Region) - Aht Urhgan       --
  ----------------------------------------

    [ 533] = { -- Conflict: Bhaflau Thickets
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{52} },
        flags = set{"repeat"},
        reward = { sparks = 60, xp = 800, unity = 6, item = { 12324 } },
    },

    [ 535] = { -- Conflict: Mamook
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{65} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 12309 } },
    },

    [ 537] = { -- Conflict: Wajaom Woodlands
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{51} },
        flags = set{"repeat"},
        reward = { sparks = 60, xp = 800, unity = 6, item = { 13275 } },
    },

    [ 539] = { -- Conflict: Aydeewa Subterrane
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{68} },
        flags = set{"repeat"},
        reward = { sparks = 60, xp = 800, unity = 6, item = { 13197 } },
    },

    [ 541] = { -- Conflict: Halvung
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{62} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 15890 } },
    },

    [ 543] = { -- Conflict: Mount Zhayolm
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{61} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13629 } },
    },

    [ 545] = { -- Conflict: Caedarva Mire
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{79} },
        flags = set{"repeat"},
        reward = { sparks = 60, xp = 800, unity = 6, item = { 13212 } },
    },

    [ 547] = { -- Conflict: Arrapago Reef
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{54} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 16235 } },
    },

    [ 549] = { -- Conflict: Alza. Undersea Ruins
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{72} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13587 } },
    },

  ----------------------------------------
  -- Combat (Region) - Goddess 1        --
  ----------------------------------------

    [ 553] = { -- Conflict: East Ronfaure [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{81} },
        flags = set{"repeat"},
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13092 } },
    },

    [ 555] = { -- Conflict: Jugner Forest [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{82} },
        flags = set{"repeat"},
        reward = { sparks = 14, xp = 700, unity = 5, item = { 12311 } },
    },

    [ 557] = { -- Conflict: Batallia Downs [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{84} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13087 } },
    },

    [ 559] = { -- Conflict: La Vaule [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{85} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13329 } },
    },

    [ 561] = { -- Conflict: Eldieme Necropolis [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{175} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 800, unity = 5, item = { 16231 } },
    },

    [ 563] = { -- Conflict: North Gustaberg [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{88} },
        flags = set{"repeat"},
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13088 } },
    },

    [ 565] = { -- Conflict: Grauberg [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{89} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13316 } },
    },

    [ 567] = { -- Conflict: Vunkerl Inlet [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{83} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 14727 } },
    },

    [ 569] = { -- Conflict: Pashhow Marshlands [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{90} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 800, unity = 5, item = { 13312 } },
    },

    [ 571] = { -- Conflict: Rolanberry Fields [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{91} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 12308 } },
    },

    [ 573] = { -- Conflict: Beadeaux [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{92} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 15991 } },
    },

    [ 575] = { -- Conflict: Crawlers' Nest [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{171} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 800, unity = 5, item = { 15993 } },
    },


  ----------------------------------------
  -- Combat (Region) - Goddess 2        --
  ----------------------------------------

    [ 577] = { -- Conflict: West Sarutabaruta [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{95} },
        flags = set{"repeat"},
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13079 } },
    },

    [ 579] = { -- Conflict: Fort Karugo-Narugo [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{96} },
        flags = set{"repeat"},
        reward = { sparks = 12, xp = 600, unity = 5, item = { 16265 } },
    },

    [ 581] = { -- Conflict: Meriph. Mountains [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{97} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 12302 } },
    },

    [ 583] = { -- Conflict: Sauro. Champaign [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{98} },
        flags = set{"repeat"},
        reward = { sparks = 13, xp = 650, unity = 5, item = { 16170 } },
    },

    [ 585] = { -- Conflict: Castle Oztroja [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{99} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 15803 } },
    },

    [ 587] = { -- Conflict: Garlaige Citadel [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{164} },
        flags = set{"repeat"},
        reward = { sparks = 16, xp = 800, unity = 5, item = { 13466 } },
    },

    [ 589] = { -- Conflict: Beaucedine Glacier [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{136} },
        flags = set{"repeat"},
        reward = { sparks = 70, xp = 850, unity = 7, item = { 15805 } },
    },

    [ 591] = { -- Conflict: Xarcabard [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{137} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 12385 } },
    },

    [ 593] = { -- Conflict: Castle Zvahl Baileys [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{138} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 15539 } },
    },

    [ 595] = { -- Conflict: Castle Zvahl Keep [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{155} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 15780 } },
    },

  ----------------------------------------
  -- Combat (Region) - Abyssea 1        --
  ----------------------------------------

    [ 613] = { -- Conflict: Abyssea - La Theine
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{132} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 10914 } },
    },

    [ 614] = { -- Conflict: Abyssea - Konschtat
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{15} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 15891 } },
    },

    [ 615] = { -- Conflict: Abyssea - Tahrongi
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{45} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 11765 } },
    },

    [ 616] = { -- Conflict: Abyssea - Attohwa
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{215} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 11763 } },
    },

    [ 617] = { -- Conflict: Abyssea - Misareaux
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{216} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 10966 } },
    },

    [ 618] = { -- Conflict: Abyssea - Vunkerl
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{217} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 10964 } },
    },

    [ 619] = { -- Conflict: Abyssea - Altepa
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{218} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 10968 } },
    },

    [ 620] = { -- Conflict: Abyssea - Uleguerand
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{253} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 11664 } },
    },

    [ 621] = { -- Conflict: Abyssea - Grauberg
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{254} },
        flags = set{"repeat"},
        reward = { sparks = 80, xp = 900, unity = 8, item = { 11644 } },
    },

  ----------------------------------------
  -- Combat (Region) - Escha 1          --
  ----------------------------------------

  ----------------------------------------
  -- Combat (Region) - Escha 2          --
  ----------------------------------------

  ----------------------------------------
  -- Other - Daily Objectives           --
  ----------------------------------------

    [4082] = { -- Vanquish Multiple Enemies (D)
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { mobXP = true },
        flags = set{"daily"},
        reward = { sparks = 100, xp = 500, unity = 300, item = { 8711 } },
    },


  ----------------------------------------
  -- Timed Records - No Category        --
  ----------------------------------------

    [4008] = {   -- Vanquish Aquans
        trigger = triggers.mobKill,
        goal = 20,
        reqs = { mobXP = true, mobSystem = set{tpz.eco.AQUAN} },
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
    },

    [4009] = {   -- Vanquish Beasts
        trigger = triggers.mobKill,
        goal = 20,
        reqs = { mobXP = true, mobSystem = set{tpz.eco.BEAST} },
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
    },

    [4010] = {   -- Vanquish Plantoids
        trigger = triggers.mobKill,
        goal = 20,
        reqs = { mobXP = true, mobSystem = set{tpz.eco.PLANTOID} },
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
    },

    [4011] = {   -- Vanquish Lizards
        trigger = triggers.mobKill,
        goal = 20,
        reqs = { mobXP = true, mobSystem = set{tpz.eco.LIZARD} },
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
    },

    [4012] = {   -- Vanquish Vermin
        trigger = triggers.mobKill,
        goal = 20,
        reqs = { mobXP = true, mobSystem = set{tpz.eco.VERMIN} },
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
    },

    [4013] = { -- Gain Experience
        trigger = triggers.expGain,
        goal = 5000,
        increment = 0,
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        check = function(self, player, params)
                if params.exp and params.exp > 0 then
                    params.progress = params.progress + params.exp
                    return true
                end
                return false
            end,
    },

    [4014] = {   -- Spoils (Seals)
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{1126, 1127, 2955, 2956, 2957} },
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
    },

    [4015] = {   -- Vanquish Birds (TODO: No abyssea zone kills for vanquishes when exists)
        trigger = triggers.mobKill,
        goal = 20,
        reqs = { mobXP = true, mobSystem = set{tpz.eco.BIRD} },
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
    },

    [4016] = {   -- Vanquish Amorphs
        trigger = triggers.mobKill,
        goal = 20,
        reqs = { mobXP = true, mobSystem = set{tpz.eco.AMORPH} },
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
    },

    [4017] = {   -- Vanquish Undead
        trigger = triggers.mobKill,
        goal = 20,
        reqs = { mobXP = true, mobSystem = set{tpz.eco.UNDEAD} },
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
    },

    [4018] = {   -- Vanquish Arcana
        trigger = triggers.mobKill,
        goal = 20,
        reqs = { mobXP = true, mobSystem = set{tpz.eco.ARCANA} },
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
    },

    [4019] = {   -- Crack Treasure Caskets (Triggered from caskets.lua)
        goal = 10,
        flags = set{"timed", "repeat"},
        reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
    },

    -- [4020] = {  -- Physical Damage Kills
    -- [4021] = {  -- Magic Damage Kills
}


 -- Apply defaults for records
for i,v in pairs(tpz.roe.records) do
    setmetatable(v, { __index = defaults })
end

-- Build global map of implemented records.
-- This is used to deny taking records which aren't implemented in the above table.
RoeParseRecords(tpz.roe.records)
