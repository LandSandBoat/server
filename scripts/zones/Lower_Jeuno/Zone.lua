-----------------------------------
-- Zone: Lower_Jeuno (245)
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
local lowerJeunoGlobal = require("scripts/zones/Lower_Jeuno/globals")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/pathfind")
require("scripts/settings/main")
require("scripts/globals/chocobo")
require("scripts/globals/status")
require("modules/module_utils")
-----------------------------------
local zone_object = {}

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

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, 23, 0, -43, 44, 7, -39) -- Inside Tenshodo HQ. TODO: Find out if this is used other than in ZM 17 (not anymore). Remove if not.
    xi.chocobo.initZone(zone)
	
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

end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))
    -- Retail start/end dates vary, I am going with Dec 5th through Jan 5th.
    if
        (month == 12 and day >= 5) or
        (month == 1 and day <= 5)
    then
        player:ChangeMusic(0, 239)
        player:ChangeMusic(1, 239)
        -- No need for an 'else' to change it back outside these dates as a re-zone will handle that.
    end

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(41.2, -5, 84, 85)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onGameHour = function(zone)
    local VanadielHour = VanadielHour()
    local playerOnQuestId = GetServerVariable("[JEUNO]CommService")

    -- Community Service Quest
    -- 7AM: it's daytime. turn off all the lights
    if VanadielHour == 7 then
        for i=0, 11 do
            local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + i)
            lamp:setAnimation(xi.anim.CLOSE_DOOR)
        end

    -- 8PM: make quest available
    -- notify anyone in zone with membership card that zauko is recruiting
    elseif VanadielHour == 18 then
        SetServerVariable("[JEUNO]CommService", 0)
        local players = zone:getPlayers()
        for name, player in pairs(players) do
            if player:hasKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD) then
                player:messageSpecial(ID.text.ZAUKO_IS_RECRUITING)
            end
        end

    -- 9PM: notify the person on the quest that they can begin lighting lamps
    elseif VanadielHour == 21 then
        local playerOnQuest = GetPlayerByID(GetServerVariable("[JEUNO]CommService"))
        if playerOnQuest then
            playerOnQuest:startEvent(114)
        end

    -- 1AM: if nobody has accepted the quest yet, NPC Vhana Ehgaklywha takes up the task
    -- she starts near Zauko and paths all the way to the Rolanberry exit.
    -- xi.path.flag.WALLHACK because she gets stuck on some terrain otherwise.
    elseif VanadielHour == 1 then
        if playerOnQuestId == 0 then
            local npc = GetNPCByID(ID.npc.VHANA_EHGAKLYWHA)
            npc:clearPath()
            npc:setStatus(0)
            npc:initNpcAi()
            npc:setPos(xi.path.first(lowerJeunoGlobal.lampPath))
            npc:pathThrough(xi.path.fromStart(lowerJeunoGlobal.lampPath), bit.bor(xi.path.flag.WALLHACK))
        end

    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return m, zone_object
