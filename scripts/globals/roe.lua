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
    return (params.mob and self.reqs.mob[params.mob:getID()]) and true or false
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
    goal = 1,                   -- Progress goal
    reqs = {},                  -- Other requirements. List of function names from above, with required values.
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
  -- Combat (Wide Area) -> Spoils I         --
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
        reqs = { mobID = set{17093094, 17203216} },
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
        reqs = { mobID = set{17207308, 17093074} },
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
        reqs = { mobID = set{17093049, 17576054} },
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
        reqs = { mobID = set{17125433, 17387567} },
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
        reqs = { mobID = set{17211702, 17092912} },
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
        reqs = { mobID = set{17092839, 17215613, 17215626} },
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
        reqs = { mobID = set{17093017, 17559584} },
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
        reqs = { mobID = set{17228242, 17092905} },
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
        reqs = { mobID = set{17093057, 17584398} },
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
