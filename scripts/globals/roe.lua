------------------------------------
-- Records of Eminence
------------------------------------
require("scripts/globals/status")

tpz = tpz or {}
tpz.roe = tpz.roe or {}

tpz.roe.triggers =
{
    mobKill = 1,        -- Player kills a Mob (Counts for mobs killed by partymembers)
    wSkillUse = 2,      -- Player Weapon skill used
    itemLooted = 3,     -- Player successfully loots an item
    synthSuccess = 4,   -- Player synth success
    dmgTaken = 5,       -- Player takes Damage
    dmgDealt = 6,       -- Player deals Damage
}
local triggers = tpz.roe.triggers

tpz.roe.checks = {}
local checks = tpz.roe.checks

-- Main general check function for all-purpose use.
-- Some functions may specify custom handlers (ie. gain exp or deal dmg.)
checks.masterCheck = function(self, player, params)
    for func in pairs(self.reqs) do
        if not checks[func] or not checks[func](self, player, params) then
            return false
        end
    end
    return true
end


checks.mobID = function(self, player, params)    -- Mob ID check
    return (params.mob and self.reqs.mobID[params.mob:getID()]) and true or false
end

checks.mobXP = function(self, player, params)  -- Mob yields xp
     return (params.mob and player:checkKillCredit(params.mob)) and true or false
end

checks.dmgMin = function(self, player, params)  -- Minimum Dmg Dealt/Taken
     return (params.dmg and params.dmg >= self.reqs.dmgMin) and true or false
end

checks.dmgMax = function(self, player, params)  -- Maximum Dmg Dealt/Taken
     return (params.dmg and params.dmg <= self.reqs.dmgMax) and true or false
end

checks.zone = function(self, player, params)  -- Player in Zone
     return (self.reqs.zone[player:getZoneID()]) and true or false
end

checks.zoneNot = function(self, player, params)  -- Player not in Zone
     return (not self.reqs.zoneNot[player:getZoneID()]) and true or false
end

checks.itemID = function(self, player, params)  -- itemid in set
     return (params.itemid and self.reqs.itemID[params.itemid]) and true or false
end

checks.levelSync = function(self, player, params)  -- Player is Level Sync'd
     return self.reqs.levelSync and player:isLevelSync() and true or false
end


local defaults = {
    check = checks.masterCheck, -- Check function should return true/false
    increment = 1,              -- Amount to increment per successful check
    notify = 1,                 -- Progress notifications shown every X increases 
    goal = 1,                   -- Progress goal
    reqs = {},                  -- Other requirements. List of function names from above, with required values.
    reward = {},                -- Reward parameters give on completion. (See completeRecord directly below.)
}

--[[ **************************************************************************
    Complete a record of eminence. This is for internal roe use only.
    If record rewards items, and the player cannot carry them, return false.
    Otherwise, return true.
    Example of usage with params (all params are optional):
        npcUtil.completeRecord(player, record#, {
            item = { {640,2}, 641 },          -- see npcUtil.giveItem for formats (Only given on first completion)
            keyItem = tpz.ki.ZERUHN_REPORT,   -- see npcUtil.giveKeyItem for formats
            sparks = 500,
            xp = 1000
        })
     *************************************************************************** --]]
local function completeRecord(player, record, params)
    local params = params or {}

    if not player:getEminenceCompleted(record) and params["item"] then
        if not npcUtil.giveItem(player, params["item"]) then
            player:messageBasic(tpz.msg.basic.ROE_UNABLE_BONUS_ITEM)
            return false
        end
    end

    player:messageBasic(tpz.msg.basic.ROE_COMPLETE,record)

    if params["sparks"] ~= nil and type(params["sparks"]) == "number" then
        local bonus = 1
        if player:getEminenceCompleted(record) then
            player:addCurrency('spark_of_eminence', params["sparks"] * bonus * SPARKS_RATE)
            player:messageBasic(tpz.msg.basic.ROE_RECEIVE_SPARKS, params["sparks"] * SPARKS_RATE, player:getCurrency("spark_of_eminence"))
        else
            bonus = 3
            player:addCurrency('spark_of_eminence', params["sparks"] * bonus * SPARKS_RATE)
            player:messageBasic(tpz.msg.basic.ROE_FIRST_TIME_SPARKS, params["sparks"] * bonus * SPARKS_RATE, player:getCurrency("spark_of_eminence"))
        end
    end

    if params["xp"] ~= nil and type(params["xp"]) == "number" then
        player:addExp(params["xp"] * ROE_EXP_RATE)
    end

    if params["keyItem"] ~= nil then
        npcUtil.giveKeyItem(player, params["keyItem"])
    end

    -- successfully complete the record
    if params["repeatable"] then
        player:messageBasic(tpz.msg.basic.ROE_REPEAT_OR_CANCEL)
        player:setEminenceCompleted(record, 1)
    else
        player:setEminenceCompleted(record)
    end
    return true
end


-- *** onRecordTrigger is the primary entry point for all record calls. ***
-- Even records which are completed through Lua scripts should point here and
-- have record information entered in the table below. This keeps everything neat.

function tpz.roe.onRecordTrigger(player, recordID, params)
    local entry = tpz.roe.records[recordID]
    if entry and entry:check(player, params) then
        local progress = (params and params.progress or player:getEminenceProgress(recordID)) + entry.increment
        if progress >= entry.goal then
            completeRecord(player, recordID, entry.reward)
        else
            player:setEminenceProgress(recordID, progress, entry.goal)
        end
    end
end
tpz.roe.completeRecord = tpz.roe.onRecordTrigger


-- All implemented records must have their entries in this table.
-- Records not in this table can't be taken.

tpz.roe.records =
{

  ----------------------------------------
  -- Tutorial -> Basics                 --
  ----------------------------------------

    [1   ] = { -- First Step Forward
        reward =  { item = { {4376,6} }, keyItem = tpz.ki.MEMORANDOLL, sparks = 100, xp = 300 }
    },

    [2   ] = { -- Vanquish 1 Enemy
        trigger = triggers.mobKill,
        reward =  { sparks = 100, xp = 500}
    },

    [3   ] = { -- Undertake a FoV Training Regime
        reward =  { sparks = 100, xp = 500}
    },

    [4   ] = { -- Heal without magic
        reward =  { sparks = 100, xp = 500}
    },

    [11  ] = { -- Undertake a GoV Training Regime
        reward =  { sparks = 100, xp = 500}
    },

  --------------------------------------------
  -- Combat (Wide Area) -> Combat (General) --
  --------------------------------------------

    [12  ] = { -- Vanquish Multiple Enemies I - 200
        trigger = triggers.mobKill,
        goal = 200,
        reqs = { mobXP = true },
        reward = { sparks = 1000, xp = 5000, unity = 100, repeatable = true },
    },

    [13  ] = { -- Vanquish Multiple Enemies II - 500
        trigger = triggers.mobKill,
        goal = 500,
        reqs = { mobXP = true },
        reward = { sparks = 2000, xp = 6000 , item = { 6180 } },
    },

    [14  ] = { -- Vanquish Multiple Enemies III - 750
        trigger = triggers.mobKill,
        goal = 750,
        reqs = { mobXP = true },
        reward = { sparks = 5000, xp = 10000 , item = { 6183 } },
    },

    [15  ] = { -- Level Sync to Vanquish I
        trigger = triggers.mobKill,
        goal = 200,
        reqs = { mobXP = true , levelSync = true},
        reward = { sparks = 2000, xp = 6000 , unity = 200 },
    },

    [117 ] = { -- Level Sync to Vanquish II
        trigger = triggers.mobKill,
        goal = 20,
        reqs = { mobXP = true , levelSync = true},
        reward = { sparks = 200, xp = 600 , unity = 20 , repeatable = true },
    },

    [16  ] = { -- Deal 500+ Damage
        trigger = triggers.dmgDealt,
        goal = 200,
        reqs = { dmgMin = 500 },
        reward = { sparks = 1000, xp = 5000, unity = 100, repeatable = true},
    },

    [17  ] = { -- Deal 1000+ Damage
        trigger = triggers.dmgDealt,
        goal = 150,
        reqs = { dmgMin = 1000 },
        reward = { sparks = 1000, xp = 5000 },
    },

    [18  ] = { -- Deal 1500+ Damage
        trigger = triggers.dmgDealt,
        goal = 100,
        reqs = { dmgMin = 1500 },
        reward = { sparks = 1000, xp = 5000 },
    },

    [698 ] = { -- Deal 2000+ Damage
        trigger = triggers.dmgDealt,
        goal = 100,
        reqs = { dmgMin = 2000 },
        reward = { sparks = 2000, xp = 5000, item = { {8711, 6} } },
    },

    [19  ] = { -- Deal 10-20 Damage
        trigger = triggers.dmgDealt,
        goal = 10,
        reqs = { dmgMin = 10, dmgMax = 20 },
        reward = { sparks = 300, xp = 2500 },
    },

    [20  ] = { -- Deal 110-120 Damage
        trigger = triggers.dmgDealt,
        goal = 10,
        reqs = { dmgMin = 110, dmgMax = 120 },
        reward = { sparks = 300, xp = 1500 },
    },

    [21  ] = { -- Deal 310-320 Damage
        trigger = triggers.dmgDealt,
        goal = 10,
        reqs = { dmgMin = 310, dmgMax = 320 },
        reward = { sparks = 300, xp = 1500 },
    },

    [22  ] = { -- Deal 510-520 Damage
        trigger = triggers.dmgDealt,
        goal = 10,
        reqs = { dmgMin = 510, dmgMax = 520 },
        reward = { sparks = 300, xp = 1500 },
    },

    [23  ] = { -- Deal 1110-1120 Damage
        trigger = triggers.dmgDealt,
        goal = 10,
        reqs = { dmgMin = 1110, dmgMax = 1120 },
        reward = { sparks = 300, xp = 1500, item = { {8711, 2} } },
    },

    [29  ] = { -- Total Damage I
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

    [30  ] = { -- Total Damage II
        trigger = triggers.dmgDealt,
        goal = 200000,
        increment = 0,
        reward = { sparks = 3000, xp = 7000 , item = { 6184 } },
        check = function(self, player, params)
                if params.dmg and params.dmg > 0 then
                    params.progress = params.progress + params.dmg
                    return true
                end
                return false
            end
    },

    [696 ] = { -- Total Damage III
        trigger = triggers.dmgDealt,
        goal = 300000,
        increment = 0,
        reward = { sparks = 3000, xp = 7000 , item = { 6184 } },
        check = function(self, player, params)
                if params.dmg and params.dmg > 0 then
                    params.progress = params.progress + params.dmg
                    return true
                end
                return false
            end
    },

    [33  ] = { -- Total Damage Taken I
        trigger = triggers.dmgTaken,
        goal = 10000,
        increment = 0,
        reward = { sparks = 1000, xp = 1000, item = { {8711, 2} } },
        check = function(self, player, params)
                if params.dmg and params.dmg > 0 then
                    params.progress = params.progress + params.dmg
                    return true
                end
                return false
            end
    },

    [34  ] = { -- Total Damage Taken II
        trigger = triggers.dmgTaken,
        goal = 20000,
        increment = 0,
        reward = { sparks = 3000, xp = 5000, item = { {8711, 4} } },
        check = function(self, player, params)
                if params.dmg and params.dmg > 0 then
                    params.progress = params.progress + params.dmg
                    return true
                end
                return false
            end
    },

    [697 ] = { -- Total Damage Taken III
        trigger = triggers.dmgTaken,
        goal = 30000,
        increment = 0,
        reward = { sparks = 3000, xp = 5000, item = { {8711, 6} } },
        check = function(self, player, params)
                if params.dmg and params.dmg > 0 then
                    params.progress = params.progress + params.dmg
                    return true
                end
                return false
            end
    },

    [45  ] = { -- Weapon Skills 1
        trigger = triggers.wSkillUse,
        goal = 100,
        reward = { sparks = 500, xp = 2500 },
    },

  --------------------------------------------
  -- Crafting: General                      --
  --------------------------------------------

    [57  ] = { -- Total Successful Synthesis Attempts
        trigger = triggers.synthSuccess,
        goal = 30,
        reward = { sparks = 100, xp = 500, unity = 10, repeatable = true },
    },

  --------------------------------------------
  -- Combat (Wide Area) -> Spoils 1         --
  --------------------------------------------

    [71  ] = { -- Spoils - Fire Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4096 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [72  ] = { -- Spoils - Ice Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4097 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [73  ] = { -- Spoils - Wind Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4098 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [74  ] = { -- Spoils - Earth Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4099 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [75  ] = { -- Spoils - Lightning Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4100 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [76  ] = { -- Spoils - Water Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4101 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [77  ] = { -- Spoils - Light Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4102 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [78  ] = { -- Spoils - Dark Crystals
        trigger = triggers.itemLooted,
        goal = 10,
        reqs = { itemID = set{ 4103 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [84  ] = { -- Spoils - Flame Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3297 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [85  ] = { -- Spoils - Snow Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3298 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [86  ] = { -- Spoils - Breeze Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3299 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [87  ] = { -- Spoils - Soil Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3300 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [88  ] = { -- Spoils - Thunder Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3301 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [89  ] = { -- Spoils - Aqua Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3302 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [90  ] = { -- Spoils - Light Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3303 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [91  ] = { -- Spoils - Shadow Geode
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3304 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [92  ] = { -- Spoils - Ifritite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3520 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [93  ] = { -- Spoils - Shivite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3521 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [94  ] = { -- Spoils - Garudite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3522 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [95  ] = { -- Spoils - Titanite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3523 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [96  ] = { -- Spoils - Ramuite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3524 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [97  ] = { -- Spoils - Leviatite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3525 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [98  ] = { -- Spoils - Carbite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3526 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

    [99  ] = { -- Spoils - Fenrite
        trigger = triggers.itemLooted,
        goal = 3,
        reqs = { itemID = set{ 3527 } },
        reward = { sparks = 200, xp = 1000, unity = 20, repeatable = true },
    },

  --------------------------------------------
  -- Combat (Wide Area) -> Spoils 2         --
  --------------------------------------------

    [120 ] = { -- Spoils - Bat Wing
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 922 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [121 ] = { -- Spoils - Black Tiger Fang
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 884 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [122 ] = { -- Spoils - Flint Stone
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 768 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [123 ] = { -- Spoils - Rabbit Hide
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 856 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [124 ] = { -- Spoils - Honey
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 4370 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [125 ] = { -- Spoils - Sheepskin
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 505 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [126 ] = { -- Spoils - Lizard Skin
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 852 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [127 ] = { -- Spoils - Beetle Shell
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 889 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [128 ] = { -- Spoils - Zeruhn Soot
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 560 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [129 ] = { -- Spoils - Silver Name Tag
        trigger = triggers.itemLooted,
        goal = 1,
        reqs = { itemID = set{ 13116 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [130 ] = { -- Spoils - Quadav Helm
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 501 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [132 ] = { -- Spoils - Treant Bulb
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 953 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [133 ] = { -- Spoils - Wild Onion
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 4387 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [134 ] = { -- Spoils - Sleepshroom
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 4374 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [135 ] = { -- Spoils - Sand Bat Fang
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 1015 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [136 ] = { -- Spoils - Zinc Ore
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 642 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [137 ] = { -- Spoils - Giant Bird Feather
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 842 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [138 ] = { -- Spoils - Three-leaf Mandragora Bud
        trigger = triggers.itemLooted,
        goal = 1,
        reqs = { itemID = set{ 1154 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [139 ] = { -- Spoils - Four-leaf Mandragora Bud
        trigger = triggers.itemLooted,
        goal = 1,
        reqs = { itemID = set{ 4369 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [140 ] = { -- Spoils - Cornette
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 17344 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [141 ] = { -- Spoils - Yuhtunga Sulfur
        trigger = triggers.itemLooted,
        goal = 1,
        reqs = { itemID = set{ 934 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [142 ] = { -- Spoils - Snobby Letter
        trigger = triggers.itemLooted,
        goal = 1,
        reqs = { itemID = set{ 1150 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [143 ] = { -- Spoils - Yagudo Bead Necklace
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 498 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [144 ] = { -- Spoils - Woozyshroom
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 4373 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [145 ] = { -- Spoils - Beehive Chip
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 912 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [146 ] = { -- Spoils - Remi Shell
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 1016 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

    [147 ] = { -- Spoils - Twinstone Earring
        trigger = triggers.itemLooted,
        goal = 2,
        reqs = { itemID = set{ 13360 } },
        reward = { sparks = 100, xp = 300, unity = 10, repeatable = true },
    },

  ----------------------------------------
  -- Combat (Region) - Original Areas 1 --
  ----------------------------------------

    [215 ] = { -- Conflict: West Ronfaure
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{100} },
        reward = { sparks = 10, xp = 500, unity = 5, item = { 4439 }, repeatable = true },
    },

    [216 ] = { -- Subjugation: Jaggedy-Eared Jack
        trigger = triggers.mobKill,
        reqs = { mobID = set{17187111} },
        reward = { sparks = 250, xp = 500 },
    },

    [217 ] = { -- Conflict: East Ronfaure
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{101} },
        reward = { sparks = 10, xp = 500, unity = 5, item = { 12577 }, repeatable = true },
    },

    [218 ] = { -- Subjugation: Swamfisk
        trigger = triggers.mobKill,
        reqs = { mobID = set{17191189, 17191291} },
        reward = { sparks = 250, xp = 500 },
    },

    [219 ] = { -- Conflict: Ghelsba Outpost
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{140} },
        reward = { sparks = 10, xp = 500, unity = 5, item = { 13331 }, repeatable = true },
    },

    [220 ] = { -- Subjugation: Thousandarm Deshglesh
        trigger = triggers.mobKill,
        reqs = { mobID = set{17350826} },
        reward = { sparks = 250, xp = 550 },
    },

    [221 ] = { -- Conflict: Fort Ghelsba
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{141} },
        reward = { sparks = 10, xp = 500, unity = 5, item = { 13333 }, repeatable = true },
    },

    [222 ] = { -- Subjugation: Hundredscar Hajwaj
        trigger = triggers.mobKill,
        reqs = { mobID = set{17354828} },
        reward = { sparks = 500, xp = 1000 },
    },

    [223 ] = { -- Conflict: Yughott Grotto
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{142} },
        reward = { sparks = 10, xp = 500, unity = 5, item = { 13336 }, repeatable = true },
    },

    [224 ] = { -- Subjugation: Ashmaker Gotblut
        trigger = triggers.mobKill,
        reqs = { mobID = set{17358932} },
        reward = { sparks = 250, xp = 500 },
    },

    [225 ] = { -- Conflict: King Ranperre's Tomb
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{190} },
        reward = { sparks = 10, xp = 100, unity = 5, item = { 13443 }, repeatable = true },
    },

    [226 ] = { -- Subjugation: Barbastelle
        trigger = triggers.mobKill,
        reqs = { mobID = set{17555721} },
        reward = { sparks = 250, xp = 500 },
    },

    [227 ] = { -- Conflict: Bostaunieux Oubliette
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{167} },
        reward = { sparks = 15, xp = 100, unity = 5, item = { 11532 }, repeatable = true },
    },

    [228 ] = { -- Subjugation: Bloodsucker
        trigger = triggers.mobKill,
        reqs = { mobID = set{17461478} },
        reward = { sparks = 500, xp = 1000 },
    },

    [229 ] = { -- Conflict: Valkurm Dunes
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{103} },
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13456 }, repeatable = true },
    },

    [230 ] = { -- Subjugation: Valkurm Emperor
        trigger = triggers.mobKill,
        reqs = { mobID = set{17199438} },
        reward = { sparks = 250, xp = 550 },
    },

    [231 ] = { -- Conflict: Konschtat Highlands
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{108} },
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13472 }, repeatable = true },
    },

    [232 ] = { -- Subjugation: Bendigeit Vran
        trigger = triggers.mobKill,
        reqs = { mobID = set{17220001} },
        reward = { sparks = 250, xp = 600 },
    },

    [233 ] = { -- Conflict: Gusgen Mines
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{196} },
        reward = { sparks = 11, xp = 100, unity = 5, item = { 13471 }, repeatable = true },
    },

    [234 ] = { -- Subjugation: Juggler Hecatomb
        trigger = triggers.mobKill,
        reqs = { mobID = set{17580248} },
        reward = { sparks = 250, xp = 600 },
    },

    [235 ] = { -- Conflict: La Theine Plateau
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{102} },
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13444 }, repeatable = true },
    },

    [236 ] = { -- Subjugation: Bloodtear Baldurf
        trigger = triggers.mobKill,
        reqs = { mobID = set{17195318} },
        reward = { sparks = 500, xp = 1000 },
    },


    [237 ] = { -- Conflict: Ordelle's Caves
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{102} },
        reward = { sparks = 12, xp = 100, unity = 5, item = { 13470 }, repeatable = true },
    },

    [238 ] = { -- Subjugation: Morbolger
        trigger = triggers.mobKill,
        reqs = { mobID = set{17568127} },
        reward = { sparks = 500, xp = 1000 },
    },

  ----------------------------------------
  -- Combat (Region) - Original Areas 2 --
  ----------------------------------------

    [239 ] = { -- Conflict: Jugner Forest
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{104} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { {4381, 12} }, repeatable = true },
    },

    [240 ] = { -- Subjugation: King Arthro
        trigger = triggers.mobKill,
        reqs = { mobID = set{17203216} },
        reward = { sparks = 500, xp = 1000 },
    },

    [241 ] = { -- Conflict: Batallia Downs
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{105} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13685 }, repeatable = true },
    },

    [242 ] = { -- Subjugation: Lumber Jack
        trigger = triggers.mobKill,
        reqs = { mobID = set{17207308} },
        reward = { sparks = 500, xp = 1000 },
    },

    [243 ] = { -- Conflict: Eldieme Necropolis
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{195} },
        reward = { sparks = 14, xp = 100, unity = 5, item = { 13198 }, repeatable = true },
    },

    [244 ] = { -- Subjugation: Cwn Cyrff
        trigger = triggers.mobKill,
        reqs = { mobID = set{17576054} },
        reward = { sparks = 250, xp = 800 },
    },

    [245 ] = { -- Conflict: Davoi
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{149} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 12554 }, repeatable = true },
    },

    [246 ] = { -- Subjugation: Hawkeyed Dnatbat
        trigger = triggers.mobKill,
        reqs = { mobID = set{17387567} },
        reward = { sparks = 250, xp = 600 },
    },

    [247 ] = { -- Conflict: N. Gustaberg
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{106} },
        reward = { sparks = 10, xp = 500, unity = 5, item = { 4488 }, repeatable = true },
    },

    [248 ] = { -- Subjugation: Maighdean Uaine
        trigger = triggers.mobKill,
        reqs = { mobID = set{17211702, 17211714} },
        reward = { sparks = 250, xp = 500 },
    },

    [249 ] = { -- Conflict: S. Gustaberg
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{107} },
        reward = { sparks = 10, xp = 500, unity = 5, item = { 12592 }, repeatable = true },
    },

    [250 ] = { -- Subjugation: Carnero
        trigger = triggers.mobKill,
        reqs = { mobID = set{17215613, 17215626} },
        reward = { sparks = 250, xp = 500 },
    },

    [251 ] = { -- Conflict: Zeruhn Mines
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{172} },
        reward = { sparks = 10, xp = 100, unity = 5, item = { 13335 }, repeatable = true },
    },

    [252 ] = { -- Conflict: Palborough Mines
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{143} },
        reward = { sparks = 10, xp = 500, unity = 5, item = { 13330 }, repeatable = true },
    },

    [253 ] = { -- Subjugation: Zi-Ghi Bone-eater
        trigger = triggers.mobKill,
        reqs = { mobID = set{17363208} },
        reward = { sparks = 250, xp = 500 },
    },

    [254 ] = { -- Conflict: Dangruf Wadi
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{191} },
        reward = { sparks = 10, xp = 100, unity = 5, item = { 13473 }, repeatable = true },
    },

    [255 ] = { -- Subjugation: Teporingo
        trigger = triggers.mobKill,
        reqs = { mobID = set{17559584} },
        reward = { sparks = 250, xp = 500 },
    },

    [256 ] = { -- Conflict: Pashhow Marshlands
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{109} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { {5721, 12} }, repeatable = true },
    },

    [257 ] = { -- Subjugation: Ni'Zho Bladebender
        trigger = triggers.mobKill,
        reqs = { mobID = set{17223797} },
        reward = { sparks = 250, xp = 700 },
    },

    [258 ] = { -- Conflict: Rolanberry Fields
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{110} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { 15487 }, repeatable = true },
    },

    [259 ] = { -- Subjugation: Simurgh
        trigger = triggers.mobKill,
        reqs = { mobID = set{17228242} },
        reward = { sparks = 250, xp = 1000 },
    },

    [260 ] = { -- Conflict: Crawler's Nest
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{197} },
        reward = { sparks = 14, xp = 100, unity = 5, item = { 13271 }, repeatable = true },
    },

    [261 ] = { -- Subjugation: Demonic Tiphia
        trigger = triggers.mobKill,
        reqs = { mobID = set{17584398} },
        reward = { sparks = 250, xp = 800 },
    },

    [262 ] = { -- Conflict: Beadeaux
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{147} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13703 }, repeatable = true },
    },

    [263 ] = { -- Subjugation: Zo'Khu Blackcloud
        trigger = triggers.mobKill,
        reqs = { mobID = set{17379564} },
        reward = { sparks = 250, xp = 700 },
    },

  ----------------------------------------
  -- Combat (Region) - Original Areas 3 --
  ----------------------------------------

    [264 ] = { -- Conflict: West Sarutabaruta
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{115} },
        reward = { sparks = 10, xp = 500, unity = 5, item = { 4498 }, repeatable = true },
    },

    [265 ] = { -- Subjugation: Nunyenunc
        trigger = triggers.mobKill,
        reqs = { mobID = set{17248517} },
        reward = { sparks = 250, xp = 500 },
    },

    [266 ] = { -- Conflict: East Sarutabaruta
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{116} },
        reward = { sparks = 10, xp = 500, unity = 5, item = { 12601 }, repeatable = true },
    },

    [267 ] = { -- Subjugation: Spiny Spipi
        trigger = triggers.mobKill,
        reqs = { mobID = set{17252657} },
        reward = { sparks = 250, xp = 500 },
    },

    [268 ] = { -- Conflict: Giddeus
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{145} },
        reward = { sparks = 10, xp = 500, unity = 5, item = { 13337 }, repeatable = true },
    },

    [269 ] = { -- Subjugation: Hoo Mjuu the Torrent
        trigger = triggers.mobKill,
        reqs = { mobID = set{17371515} },
        reward = { sparks = 250, xp = 500 },
    },

    [270 ] = { -- Conflict: Toraimarai Canal
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{169} },
        reward = { sparks = 15, xp = 100, unity = 5, item = { 13586 }, repeatable = true },
    },

    [271 ] = { -- Subjugation: Oni Carcass
        trigger = triggers.mobKill,
        reqs = { mobID = set{17469587} },
        reward = { sparks = 250, xp = 800 },
    },

    [272 ] = { -- Conflict: Inner Horutoto Ruins
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{192} },
        reward = { sparks = 10, xp = 100, unity = 5, item = { 13332 }, repeatable = true },
    },

    [273 ] = { -- Subjugation: Maltha
        trigger = triggers.mobKill,
        reqs = { mobID = set{17563749} },
        reward = { sparks = 250, xp = 500 },
    },

    [274 ] = { -- Conflict: Outer Horutoto Ruins
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{194} },
        reward = { sparks = 10, xp = 100, unity = 5, item = { 13334 }, repeatable = true },
    },

    [275 ] = { -- Subjugation: Bomb King
        trigger = triggers.mobKill,
        reqs = { mobID = set{17572094, 17572142, 17572146} },
        reward = { sparks = 250, xp = 500 },
    },

    [276 ] = { -- Conflict: Buburimu Peninsula
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{118} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13474 }, repeatable = true },
    },

    [277 ] = { -- Subjugation: Helldiver
        trigger = triggers.mobKill,
        reqs = { mobID = set{17260907} },
        reward = { sparks = 250, xp = 600 },
    },

    [278 ] = { -- Conflict: Tahrongi Canyon
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{117} },
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13468 }, repeatable = true },
    },

    [279 ] = { -- Subjugation: Serpopard Ishtar
        trigger = triggers.mobKill,
        reqs = { mobID = set{17256563, 17256690} },
        reward = { sparks = 250, xp = 600 },
    },

    [280 ] = { -- Conflict: Maze of Shakhrami
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{198} },
        reward = { sparks = 12, xp = 100, unity = 5, item = { 13321 }, repeatable = true },
    },

    [281 ] = { -- Subjugation: Argus
        trigger = triggers.mobKill,
        reqs = { mobID = set{17588674} },
        reward = { sparks = 500, xp = 1000 },
    },

    [282 ] = { -- Conflict: Meriphataud Mountains
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{119} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { {4413, 12} }, repeatable = true },
    },

    [283 ] = { -- Subjugation: Daggerclaw Dracos
        trigger = triggers.mobKill,
        reqs = { mobID = set{17264818} },
        reward = { sparks = 250, xp = 600 },
    },

    [284 ] = { -- Conflict: Sauromugue Champaign
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{120} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13577 }, repeatable = true },
    },

    [285 ] = { -- Subjugation: Roc
        trigger = triggers.mobKill,
        reqs = { mobID = set{17269106} },
        reward = { sparks = 500, xp = 1000 },
    },

    [286 ] = { -- Conflict: Garlaige Citadel
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{200} },
        reward = { sparks = 14, xp = 100, unity = 5, item = { 15907 }, repeatable = true },
    },

    [287 ] = { -- Subjugation: Serket
        trigger = triggers.mobKill,
        reqs = { mobID = set{17596720} },
        reward = { sparks = 500, xp = 1000 },
    },

    [288 ] = { -- Conflict: Castle Oztroja
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{200} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13723 }, repeatable = true },
    },

    [289 ] = { -- Subjugation: Lii Jixa the Somnolist
        trigger = triggers.mobKill,
        reqs = { mobID = set{17395896} },
        reward = { sparks = 250, xp = 800 },
    },

  ----------------------------------------
  -- Combat (Region) - Original Areas 4 --
  ----------------------------------------

    [290 ] = { -- Conflict: Beaucedine Glacier
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{111} },
        reward = { sparks = 14, xp = 700, unity = 5, item = { 16261 }, repeatable = true },
    },

    [291 ] = { -- Subjugation: Nue
        trigger = triggers.mobKill,
        reqs = { mobID = set{17231971} },
        reward = { sparks = 250, xp = 700 },
    },

    [292 ] = { -- Conflict: Ranguemont Pass
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{166} },
        reward = { sparks = 11, xp = 100, unity = 5, item = { 13323 }, repeatable = true },
    },

    [293 ] = { -- Subjugation: Gloom Eye
        trigger = triggers.mobKill,
        reqs = { mobID = set{17457204} },
        reward = { sparks = 250, xp = 700 },
    },

    [294 ] = { -- Conflict: Fei'Yin
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{204} },
        reward = { sparks = 14, xp = 100, unity = 5, item = { 13324 }, repeatable = true },
    },

    [295 ] = { -- Subjugation: Goliath
        trigger = triggers.mobKill,
        reqs = { mobID = set{17613046, 17613048, 17613052, 17613054} },
        reward = { sparks = 250, xp = 800 },
    },

    [296 ] = { -- Conflict: Xarcabard
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{112} },
        reward = { sparks = 14, xp = 700, unity = 5, item = { 13315 }, repeatable = true },
    },

    [297 ] = { -- Subjugation: Biast
        trigger = triggers.mobKill,
        reqs = { mobID = set{17235988} },
        reward = { sparks = 500, xp = 1000 },
    },

    [298 ] = { -- Conflict: Castle Zvahl Baileys
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{161} },
        reward = { sparks = 15, xp = 750, unity = 5, item = { 13688 }, repeatable = true },
    },

    [299 ] = { -- Subjugation: Duke Haborym
        trigger = triggers.mobKill,
        reqs = { mobID = set{17436923} },
        reward = { sparks = 500, xp = 1000 },
    },

    [300 ] = { -- Conflict: Castle Zvahl Keep
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{162} },
        reward = { sparks = 15, xp = 750, unity = 5, item = { 13689 }, repeatable = true },
    },

    [301 ] = { -- Subjugation: Baron Vapula
        trigger = triggers.mobKill,
        reqs = { mobID = set{17440963} },
        reward = { sparks = 250, xp = 800 },
    },

    [302 ] = { -- Conflict: Qufim Island
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{126} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 16301 }, repeatable = true },
    },

    [303 ] = { -- Subjugation: Dosetsu Tree
        trigger = triggers.mobKill,
        reqs = { mobID = set{17293640} },
        reward = { sparks = 500, xp = 1000 },
    },

    [304 ] = { -- Conflict: Lower Delkfutt's Tower
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{184} },
        reward = { sparks = 13, xp = 100, unity = 5, item = { {5147, 12} }, repeatable = true },
    },

    [305 ] = { -- Subjugation: Epialtes
        trigger = triggers.mobKill,
        reqs = { mobID = set{17530881} },
        reward = { sparks = 250, xp = 700 },
    },

    [306 ] = { -- Conflict: Middle Delkfutt's Tower
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{157} },
        reward = { sparks = 13, xp = 100, unity = 5, item = { {5149, 12} }, repeatable = true },
    },

    [307 ] = { -- Subjugation: Ogygos
        trigger = triggers.mobKill,
        reqs = { mobID = set{17420592} },
        reward = { sparks = 250, xp = 700 },
    },

    [308 ] = { -- Conflict: Upper Delkfutt's Tower
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{158} },
        reward = { sparks = 14, xp = 100, unity = 5, item = { {5757, 12} }, repeatable = true },
    },

    [309 ] = { -- Subjugation: Enkelados
        trigger = triggers.mobKill,
        reqs = { mobID = set{17424385, 17424423} },
        reward = { sparks = 250, xp = 800 },
    },

    [380 ] = { -- Conflict: Behemoth's Dominion
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{127} },
        reward = { sparks = 14, xp = 100, unity = 5, item = { {4398, 12} }, repeatable = true },
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

    [390 ] = { -- Conflict: Sanctuary of Zi'Tah
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{121} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { {4151, 12} }, repeatable = true },
    },

    [392 ] = { -- Conflict: Ro'Maeve
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{122} },
        reward = { sparks = 16, xp = 800, unity = 5, item = { {4156, 12} }, repeatable = true },
    },

    [394 ] = { -- Conflict: Boyahda Tree
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{153} },
        reward = { sparks = 16, xp = 100, unity = 5, item = { {4166, 12} }, repeatable = true },
    },

    [396 ] = { -- Conflict: Dragon's Aery
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{154} },
        reward = { sparks = 17, xp = 850, unity = 5, item = { 4136 }, repeatable = true },
    },

    [398 ] = { -- Conflict: Eastern Altepa Desert
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{114} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { {4164, 12} }, repeatable = true },
    },

    [400 ] = { -- Conflict: Western Altepa Desert
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{125} },
        reward = { sparks = 14, xp = 700, unity = 5, item = { {4165, 12} }, repeatable = true },
    },

    [402 ] = { -- Conflict: Quicksand Caves
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{208} },
        reward = { sparks = 15, xp = 100, unity = 5, item = { 13637 }, repeatable = true },
    },

    [404 ] = { -- Conflict: Gustav Tunnel
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{212} },
        reward = { sparks = 16, xp = 100, unity = 5, item = { 13579 }, repeatable = true },
    },

    [406 ] = { -- Conflict: Kuftal Tunnel
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{174} },
        reward = { sparks = 14, xp = 100, unity = 5, item = { 16233 }, repeatable = true },
    },

    [408 ] = { -- Conflict: Cape Terrigan
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{113} },
        reward = { sparks = 16, xp = 800, unity = 5, item = { 16263 }, repeatable = true },
    },

    [410 ] = { -- Conflict: Valley of Sorrows
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{128} },
        reward = { sparks = 16, xp = 800, unity = 5, item = { 13108 }, repeatable = true },
    },

    [412 ] = { -- Conflict: Yuhtunga Jungle
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{123} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13125 }, repeatable = true },
    },

  ----------------------------------------
  -- Combat (Region) - Zilart 2         --
  ----------------------------------------

    [414 ] = { -- Conflict: Sea Serpent Grotto
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{176	} },
        reward = { sparks = 13, xp = 100, unity = 5, item = { 13207 }, repeatable = true },
    },

    [416 ] = { -- Conflict: Yhoator Jungle
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{124} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13273 }, repeatable = true },
    },

    [418 ] = { -- Conflict: Temple of Uggalepih
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{159} },
        reward = { sparks = 15, xp = 100, unity = 5, item = { 15913 }, repeatable = true },
    },

    [420 ] = { -- Conflict: Den of Rancor
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{160} },
        reward = { sparks = 16, xp = 100, unity = 5, item = { 13208 }, repeatable = true },
    },

    [422 ] = { -- Conflict: Ifrit's Cauldron
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{205} },
        reward = { sparks = 16, xp = 100, unity = 5, item = { 13344 }, repeatable = true },
    },

    [424 ] = { -- Conflict: Ru'Aun Gardens
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{130} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13346 }, repeatable = true },
    },

    [426 ] = { -- Conflict: Ve'Lugannon Palace
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{177} },
        reward = { sparks = 70, xp = 100, unity = 7, item = { 13348 }, repeatable = true },
    },

    [428 ] = { -- Conflict: Shrine of Ru'Avitau
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{178} },
        reward = { sparks = 70, xp = 100, unity = 7, item = { 13343 }, repeatable = true },
    },

    [430 ] = { -- Conflict: Labyrinth of Onzozo
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{213} },
        reward = { sparks = 14, xp = 700, unity = 5, item = { 13345 }, repeatable = true },
    },

    [432 ] = { -- Conflict: Korroloka Tunnel
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{173} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13347 }, repeatable = true },
    },

  ----------------------------------------
  -- Combat (Region) - Promathia 1      --
  ----------------------------------------

    [434 ] = { -- Conflict: Oldton Movalpolos
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{11} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13350 }, repeatable = true },
    },

    [436 ] = { -- Conflict: Newton Movalpolos
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{12} },
        reward = { sparks = 16, xp = 800, unity = 5, item = { 13349 }, repeatable = true },
    },

    [438 ] = { -- Conflict: Lufaise Meadows
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{24} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 14725 }, repeatable = true },
    },

    [440 ] = { -- Conflict: Misareaux Coast
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{25} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13417 }, repeatable = true },
    },

    [442 ] = { -- Conflict: Phomiuna Aqueducts
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{27} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13325 }, repeatable = true },
    },

    [444 ] = { -- Conflict: Riverne - Site #A01
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{30} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13461 }, repeatable = true },
    },

    [446 ] = { -- Conflict: Riverne - Site #B01
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{29} },
        reward = { sparks = 14, xp = 700, unity = 5, item = { 15813 }, repeatable = true },
    },

    [448 ] = { -- Conflict: Sacrarium
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{28} },
        reward = { sparks = 14, xp = 700, unity = 5, item = { 13485 }, repeatable = true },
    },

    [450 ] = { -- Conflict: Promyvion - Holla
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{16} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13487 }, repeatable = true },
    },

    [452 ] = { -- Conflict: Promyvion - Dem
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{18} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13489 }, repeatable = true },
    },

    [454 ] = { -- Conflict: Promyvion - Mea
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{20} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13484 }, repeatable = true },
    },

    [456 ] = { -- Conflict: Yuhtunga Jungle
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{22} },
        reward = { sparks = 14, xp = 700, unity = 5, item = { 13486 }, repeatable = true },
    },

  ----------------------------------------
  -- Combat (Region) - Promathia 2      --
  ----------------------------------------

    [458 ] = { -- Conflict: Al'Taieu
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{33} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13488 }, repeatable = true },
    },

    [460 ] = { -- Conflict: Grand Palace of Hu'Xzoi
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{34} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13491 }, repeatable = true },
    },

    [462 ] = { -- Conflict: Garden of Ru'Hmet
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{35} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 17285 }, repeatable = true },
    },

    [464 ] = { -- Conflict: Carpenters' Landing
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{2} },
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13490 }, repeatable = true },
    },

    [468 ] = { -- Conflict: Bibiki Bay
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{4} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13546 }, repeatable = true },
    },

    [472 ] = { -- Conflict: Attohwa Chasm
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{7} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13464 }, repeatable = true },
    },

    [474 ] = { -- Conflict: Pso'Xja
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{9} },
        reward = { sparks = 14, xp = 700, unity = 5, item = { 13445 }, repeatable = true },
    },

    [476 ] = { -- Conflict: Uleguerand Range
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{5} },
        reward = { sparks = 16, xp = 800, unity = 5, item = { 13591 }, repeatable = true },
    },

  ----------------------------------------
  -- Combat (Region) - Aht Urhgan       --
  ----------------------------------------

    [533 ] = { -- Conflict: Bhaflau Thickets
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{52} },
        reward = { sparks = 60, xp = 800, unity = 6, item = { 12324 }, repeatable = true },
    },

    [535 ] = { -- Conflict: Mamook
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{65} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 12309 }, repeatable = true },
    },

    [537 ] = { -- Conflict: Wajaom Woodlands
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{51} },
        reward = { sparks = 60, xp = 800, unity = 6, item = { 13275 }, repeatable = true },
    },

    [539 ] = { -- Conflict: Aydeewa Subterrane
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{68} },
        reward = { sparks = 60, xp = 800, unity = 6, item = { 13197 }, repeatable = true },
    },

    [541 ] = { -- Conflict: Halvung
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{62} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 15890 }, repeatable = true },
    },

    [543 ] = { -- Conflict: Mount Zhayolm
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{61} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13629 }, repeatable = true },
    },

    [545 ] = { -- Conflict: Caedarva Mire
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{79} },
        reward = { sparks = 60, xp = 800, unity = 6, item = { 13212 }, repeatable = true },
    },

    [547 ] = { -- Conflict: Arrapago Reef
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{54} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 16235 }, repeatable = true },
    },

    [549 ] = { -- Conflict: Alza. Undersea Ruins
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{72} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13587 }, repeatable = true },
    },

  ----------------------------------------
  -- Combat (Region) - Goddess 1        --
  ----------------------------------------

    [553 ] = { -- Conflict: East Ronfaure [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{81} },
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13092 }, repeatable = true },
    },

    [555 ] = { -- Conflict: Jugner Forest [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{82} },
        reward = { sparks = 14, xp = 700, unity = 5, item = { 12311 }, repeatable = true },
    },

    [557 ] = { -- Conflict: Batallia Downs [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{84} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { 13087 }, repeatable = true },
    },

    [559 ] = { -- Conflict: La Vaule [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{85} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 13329 }, repeatable = true },
    },

    [561 ] = { -- Conflict: Eldieme Necropolis [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{175} },
        reward = { sparks = 16, xp = 800, unity = 5, item = { 16231 }, repeatable = true },
    },

    [563 ] = { -- Conflict: North Gustaberg [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{88} },
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13088 }, repeatable = true },
    },

    [565 ] = { -- Conflict: Grauberg [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{89} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 13316 }, repeatable = true },
    },

    [567 ] = { -- Conflict: Vunkerl Inlet [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{83} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 14727 }, repeatable = true },
    },

    [569 ] = { -- Conflict: Pashhow Marshlands [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{90} },
        reward = { sparks = 16, xp = 800, unity = 5, item = { 13312 }, repeatable = true },
    },

    [571 ] = { -- Conflict: Rolanberry Fields [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{91} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 12308 }, repeatable = true },
    },

    [573 ] = { -- Conflict: Beadeaux [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{92} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 15991 }, repeatable = true },
    },

    [575 ] = { -- Conflict: Crawlers' Nest [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{171} },
        reward = { sparks = 16, xp = 800, unity = 5, item = { 15993 }, repeatable = true },
    },


  ----------------------------------------
  -- Combat (Region) - Goddess 2        --
  ----------------------------------------

    [577 ] = { -- Conflict: West Sarutabaruta [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{95} },
        reward = { sparks = 11, xp = 550, unity = 5, item = { 13079 }, repeatable = true },
    },

    [579 ] = { -- Conflict: Fort Karugo-Narugo [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{96} },
        reward = { sparks = 12, xp = 600, unity = 5, item = { 16265 }, repeatable = true },
    },

    [581 ] = { -- Conflict: Meriph. Mountains [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{97} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 12302 }, repeatable = true },
    },

    [583 ] = { -- Conflict: Sauro. Champaign [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{98} },
        reward = { sparks = 13, xp = 650, unity = 5, item = { 16170 }, repeatable = true },
    },

    [585 ] = { -- Conflict: Castle Oztroja [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{99} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 15803 }, repeatable = true },
    },

    [587 ] = { -- Conflict: Garlaige Citadel [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{164} },
        reward = { sparks = 16, xp = 800, unity = 5, item = { 13466 }, repeatable = true },
    },

    [589 ] = { -- Conflict: Beaucedine Glacier [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{136} },
        reward = { sparks = 70, xp = 850, unity = 7, item = { 15805 }, repeatable = true },
    },

    [591 ] = { -- Conflict: Xarcabard [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{137} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 12385 }, repeatable = true },
    },

    [593 ] = { -- Conflict: Castle Zvahl Baileys [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{138} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 15539 }, repeatable = true },
    },

    [595 ] = { -- Conflict: Castle Zvahl Keep [S]
        trigger = triggers.mobKill,
        goal = 10,
        reqs = { zone = set{155} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 15780 }, repeatable = true },
    },

  ----------------------------------------
  -- Combat (Region) - Abyssea 1        --
  ----------------------------------------

    [613 ] = { -- Conflict: Abyssea - La Theine
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{132} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 10914 }, repeatable = true },
    },

    [614 ] = { -- Conflict: Abyssea - Konschtat
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{15} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 15891 }, repeatable = true },
    },

    [615 ] = { -- Conflict: Abyssea - Tahrongi
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{45} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 11765 }, repeatable = true },
    },

    [616 ] = { -- Conflict: Abyssea - Attohwa
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{215} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 11763 }, repeatable = true },
    },

    [617 ] = { -- Conflict: Abyssea - Misareaux
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{216} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 10966 }, repeatable = true },
    },

    [618 ] = { -- Conflict: Abyssea - Vunkerl
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{217} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 10964 }, repeatable = true },
    },

    [619 ] = { -- Conflict: Abyssea - Altepa
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{218} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 10968 }, repeatable = true },
    },

    [620 ] = { -- Conflict: Abyssea - Uleguerand
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{253} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 11664 }, repeatable = true },
    },

    [621 ] = { -- Conflict: Abyssea - Grauberg
        trigger = triggers.mobKill,
        goal = 30,
        reqs = { zone = set{254} },
        reward = { sparks = 80, xp = 900, unity = 8, item = { 11644 }, repeatable = true },
    },

  ----------------------------------------
  -- Combat (Region) - Escha 1          --
  ----------------------------------------

  ----------------------------------------
  -- Combat (Region) - Escha 2          --
  ----------------------------------------

}

 -- Apply defaults for records
for i,v in pairs(tpz.roe.records) do
    setmetatable(v, { __index = defaults })
end

 -- Register triggers
for i,v in pairs(tpz.roe.triggers) do
    RoeRegisterHandler(v)
end

-- Build global map of implemented records.
-- This is used to deny taking records which aren't implemented in the above table.
RoeParseRecords(tpz.roe.records)
