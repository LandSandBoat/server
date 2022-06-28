-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
require("modules/module_utils")
require("scripts/globals/shop")
require("scripts/zones/Aht_Urhgan_Whitegate/Zone")
-----------------------------------
local m = Module:new("catseyexi_custom_npcs")

---------------------------------------------
--           RU'LUDE GARDENS               --
---------------------------------------------
m:addOverride("xi.zones.RuLude_Gardens.Zone.onInitialize", function(zone)
    require("scripts/globals/status")
    local ID = require("scripts/zones/RuLude_Gardens/IDs")
    -- Call the zone's original function for onInitialize
    super(zone)
    
    local sylvie = zone:insertDynamicEntity({
    objtype  = xi.objType.NPC,
    name     = "Sylvie",
    look     = "0x01000F0234113421343134413451006000707180",
    x        = 4.20,
    y        = 3.100,
    z        = 111.905,
    rotation = 128,
    widescan = 1,

    onTrade = function(player, npc, trade)
	    local geoUnlocked = player:getCharVar("GEO_Unlocked")

        if npcUtil.tradeHasExactly(trade, { 15194 }) then
            npc:timer(1500, function(npcArg)
                player:PrintToPlayer("Sylvie: With the powers channeled through Altana, I now pronounce you a Geomancer!", 0xD)
            end)
			
            npc:timer(1500, function(npcArg)
                player:setAnimation(101)
                player:PrintToPlayer("Congratulations! You have unlocked \"Geomancer\"!")
            end)

            player:changeJob(xi.job.GEO)
            player:setLevel(1)

            npc:timer(2500, function(npcArg)
			    player:setCharVar("GEO_Unlocked", 1)
                player:setAnimation(0)
                player:addKeyItem(2290)
				player:messageSpecial( ID.text.KEYITEM_OBTAINED, 2290 )
                player:addKeyItem(2963)
				player:messageSpecial( ID.text.KEYITEM_OBTAINED, 2963 )
				player:addItem(21460)
                player:messageSpecial( ID.text.ITEM_OBTAINED, 21460 ) -- Give Matre Bell
            end)
        end
    end,

    onTrigger = function(player, npc)
	    local geoUnlocked = player:getCharVar("GEO_Unlocked")
		
		if geoUnlocked == 1 then 
            local stock =
            {
                6074,    1000,  -- Indi-Poison
                6088,    3720,  -- Indi-Voidance
                6087,   11400,  -- Indi-Precision
                6073,   23350,  -- Indi-Regen
                6090,   24250,  -- Indi-Attunement
                6089,   66920,  -- Indi-Focus
                6084,  109260,  -- Indi-Barrier
                6075,  210000,  -- Indi-Refresh
                6082,  210000,  -- Indi-CHR
                6081,  239400,  -- Indi-MND
                6083,  252700,  -- Indi-Fury
                6080,  309120,  -- Indi-INT
                6079,  326400,  -- Indi-AGI
                6086,  340000,  -- Indi-Fend
                6078,  337400,  -- Indi-VIT
                6077,  364400,  -- Indi-DEX
                6085,  320800,  -- Indi-Acumen
                6076,  434600,  -- Indi-STR
                6099,  434600,  -- Indi-Slow
                6096,  418750,  -- Indi-Torpor
                6095,  531600,  -- Indi-Slip
                6098,  541850,  -- Indi-Languor
                6100,  503040,  -- Indi-Paralysis
                6097,  540000,  -- Indi-Vex
				4916,   34000,  -- Fira
				4924,   54600,  -- Thundara
				4918,   46440,  -- Blizzara
				4920,   26600,  -- Aerora
				4922,   22490,  -- Stonera
				4923,  256000,  -- Stonera_II
				4926,   21000,  -- Watera
				4927,  255000,  -- Water_II
            }
		    
            player:PrintToPlayer("Welcome to the Geomancer magic shop!", 0, npc:getPacketName())
            xi.shop.general(player, stock)
		else
            player:PrintToPlayer("sylvie: Think you got what it takes to become a Geomancer? I need to see some evidence of your mastery over the original 15 Zilart jobs first!", 0xD)
		end	
    end,
    })

    utils.unused(sylvie)
end)

m:addOverride("xi.zones.RuLude_Gardens.Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/RuLude_Gardens/IDs")
    -- Call the zone's original function for onInitialize
    super(zone)
	
local wsRequirements =
{
-- index   |      ws_name     |  |item1|    |item1Qty|    |item2|  |item2Qty|
    [ 1] = { "Shijin Spiral", 1464,      10,      1474,    10 }, -- lancewood log, infinity core
    [ 2] = { "Exenterator",   1521,      10,      1474,    10 }, -- slime juice, infinity core
    [ 3] = { "Requiescat",    1518,      10,      1474,    10 }, -- colossal skull, infinity core
    [ 4] = { "Resolution",    1520,      10,      1474,    10 }, -- goblin grease, infinity core
    [ 5] = { "Ruinator",      1516,      10,      1474,    10 }, -- griffon hide, infinity core
    [ 6] = { "Upheaval",      1517,      10,      1474,    10 }, -- giant frozen head, infinity core
    [ 7] = { "Entropy",       1466,      10,      1474,    10 }, -- relic iron, infinity core
    [ 8] = { "Stardiver",     1519,      10,      1474,    10 }, -- fresh orc liver, infinity core
    [ 9] = { "Blade_Shun",    1469,      10,      1474,    10 }, -- wootz ore, infinity core
    [10] = { "Tachi Shoha",   1470,      10,      1474,    10 }, -- sparkling stone, infinity core
    [11] = { "Realmrazer",    1517,      10,      1518,    10 }, -- giant frozen head, colossal skull
    [12] = { "Shattersoul",   1521,      10,      1519,    10 }, -- slime juice, fresh orc liver
    [13] = { "Apex Arrow",    1516,      10,      1464,    10 }, -- griffon hide, lancewood log
    [14] = { "Last Stand",    1520,      10,      1466,    10 }, -- goblin grease, relic iron
}

local atoritutori = zone:insertDynamicEntity({
    objtype = xi.objType.NPC,
    name = "Atori-Tutori",
    look = 3106,
    x = 11.360,
    y = 3.100,
    z = 116.881,
    rotation = 128,
    widescan = 1,

    onTrade = function(player, npc, trade)
        local pointsCost = 300000
		
    	if player:getCharVar("PaidForMeritWs") == 1 then
            -- Shijin Spiral
    	    if npcUtil.tradeHasExactly(trade, {{wsRequirements[1][2], wsRequirements[1][3]}, {wsRequirements[1][4], wsRequirements[1][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Shijin Spiral\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 2)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 30 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 lancewood logs and 10 infinity cores to complete this phase.", 0xD)
                return
    
            -- Exenterator
            elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[2][2], wsRequirements[2][3]}, {wsRequirements[2][4], wsRequirements[2][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Exenterator\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 3)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 31 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 slime juices and 10 infinity cores to complete this phase.", 0xD)
                return
    
            -- Requiescat
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[3][2], wsRequirements[3][3]}, {wsRequirements[3][4], wsRequirements[3][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Requiescat\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 4)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 32 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 colossal skulls and 10 infinity cores to complete this phase.", 0xD)
                return
    
            -- Resolution
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[4][2], wsRequirements[4][3]}, {wsRequirements[4][4], wsRequirements[4][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Resolution\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 5)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 33 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 goblin greases and 10 infinity cores to complete this phase.", 0xD)
                return
    
            -- Ruinator
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[5][2], wsRequirements[5][3]}, {wsRequirements[5][4], wsRequirements[5][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Ruinator\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 6)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 34 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 griffon hides and 10 infinity cores to complete this phase.", 0xD)
                return
    
            -- Upheaval
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[6][2], wsRequirements[6][3]}, {wsRequirements[6][4], wsRequirements[6][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Upheaval\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 7)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 35 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 giant frozen heads and 10 infinity cores to complete this phase.", 0xD)
                return
    
            -- Entropy
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[7][2], wsRequirements[7][3]}, {wsRequirements[7][4], wsRequirements[7][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Entropy\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 8)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 36 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 relic irons and 10 infinity cores to complete this phase.", 0xD)
                return
    
            -- Stardiver
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[8][2], wsRequirements[8][3]}, {wsRequirements[8][4], wsRequirements[8][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Stardiver\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 9)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 37 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 slime juices and 10 fresh orc livers to complete this phase.", 0xD)
                return
    
            -- Blade: Shun
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[9][2], wsRequirements[9][3]}, {wsRequirements[9][4], wsRequirements[9][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Blade: Shun\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 10)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 38 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 wootz ores and 10 infinity cores to complete this phase.", 0xD)
                return
    
            -- Tachi: Shoha
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[10][2], wsRequirements[10][3]}, {wsRequirements[10][4], wsRequirements[10][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Tachi: Shoha\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 11)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 39 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 sparkling stones and 10 infinity cores to complete this phase.", 0xD)
                return
    
            -- Realmrazer
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[11][2], wsRequirements[11][3]}, {wsRequirements[11][4], wsRequirements[11][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Realmrazer\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 12)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 40 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 giant frozen heads and 10 colossal skulls to complete this phase.", 0xD)
                return
    
            -- Shattersoul
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[12][2], wsRequirements[12][3]}, {wsRequirements[12][4], wsRequirements[12][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Shattersoul\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 13)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 41 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 griffon hides and 10 infinity cores to complete this phase.", 0xD)
                return
    
            -- Apex Arrow
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[13][2], wsRequirements[13][3]}, {wsRequirements[13][4], wsRequirements[13][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Apex Arrow\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 14)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 42 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 griffon hides and 10 lancewood logs to complete this phase.", 0xD)
                return
    
            -- Last Stand
    	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[14][2], wsRequirements[14][3]}, {wsRequirements[14][4], wsRequirements[14][5]}}) then
                player:tradeComplete()
    		    player:PrintToPlayer("Phase 1 Complete. You can now purchase \"Last Stand\" from Nolan in Norg.")
                player:setCharVar("PaidForMeritWs", 15)
                return
            elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 43 }}) then
                player:tradeComplete()
                player:PrintToPlayer("Atori-Tutori: I require 10 goblin greases and 10 relic irons to complete this phase.", 0xD)
                return
    
                --FALLBACK H
            else
                player:PrintToPlayer("You are missing requirements to unlock this WS!")
            end
        end
    
        -- if player asks to redeem conquest points, we check to see which ones to use and deduct the cost from their total.
        -- find out which nation player belongs to and use those conquest points
        if player:getNation() == xi.nation.SANDORIA then
            nationCp = player:getCurrency("sandoria_cp")
    
        elseif player:getNation() == xi.nation.BASTOK then
            nationCp = player:getCurrency("bastok_cp")
    
        elseif player:getNation() == xi.nation.WINDURST then
            nationCp = player:getCurrency("windurst_cp")
        else
            player:PrintToPlayer("You don't have a home nation? get some help...")  -- edge case, player doesn't have a home nation
    	end
    
        -- WINDURST
    	if (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and player:getNation() == xi.nation.WINDURST and (nationCp > pointsCost)) then
    	        player:tradeComplete()
    		    player:delCurrency("windurst_cp", pointsCost)
    			player:setCharVar("PaidForMeritWs", 1)
                player:PrintToPlayer("Atori-Tutori: I've deducted your Windurst conquest points and progressed you to the next step.\nTalk to me again for next steps.", 0xD)
            elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and player:getNation() == xi.nation.WINDURST and (nationCp < pointsCost)) then
                player:PrintToPlayer("Atori-Tutori: You will need more Windurst conquest points before you do that.", 0xD)
    
        -- BASTOK
    	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and player:getNation() == xi.nation.BASTOK and (nationCp > pointsCost)) then
    		    player:tradeComplete()
    		    player:delCurrency("bastok_cp", pointsCost)
    			player:setCharVar("PaidForMeritWs", 1)
                player:PrintToPlayer("Atori-Tutori: I've deducted your Bastok conquest points and progressed you to the next step.\nTalk to me again for next steps.", 0xD)
            elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and player:getNation() == xi.nation.BASTOK and (nationCp < pointsCost)) then
                player:PrintToPlayer("Atori-Tutori: You will need more Bastok conquest points before you do that.", 0xD)
    
        -- SANDORIA
    	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and player:getNation() == xi.nation.SANDORIA and (nationCp > pointsCost)) then
    			player:tradeComplete()
    		    player:delCurrency("sandoria_cp", pointsCost)
                player:setCharVar("PaidForMeritWs", 1)
                player:PrintToPlayer("Atori-Tutori: I've deducted your San d'Oria conquest points and progressed you to the next step.\nTalk to me again for next steps.", 0xD)
            elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and player:getNation() == xi.nation.SANDORIA and (nationCp < pointsCost)) then
                player:PrintToPlayer("Atori-Tutori: You will need more San d'Oria conquest points before you do that.", 0xD)
    
        -- player has chosen to use their imperial standing points
    	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 2 }}) and (player:getCurrency("imperial_standing") > pointsCost)) then
    			player:tradeComplete()
    		    player:delCurrency("imperial_standing", pointsCost)
                player:setCharVar("PaidForMeritWs", 1)
                player:PrintToPlayer("Atori-Tutori: I've deducted your imperial standing points and progressed you to the next step.\nTalk to me again for next steps.", 0xD)
            elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 2 }}) and (player:getCurrency("imperial_standing") < pointsCost)) then
                player:PrintToPlayer("Atori-Tutori: You will need more imperial standing before you do that.", 0xD)
    
        -- player has chosen to use allied notes
    	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 3 }}) and player:getCurrency("allied_notes") > pointsCost) then
    			player:tradeComplete()
    		    player:delCurrency("allied_notes", pointsCost)
                player:setCharVar("PaidForMeritWs", 1)
                player:PrintToPlayer("Atori-Tutori: I've deducted your allied notes and progressed you to the next step.\nTalk to me again for next steps.", 0xD)
            elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 3 }}) and (player:getCurrency("allied_notes") < pointsCost)) then
                player:PrintToPlayer("Atori-Tutori: You will need more allied notes before you do that.", 0xD)
    	end
    		
    end,

    onTrigger = function(player, npc)
        -- set default variables
        local nationCp = 0
        local imperialStanding = player:getCurrency("imperial_standing")
        local alliedNotes = player:getCurrency("allied_notes")
        local pointsRequired = 30000
    
		if player:getCharVar("PaidForMeritWs") > 1 then
		    player:PrintToPlayer("Atori-Tutori: You already have a quest in progress. You must complete it before starting a new one.", 0xD)
			return
		end	

        -- if we've deducted the player's points, move to phase two (trade items)
    	if player:getCharVar("PaidForMeritWs") == 1 then
            player:PrintToPlayer(string.format("Atori-Tutori: Phase two: Please bring the the requisite items for the aeonic weaponskill you'd like to unlock."), 0xD)
            player:PrintToPlayer("Atori-Tutori: Trade me the fixed amount of gil below, and I'll tell you which upgrade items are necessary...", 0xD)
            player:PrintToPlayer("Shijin Spiral: 30 gil, Exenterator: 31 gil, Requiescat: 32 gil, Resolution: 33 gil, Ruinator: 34 gil, Upheaval: 35 gil", 28)
            player:PrintToPlayer("Entropy: 36 gil, Stardiver: 37 gil, Blade Shun: 38 gil, Tachi: Shoha: 39 gil, Realmrazer: 40 gil, Shattersoul: 41 gil", 28)
            player:PrintToPlayer("Apex Arrow: 42 gil, Last Stand: 43 gil", 28)
    		return
    	else
    	    -- standard dialog
            player:PrintToPlayer("Atori-Tutori: Up for a challenge? How about a new weaponskill?", 0xD)
            player:PrintToPlayer("Atori-Tutori: First, you'll need 300,000 conquest points, imperial standing, or allied notes.", 0xD)
    	end
    
        -- find out which nation player belongs to and use those conquest points
        if player:getNation() == xi.nation.SANDORIA then
            nationCp = player:getCurrency("sandoria_cp")
    
        elseif player:getNation() == xi.nation.BASTOK then
            nationCp = player:getCurrency("bastok_cp")
    
        elseif player:getNation() == xi.nation.WINDURST then
            nationCp = player:getCurrency("windurst_cp")
        else
            player:PrintToPlayer("You don't have a home nation? get some help...")  -- edge case, player doesn't have a home nation
    	end
    
        -- if player has enough points to spend, print the number of points held, and present the player with the next step.
        if (nationCp < pointsRequired and imperialStanding < pointsRequired and alliedNotes < pointsRequired) then
            player:PrintToPlayer(string.format("Atori-Tutori: Return to me when you have atleast 300,000 conquest points, imperial standing or allied notes.", nationCp, imperialStanding, alliedNotes), 0xD)
    	else
    	    player:PrintToPlayer(string.format("Atori-Tutori: You've got %i conquest points, %i imperial standing and %i allied notes.", nationCp, imperialStanding, alliedNotes), 0xD)
    		player:PrintToPlayer(string.format("Atori-Tutori: Trade 1g to use your conquest points, 2g to use your imperial standing, or 3g to use your allied notes."), 0xD)
    	end		
    end,
    })
	
	utils.unused(atoritutori)
end)
	
---------------------------------------------
--              LOWER JEUNO                --
---------------------------------------------
m:addOverride("xi.zones.Lower_Jeuno.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)
    
    local huntRewards =
    {
        [1] = { 1456,  2  },   -- one_hundred_byne_bill
    	[2] = { 1712,  2  },   -- cashmere thread
    	[3] = { 1713,  2  },   -- cashmere wool
    	[4] = { 658,   2  },   -- damascus_ingot
        [5] = { 2470,  1  },   -- nethereye_chain
    	[6] = { 2471,  1  },   -- netherfield_chain
    	[7] = { 2472,  1  },   -- netherspirit chain
    	[8] = { 2473,  1  },   -- nethercant_chain
    	[9] = { 2474,  1  },   -- netherpact_chain
    	[10] = { 901,  2  },   -- venomous claw
    	[11] = { 2465, 1  },   -- rubber_cap
    	[12] = { 2466, 1  },   -- rubber_harness
    	[13] = { 2467, 1  },   -- rubber gloves
    	[14] = { 2468, 1  },   -- rubber chausses
    	[15] = { 2469, 1  },   -- rubber soles
    	[16] = { 1875, 40 },   -- Ancient Beastcoin
    	[17] = { 3283, 10 },   -- Aquarian Tatter
    	[18] = { 3282, 10 },   -- Dryadic Tatter
    	[19] = { 3281, 10 },   -- Earthen Tatter
    	[20] = { 3280, 10 },   -- Martial Tatter
    	[21] = { 3279, 10 },   -- Neptunal Tatter
    	[22] = { 3284, 10 },   -- Wyrmal Tatter
    	[23] = { 3286, 10 },   -- Hadean Tatter
    	[24] = { 3285, 10 },   -- Phantasmal Tatter
    	[25] = { 3278, 10 },   -- Byakko Scrap
    	[26] = { 3275, 10 },   -- Genbu Scrap
    	[27] = { 3277, 10 },   -- Seiryu Scrap
    	[28] = { 3276, 10 },   -- Suzaku Scrap
    	[29] = { 1450, 2  },   -- Lungo-Nango Jadeshell
    	[30] = { 1453, 2  },   -- Montiont Silverpiece
    	[31] = { 747,  2  },   -- Orichalcum Ingot
    	[32] = { 686,  2  },   -- Imperial Wootz Ingot
    	[33] = { 1714, 2  },   -- Cashmere Cloth
    	[34] = { 1313, 2  },   -- Siren's Hair
    	[35] = { 1409, 2  },   -- Siren's Macrame
    	[36] = { 831,  2  },   -- Shining Cloth
    	[37] = { 862,  2  },   -- Behemoth Leather
    	[38] = { 2170, 2  },   -- Cerberus Leather
    	[39] = { 1312, 2  },   -- Angel Skin
    	[40] = { 723,  2  },   -- Divine Lumber
    	[41] = { 720,  2  },   -- Ancient Lumber
    	[42] = { 2535, 2  },   -- Jacaranda Lumber
    	[43] = { 1446, 2  },   -- Lacquer Tree Log
    	[44] = { 1133, 2  },   -- Dragon Blood
    	[45] = { 4272, 2  },   -- Dragon Meat	
    	[46] = { 703,  2  },   -- Petrified Log
    	[47] = { 2156, 10 },   -- Imperial Tea Leaves
        [48] = { 2532, 5  },   -- Teak Log
    	[49] = { 732,  5  },   -- Kapor Log
    	[50] = { 5736, 4  },   -- linen coin purse
    }
	
	    local hunter = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Hunter",
        look = "0x0000CA0800000000000000000000000000000000",
        x = 8.000,
        y = 0.000,
        z = 15.427,
        rotation = 130,
        widescan = 1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
		    local weeklyHunt = GetServerVariable("Weekly_Hunt_NM")
	        local playerTitle = player:getTitle()
	        local huntTitle = 0
	        local huntNM = 0
   	        local randomReward = 0
   	        local reward = 0
   	        local rewardQty = 0
	        local huntCounter = 0
			
            printf("Weekly Hunt: %s Player Title: %s ", weeklyHunt, playerTitle)
	        
	        if (weeklyHunt == player:getCharVar("Weekly_Hunt_Completed")) then	
	            player:PrintToPlayer(string.format("Hunter: You've already completed this week's hunt! Come back later!"), 0xD)
	        	return
	        end
	        
            if (playerTitle == weeklyHunt and player:getCharVar("Weekly_Hunt_Completed") ~= 1) then
            	local randomReward = math.random(1,50)
            	local reward = huntRewards[randomReward][1]
            	local rewardQty = huntRewards[randomReward][2]
             	player:setCharVar("Weekly_Hunt_Completed", weeklyHunt)
            	player:PrintToPlayer(string.format("Hunter: Congratulations! You've completed this week's hunt. Here's your reward!"), 0xD)
            	npcUtil.giveItem(player, { { reward, rewardQty } })
			    if not player:getCharVar("Weekly_Hunt_Counter") then
                    player:setCharVar("Weekly_Hunt_Counter", 1)
				else
				    local huntCounter = player:getCharVar("Weekly_Hunt_Counter") + 1
					player:setCharVar("Weekly_Hunt_Counter", huntCounter)
				end
	        elseif weeklyHunt == 453 then -- NIDHOGG_SLAYER
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Nidhogg!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Nidhogg Slayer"), 0xD)
	        elseif weeklyHunt == 464 then -- VINEGAR_EVAPORATOR
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Kinger Vinegarroon!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Vinegar Evaporator"), 0xD)
            elseif weeklyHunt == 457 then -- LIFTER_OF_SHADOWS
 	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Dynamis Lord!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Lifter of Shadows"), 0xD)
            elseif weeklyHunt == 468 then -- APOLLYON_RAVAGER
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Proto-Omega!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Apollyon Ravager"), 0xD)
            elseif weeklyHunt == 452 then -- ASPIDOCHELONE_SINKER
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Aspidochelone!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Aspidochelone Sinker"), 0xD)
            elseif weeklyHunt == 458 then -- TIAMAT_TROUNCER
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Tiamat!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Tiamat Trouncer"), 0xD)
            elseif weeklyHunt == 476 then -- KHIMAIRA_CARVER
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Khimaira!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Khimaira Carver"), 0xD)
            elseif weeklyHunt == 28 then -- BEHEMOTH_DETHRONER
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: King Behemoth!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Behemoth Dethroner"), 0xD)
            elseif weeklyHunt == 472 then -- HYDRA_HEADHUNTER
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Hydra!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Hydra Headhunter"), 0xD)
            elseif weeklyHunt == 471 then -- CERBERUS_MUZZLER
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Cerberus!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Cerberus Muzzler"), 0xD)
            elseif weeklyHunt == 558 then -- OUPIRE_IMPALER
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Oupire!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Oupire Impaler"), 0xD)
            elseif weeklyHunt == 460 then -- WORLD_SERPENT_SLAYER
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Jormungand!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: World Serpent Slayer"), 0xD)
            elseif weeklyHunt == 459 then -- VRTRA_VANQUISHER
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Vrtra!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Vrtra Vanquisher"), 0xD)
            elseif weeklyHunt == 467 then -- TEMENOS_LIBERATOR
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Proto-Ultima!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Temenos Liberator"), 0xD)
            elseif weeklyHunt == 455 then -- KIRIN_CAPTIVATOR
	        	player:PrintToPlayer(string.format("Hunter: This week's hunt is: Kirin!"), 0xD)
                player:PrintToPlayer(string.format("Hunter: Title required: Kirin Captivator"), 0xD)
            end

        end,
    })

    utils.unused(hunter)
	
    local expguide = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,
        name = "EXP Guide",
        look = 2290,
        x = -1.734,
        y = 0.000,
        z = -8.922,
        rotation = 0,
        widescan = 1,

        onTrade = function(player, npc, trade)
		    local coins = trade:getGil()
	        local hasWarpScroll = player:hasItem(4181)
	        
	        -- check to see if our player has a warp scroll, if not, give them one.
	        if not hasWarpScroll then
	            npcUtil.giveItem(player, xi.items.SCROLL_OF_INSTANT_WARP) -- scroll_of_instant_warp
	        end
	        
	        if (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }})) then
	            player:setPos(128.163, -7.320, 95.083, 0, 103) -- Valkurm Dunes
	        elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 2 }})) then
	            player:setPos(-54.956, -20.000, 63.757, 0, 126) -- Qufim Pond
	        elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 3 }})) then
	            player:setPos(-31.682, -20.026, 258.653, 0, 126) -- Qufim Pugils
	        elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 4 }})) then
	            player:setPos(-224.635, -0.255, 503.703, 0, 123) -- Yuhtunga Jungle
	        elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 5 }})) then
	            player:setPos(-278.584, 8.300, 140.543, 0, 124) -- Yhoator Jungle
	        elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 6 }})) then
	            player:setPos(-341.194, -3.250, 340.712, 0, 200) -- Garlaige Citadel
	        elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 7 }})) then
	            player:setPos(345.456, -32.374, -19.874, 0, 197) -- Crawler's Nest
	        elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 8 }})) then
	            player:setPos(-140.079, -13.407, 19.703, 0, 125) -- Western Altepa Desert
	        elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 9 }})) then
	            player:setPos(-16.756, 0.000, -181.055, 0, 213) -- Labyrinth of Onzozo
	        elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 10 }})) then
                player:setPos(-237.550, -15.855, 86.347, 0, 51) -- Wajaom Woodlands	
	        elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 11 }})) then
                player:setPos(-33.094, 4.770, 139.340, 0, 213) -- Labyrinth of Onzozo	
	        elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 12 }})) then
                player:setPos(17.172, -10.547, 8.043, 0, 174) -- Kuftal Tunnel
			end
        end,

        onTrigger = function(player, npc)
		    local name = player:getName()
            player:PrintToPlayer(string.format("EXP Guide: Greetings, %s! I am your Experience Guide. I send adventurers like yourself to various EXP camps around Vana'diel!", name), 0xD)
	        player:PrintToPlayer("Trade me the corresponding amount of gil, and I'll get you to the hunting camp of your choice lickity split!\n", 0xD)
	        player:PrintToPlayer("Recommended levels below are intended for EXP parties. Your mileage may vary! ^.^b\n")
	        player:PrintToPlayer("1 gil = Valkurm Dunes (Level 12 - 18)", 28)
	        player:PrintToPlayer("2 gil = Qufim Island (Pond) (Level 19 - 22)", 28)
	        player:PrintToPlayer("3 gil = Qufim Island (Pugil Camp) (Level 23 - 25)", 28)
	        player:PrintToPlayer("4 gil = Yuhutunga Jungle (Level 26 - 28)", 28)
	        player:PrintToPlayer("5 gil = Yhoator Jungle (Level 29 - 32)", 28)
	        player:PrintToPlayer("6 gil = Garlaige Citadel (Level 33 - 36)", 28)
            player:PrintToPlayer("7 gil = Crawler's Nest (Level 37 - 43)", 28)
	        player:PrintToPlayer("8 gil = Western Altepa Desert (Level 44 - 50)", 28)
	        player:PrintToPlayer("9 gil = Labyrinth of Onzozo (51-54)", 28)
	        player:PrintToPlayer("10 gil = Wajaom Woodlands (Level 55 - 59)", 28)
	        player:PrintToPlayer("11 gil = Labyrinth of Onzozo (Level 60 - 69)", 28)
	        player:PrintToPlayer("12 gil = Kuftal Tunnel (Level 70 - 75)", 28)
        end,
    })

    utils.unused(expguide)

end)

---------------------------------------------
--          AHT URHGAN WHITEGATE           --
---------------------------------------------
m:addOverride("xi.zones.Aht_Urhgan_Whitegate.Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
    -- Call the zone's original function for onInitialize
    super(zone)
	
    local mnejing = zone:insertDynamicEntity({  -- sell pup attachments
    objtype  = xi.objType.NPC,
    name     = "Mnejing",
    look     = 3030,
    x        = -63.022,
    y        = -6.000,
    z        = -48.491,
    rotation = 70,
    widescan = 1,

    onTrade = function(player, npc, trade)
        if player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OPERATION_TEATIME) == QUEST_COMPLETED then
            if npcUtil.tradeHasExactly(trade, {786, 2289, 2152, 754, 2186, 2186}) then
                player:tradeComplete()
                player:addItem(15686)
                player:messageSpecial( ID.text.ITEM_OBTAINED, 15686) -- Give Pup. Babouches
            elseif npcUtil.tradeHasExactly(trade, {821, 2289, 2152, 754, 2186}) then
                player:tradeComplete()
                player:addItem(14930)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 14930) -- Give Pup. Dastanas
            elseif npcUtil.tradeHasExactly(trade, {786, 2289, 1636, 1699, 2187}) then
                player:tradeComplete()
                player:addItem(14523)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 14523) -- Give Pup. Tobe
            end
        end
    end,

    onTrigger = function(player, npc)
        local stock =
        {
            9885,  82992,    -- Magniplug
            9887,  82992,    -- Arcanoclutch
            9071,  88920,    -- Resister II
            9044,  88920,    -- Auto-Repair Kit III
            9073,  88920,    -- Arcanic Cell II
            9045,  88920,    -- Mana Tank III
            2414, 185250,    -- Steam Jacket
            2413, 185250,    -- Coiler
            2347, 222300,    -- Reactive Shield
            2348, 222300,    -- Tranquilizer
            2349, 222300,    -- Turbo Charger
            2350, 222300,    -- Schurzen
            2351, 222300,    -- Dynamo 
            2352, 222300,    -- Condenser
            2353, 222300,    -- Optic Fiber
            2354, 222300,    -- Economizer
        }

        player:PrintToPlayer("Welcome to the puppetmaster attachment shop!", 0, npc:getPacketName())
        xi.shop.general(player, stock)

        if player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OPERATION_TEATIME) == QUEST_COMPLETED then
            player:PrintToPlayer("If you're looking for artifact gear, just trade me the corresponding materials for each item!", 0, npc:getPacketName())
        end
    end,
    })

    utils.unused(mnejing)
	
	local qm_hydroguage = zone:insertDynamicEntity({  -- since fishing is disabled, allow player to pickup hydroguage from ???
        objtype = xi.objType.NPC,
        name = "???",
        look = "0x0000340000000000000000000000000000000000",
        x = 22.277,
        y = 2.000,
        z = -122.709,
        rotation = 180,
        widescan = 1, 

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            if player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == QUEST_ACCEPTED then
			    player:addItem(2341)
			    player:messageSpecial( ID.text.ITEM_OBTAINED, 2341 )
			end
        end,
    })
	
	utils.unused(qm_hydroguage)
	

end)

-----------------------------------
--         THRONE ROOM           --
-----------------------------------
m:addOverride("xi.zones.Throne_Room.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)
	local teodor = zone:insertDynamicEntity({
    objtype = xi.objType.NPC,
    name = "Teodor",
    look = 3103,
    x = -0.255,
    y = 0.000,
    z = -19.674,
    rotation = 180,
    widescan = 1,

    onTrade = function(player, npc, trade)
    end,

    onTrigger = function(player, npc)
    local stock =
        {
        6377, 100000,    -- Imperial Chair
        6378, 100000,    -- Decorative Chair 
        6379, 100000,    -- Ornate Stool
        6380, 100000,    -- Refined Chair
        6408, 100000,    -- Portable Container
        6411, 100000,    -- Chocobo Chair
        6409, 200000,    -- Ephramadian Throne
        6412, 200000,    -- Leaf Bench
        6413, 200000,    -- Astral Cube
        6410, 500000,    -- Shadow Throne
        }
        player:PrintToPlayer("Have a seat", 0, npc:getPacketName())
        xi.shop.general(player, stock)
    end,
    })

    utils.unused(teodor)

end)

-----------------------------------
--      SOUTH SAN D'ORIA         --
-----------------------------------
m:addOverride("xi.zones.Southern_San_dOria.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)
    local crystalcrunch = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Crystal Crunch",     -- NPC Display Name
        look = "0x0000750900000000000000000000000000000000",       -- Can use binary #'s NPC look
        x = -183.646,
        y = -8.800,
        z = 31.977,
        rotation = 0,

        onTrade = function(player, npc, trade)
            local crystals = { 4096, 4097, 4098, 4099, 4100, 4101, 4102, 4103 }
            local crystalCount = player:getCharVar("CrystalCruncher")
            local totalCrystals = 0
        
            -- Check that trade has valid crystals
            for _, validCrystal in ipairs(crystals) do
                -- if trade has valid crystals, then set up our variables
                if npcUtil.tradeHas(trade, validCrystal) then
            	    crystalCount = trade:getItemQty(validCrystal)
                    totalCrystals = totalCrystals + crystalCount
            	end
            end
        
            -- eat everything in the trade window
            player:setCharVar("CrystalCruncher", player:getCharVar("CrystalCruncher") + totalCrystals)
            player:tradeComplete()
            player:PrintToPlayer(string.format("You have traded %s crystals with a total of %s.", totalCrystals, player:getCharVar("CrystalCruncher")))
        end,

        onTrigger = function(player, npc)
            local storedCrystals = player:getCharVar("CrystalCruncher")
            local eligibleCrystals = math.floor(storedCrystals / 3 )
            
			player:PrintToPlayer("Crystal Crunch: I convert crystals ONLY at a ratio of 3 to 1. If you trade me anything else, it will be lost.", 0xD)
			
            if storedCrystals > 2 then
                player:PrintToPlayer(string.format("You can receive up to %s crystals with your current balance of %s crystals.", eligibleCrystals, storedCrystals))
                
                    local menu =
                {
                    title = "Choose a crystal:",
                    onStart = function(playerArg)
                        -- NOTE: This could be used to lock the player in place
                        -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
                    end,
                    options =
                    {
                        {
                            "Fire Crystal",
                            function(playerArg)
                                playerArg:addItem(4096, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Water Crystal",
                            function(playerArg)
                                playerArg:addItem(4101, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Earth Crystal",
                            function(playerArg)
                                playerArg:addItem(4099, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Lightning Crystal",
                            function(playerArg)
                                playerArg:addItem(4100, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Wind Crystal",
                            function(playerArg)
                                playerArg:addItem(4098, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Ice Crystal",
                            function(playerArg)
                                playerArg:addItem(4097, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Light Crystal",
                            function(playerArg)
                                playerArg:addItem(4102, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Dark Crystal",
                            function(playerArg)
                                playerArg:addItem(4103, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                    },
                    onCancelled = function(playerArg)
                    end,
                    onEnd = function(playerArg)
                    end,
                }
                player:customMenu(menu)
            else
                player:PrintToPlayer("You don't have enough crystals stored.")
            end
        end,
    })

    utils.unused(crystalcrunch)

end)

-----------------------------------
--       NORTH SAN D'ORIA        --
-----------------------------------
m:addOverride("xi.zones.Northern_San_dOria.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)
    local crystalcrunch = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Crystal Crunch",     -- NPC Display Name
        look = "0x0000750900000000000000000000000000000000",       -- Can use binary #'s NPC look
        x = -151.874,
        y = 12.000,
        z = 188.132,
        rotation = 0,

        onTrade = function(player, npc, trade)
            local crystals = { 4096, 4097, 4098, 4099, 4100, 4101, 4102, 4103 }
            local crystalCount = player:getCharVar("CrystalCruncher")
            local totalCrystals = 0
        
            -- Check that trade has valid crystals
            for _, validCrystal in ipairs(crystals) do
                -- if trade has valid crystals, then set up our variables
                if npcUtil.tradeHas(trade, validCrystal) then
            	    crystalCount = trade:getItemQty(validCrystal)
                    totalCrystals = totalCrystals + crystalCount
            	end
            end
        
            -- eat everything in the trade window
            player:setCharVar("CrystalCruncher", player:getCharVar("CrystalCruncher") + totalCrystals)
            player:tradeComplete()
            player:PrintToPlayer(string.format("You have traded %s crystals with a total of %s.", totalCrystals, player:getCharVar("CrystalCruncher")))
        end,

        onTrigger = function(player, npc)
            local storedCrystals = player:getCharVar("CrystalCruncher")
            local eligibleCrystals = math.floor(storedCrystals / 3 )
            
			player:PrintToPlayer("Crystal Crunch: I convert crystals ONLY at a ratio of 3 to 1. If you trade me anything else, it will be lost.", 0xD)

            if storedCrystals > 2 then
                player:PrintToPlayer(string.format("You can receive up to %s crystals with your current balance of %s crystals.", eligibleCrystals, storedCrystals))
                
                    local menu =
                {
                    title = "Choose a crystal:",
                    onStart = function(playerArg)
                        -- NOTE: This could be used to lock the player in place
                        -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
                    end,
                    options =
                    {
                        {
                            "Fire Crystal",
                            function(playerArg)
                                playerArg:addItem(4096, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Water Crystal",
                            function(playerArg)
                                playerArg:addItem(4101, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Earth Crystal",
                            function(playerArg)
                                playerArg:addItem(4099, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Lightning Crystal",
                            function(playerArg)
                                playerArg:addItem(4100, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Wind Crystal",
                            function(playerArg)
                                playerArg:addItem(4098, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Ice Crystal",
                            function(playerArg)
                                playerArg:addItem(4097, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Light Crystal",
                            function(playerArg)
                                playerArg:addItem(4102, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Dark Crystal",
                            function(playerArg)
                                playerArg:addItem(4103, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                    },
                    onCancelled = function(playerArg)
                    end,
                    onEnd = function(playerArg)
                    end,
                }
                player:customMenu(menu)
            else
                player:PrintToPlayer("You don't have enough crystals stored.")
            end
        end,
    })

    utils.unused(crystalcrunch)

end)

-----------------------------------
--        BASTOK MINES           --
-----------------------------------
m:addOverride("xi.zones.Bastok_Mines.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)
    local crystalcrunch = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Crystal Crunch",     -- NPC Display Name
        look = "0x0000750900000000000000000000000000000000",       -- Can use binary #'s NPC look
        x = 75.097,
        y = 7.000,
        z = 3.150,
        rotation = 0,

        onTrade = function(player, npc, trade)
            local crystals = { 4096, 4097, 4098, 4099, 4100, 4101, 4102, 4103 }
            local crystalCount = player:getCharVar("CrystalCruncher")
            local totalCrystals = 0
        
            -- Check that trade has valid crystals
            for _, validCrystal in ipairs(crystals) do
                -- if trade has valid crystals, then set up our variables
                if npcUtil.tradeHas(trade, validCrystal) then
            	    crystalCount = trade:getItemQty(validCrystal)
                    totalCrystals = totalCrystals + crystalCount
            	end
            end
        
            -- eat everything in the trade window
            player:setCharVar("CrystalCruncher", player:getCharVar("CrystalCruncher") + totalCrystals)
            player:tradeComplete()
            player:PrintToPlayer(string.format("You have traded %s crystals with a total of %s.", totalCrystals, player:getCharVar("CrystalCruncher")))
        end,

        onTrigger = function(player, npc)
            local storedCrystals = player:getCharVar("CrystalCruncher")
            local eligibleCrystals = math.floor(storedCrystals / 3 )
            
			player:PrintToPlayer("Crystal Crunch: I convert crystals ONLY at a ratio of 3 to 1. If you trade me anything else, it will be lost.", 0xD)

            if storedCrystals > 2 then
                player:PrintToPlayer(string.format("You can receive up to %s crystals with your current balance of %s crystals.", eligibleCrystals, storedCrystals))
                
                    local menu =
                {
                    title = "Choose a crystal:",
                    onStart = function(playerArg)
                        -- NOTE: This could be used to lock the player in place
                        -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
                    end,
                    options =
                    {
                        {
                            "Fire Crystal",
                            function(playerArg)
                                playerArg:addItem(4096, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Water Crystal",
                            function(playerArg)
                                playerArg:addItem(4101, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Earth Crystal",
                            function(playerArg)
                                playerArg:addItem(4099, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Lightning Crystal",
                            function(playerArg)
                                playerArg:addItem(4100, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Wind Crystal",
                            function(playerArg)
                                playerArg:addItem(4098, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Ice Crystal",
                            function(playerArg)
                                playerArg:addItem(4097, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Light Crystal",
                            function(playerArg)
                                playerArg:addItem(4102, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Dark Crystal",
                            function(playerArg)
                                playerArg:addItem(4103, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                    },
                    onCancelled = function(playerArg)
                    end,
                    onEnd = function(playerArg)
                    end,
                }
                player:customMenu(menu)
            else
                player:PrintToPlayer("You don't have enough crystals stored.")
            end
        end,
    })

    utils.unused(crystalcrunch)

end)

-----------------------------------
--       BASTOK MARKETS          --
-----------------------------------
m:addOverride("xi.zones.Bastok_Markets.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)
    local crystalcrunch = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Crystal Crunch",     -- NPC Display Name
        look = "0x0000750900000000000000000000000000000000",       -- Can use binary #'s NPC look
        x = -219.068,
        y = -6.000,
        z = -68.635,
        rotation = 0,

        onTrade = function(player, npc, trade)
            local crystals = { 4096, 4097, 4098, 4099, 4100, 4101, 4102, 4103 }
            local crystalCount = player:getCharVar("CrystalCruncher")
            local totalCrystals = 0
        
            -- Check that trade has valid crystals
            for _, validCrystal in ipairs(crystals) do
                -- if trade has valid crystals, then set up our variables
                if npcUtil.tradeHas(trade, validCrystal) then
            	    crystalCount = trade:getItemQty(validCrystal)
                    totalCrystals = totalCrystals + crystalCount
            	end
            end
        
            -- eat everything in the trade window
            player:setCharVar("CrystalCruncher", player:getCharVar("CrystalCruncher") + totalCrystals)
            player:tradeComplete()
            player:PrintToPlayer(string.format("You have traded %s crystals with a total of %s.", totalCrystals, player:getCharVar("CrystalCruncher")))
        end,

        onTrigger = function(player, npc)
            local storedCrystals = player:getCharVar("CrystalCruncher")
            local eligibleCrystals = math.floor(storedCrystals / 3 )
            
			player:PrintToPlayer("Crystal Crunch: I convert crystals ONLY at a ratio of 3 to 1. If you trade me anything else, it will be lost.", 0xD)

            if storedCrystals > 2 then
                player:PrintToPlayer(string.format("You can receive up to %s crystals with your current balance of %s crystals.", eligibleCrystals, storedCrystals))
                
                    local menu =
                {
                    title = "Choose a crystal:",
                    onStart = function(playerArg)
                        -- NOTE: This could be used to lock the player in place
                        -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
                    end,
                    options =
                    {
                        {
                            "Fire Crystal",
                            function(playerArg)
                                playerArg:addItem(4096, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Water Crystal",
                            function(playerArg)
                                playerArg:addItem(4101, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Earth Crystal",
                            function(playerArg)
                                playerArg:addItem(4099, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Lightning Crystal",
                            function(playerArg)
                                playerArg:addItem(4100, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Wind Crystal",
                            function(playerArg)
                                playerArg:addItem(4098, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Ice Crystal",
                            function(playerArg)
                                playerArg:addItem(4097, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Light Crystal",
                            function(playerArg)
                                playerArg:addItem(4102, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Dark Crystal",
                            function(playerArg)
                                playerArg:addItem(4103, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                    },
                    onCancelled = function(playerArg)
                    end,
                    onEnd = function(playerArg)
                    end,
                }
                player:customMenu(menu)
            else
                player:PrintToPlayer("You don't have enough crystals stored.")
            end
        end,
    })

    utils.unused(crystalcrunch)

end)

-----------------------------------
--       WINDURST WATTERS        --
-----------------------------------
m:addOverride("xi.zones.Windurst_Waters.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)
    local crystalcrunch = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Crystal Crunch",     -- NPC Display Name
        look = "0x0000750900000000000000000000000000000000",       -- Can use binary #'s NPC look
        x = -91.032,
        y = -2.000,
        z = 47.544,
        rotation = 0,

        onTrade = function(player, npc, trade)
            local crystals = { 4096, 4097, 4098, 4099, 4100, 4101, 4102, 4103 }
            local crystalCount = player:getCharVar("CrystalCruncher")
            local totalCrystals = 0
        
            -- Check that trade has valid crystals
            for _, validCrystal in ipairs(crystals) do
                -- if trade has valid crystals, then set up our variables
                if npcUtil.tradeHas(trade, validCrystal) then
            	    crystalCount = trade:getItemQty(validCrystal)
                    totalCrystals = totalCrystals + crystalCount
            	end
            end
        
            -- eat everything in the trade window
            player:setCharVar("CrystalCruncher", player:getCharVar("CrystalCruncher") + totalCrystals)
            player:tradeComplete()
            player:PrintToPlayer(string.format("You have traded %s crystals with a total of %s.", totalCrystals, player:getCharVar("CrystalCruncher")))
        end,

        onTrigger = function(player, npc)
            local storedCrystals = player:getCharVar("CrystalCruncher")
            local eligibleCrystals = math.floor(storedCrystals / 3 )
            
			player:PrintToPlayer("Crystal Crunch: I convert crystals ONLY at a ratio of 3 to 1. If you trade me anything else, it will be lost.", 0xD)

            if storedCrystals > 2 then
                player:PrintToPlayer(string.format("You can receive up to %s crystals with your current balance of %s crystals.", eligibleCrystals, storedCrystals))
                
                    local menu =
                {
                    title = "Choose a crystal:",
                    onStart = function(playerArg)
                        -- NOTE: This could be used to lock the player in place
                        -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
                    end,
                    options =
                    {
                        {
                            "Fire Crystal",
                            function(playerArg)
                                playerArg:addItem(4096, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Water Crystal",
                            function(playerArg)
                                playerArg:addItem(4101, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Earth Crystal",
                            function(playerArg)
                                playerArg:addItem(4099, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Lightning Crystal",
                            function(playerArg)
                                playerArg:addItem(4100, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Wind Crystal",
                            function(playerArg)
                                playerArg:addItem(4098, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Ice Crystal",
                            function(playerArg)
                                playerArg:addItem(4097, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Light Crystal",
                            function(playerArg)
                                playerArg:addItem(4102, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Dark Crystal",
                            function(playerArg)
                                playerArg:addItem(4103, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                    },
                    onCancelled = function(playerArg)
                    end,
                    onEnd = function(playerArg)
                    end,
                }
                player:customMenu(menu)
            else
                player:PrintToPlayer("You don't have enough crystals stored.")
            end
        end,
    })

    utils.unused(crystalcrunch)

end)

-----------------------------------
--       WINDURST WOODS          --
-----------------------------------
m:addOverride("xi.zones.Windurst_Woods.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)
    local crystalcrunch = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Crystal Crunch",     -- NPC Display Name
        look = "0x0000750900000000000000000000000000000000",       -- Can use binary #'s NPC look
        x = -54.120,
        y = -0.981,
        z = -108.574,
        rotation = 0,

        onTrade = function(player, npc, trade)
            local crystals = { 4096, 4097, 4098, 4099, 4100, 4101, 4102, 4103 }
            local crystalCount = player:getCharVar("CrystalCruncher")
            local totalCrystals = 0
        
            -- Check that trade has valid crystals
            for _, validCrystal in ipairs(crystals) do
                -- if trade has valid crystals, then set up our variables
                if npcUtil.tradeHas(trade, validCrystal) then
            	    crystalCount = trade:getItemQty(validCrystal)
                    totalCrystals = totalCrystals + crystalCount
            	end
            end
        
            -- eat everything in the trade window
            player:setCharVar("CrystalCruncher", player:getCharVar("CrystalCruncher") + totalCrystals)
            player:tradeComplete()
            player:PrintToPlayer(string.format("You have traded %s crystals with a total of %s.", totalCrystals, player:getCharVar("CrystalCruncher")))
        end,

        onTrigger = function(player, npc)
            local storedCrystals = player:getCharVar("CrystalCruncher")
            local eligibleCrystals = math.floor(storedCrystals / 3 )
            
			player:PrintToPlayer("Crystal Crunch: I convert crystals ONLY at a ratio of 3 to 1. If you trade me anything else, it will be lost.", 0xD)

            if storedCrystals > 2 then
                player:PrintToPlayer(string.format("You can receive up to %s crystals with your current balance of %s crystals.", eligibleCrystals, storedCrystals))
                
                    local menu =
                {
                    title = "Choose a crystal:",
                    onStart = function(playerArg)
                        -- NOTE: This could be used to lock the player in place
                        -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
                    end,
                    options =
                    {
                        {
                            "Fire Crystal",
                            function(playerArg)
                                playerArg:addItem(4096, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Water Crystal",
                            function(playerArg)
                                playerArg:addItem(4101, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Earth Crystal",
                            function(playerArg)
                                playerArg:addItem(4099, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Lightning Crystal",
                            function(playerArg)
                                playerArg:addItem(4100, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Wind Crystal",
                            function(playerArg)
                                playerArg:addItem(4098, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Ice Crystal",
                            function(playerArg)
                                playerArg:addItem(4097, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Light Crystal",
                            function(playerArg)
                                playerArg:addItem(4102, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                        {
                            "Dark Crystal",
                            function(playerArg)
                                playerArg:addItem(4103, eligibleCrystals)
                                playerArg:PrintToPlayer("Take your crystals and get outta here!")
                                playerArg:setCharVar("CrystalCruncher", storedCrystals - eligibleCrystals * 3)
                            end,
                        },
                    },
                    onCancelled = function(playerArg)
                    end,
                    onEnd = function(playerArg)
                    end,
                }
                player:customMenu(menu)
            else
                player:PrintToPlayer("You don't have enough crystals stored.")
            end
        end,
    })

    utils.unused(crystalcrunch)

end)

return m
