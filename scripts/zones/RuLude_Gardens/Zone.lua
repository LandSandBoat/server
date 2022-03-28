-----------------------------------
-- Zone: RuLude_Gardens (243)
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/rhapsodies")
require("scripts/globals/items")
-----------------------------------
local zone_object = {}

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

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -16, 2, 32, 16, 4, 86) -- Palace entrance. Ends at back exit. Needs retail confirmaton for the back entrance.
	
	    local atoritutori = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Atori-Tutori",
        look = "0x0100020500101120003000400050006000700000",
        x = 11.360,
        y = 3.100,
        z = 116.881,
        rotation = 128,
        widescan = 1,

        onTrade = function(player, npc, trade)
            local pointsCost = 300000
        ----------------------------------------------------------------------
            local hasAsceticsFury    = xi.ws_unlock.ASCETICS_FURY
            local hasStringingPummel = xi.ws_unlock.STRINGING_PUMMEL
            local hasMandalicStab    = xi.ws_unlock.MANDALIC_STAB
            local hasPyrrhicKleos    = xi.ws_unlock.PYRRHIC_KLEOS
            local hasMordantRime     = xi.ws_unlock.MORDANT_RIME
            local hasKingsJustice    = xi.ws_unlock.KINGS_JUSTICE
            local hasDeathBlossom    = xi.ws_unlock.DEATH_BLOSSOM
            local hasPrimalRend      = xi.ws_unlock.PRIMAL_REND
            local hasTrueFlight      = xi.ws_unlock.TRUEFLIGHT
            local hasBladeKamu       = xi.ws_unlock.BLADE_KAMU
            local hasLeadenSalute    = xi.ws_unlock.LEADEN_SALUTE
            local hasAtonement       = xi.ws_unlock.ATONEMENT
            local hasExpiacion       = xi.ws_unlock.EXPIACION
            local hasInsurgency      = xi.ws_unlock.INSURGENCY
            local hasTachiRana       = xi.ws_unlock.TACHI_RANA
            local hasVidohunir       = xi.ws_unlock.VIDOHUNIR
            local hasDrakesbane      = xi.ws_unlock.DRAKESBANE
            local hasMysticBoon      = xi.ws_unlock.MYSTIC_BOON
            local hasGarlandOfBliss  = xi.ws_unlock.GARLAND_OF_BLISS
            local hasOmniscience     = xi.ws_unlock.OMNISCIENCE
        ----------------------------------------------------------------------
        	if player:getCharVar("PaidForMeritWs") == 1 then
                -- Shijin Spiral
        	    if npcUtil.tradeHasExactly(trade, {{wsRequirements[1][2], wsRequirements[1][3]}, {wsRequirements[1][4], wsRequirements[1][5]}})
                    and player:hasLearnedWeaponskill(hasAsceticsFury or hasStringingPummel) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Shijin Spiral\"!")
                    player:setCharVar("hasShijinSpiralUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 30 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 lancewood logs and 10 infinity cores with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock one of: AsceticsFury or StringingPummel", 28)
                    return
        
                -- Exenterator
                elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[2][2], wsRequirements[2][3]}, {wsRequirements[2][4], wsRequirements[2][5]}})
                    and player:hasLearnedWeaponskill(hasMandalicStab or hasPyrrhicKleos or hasMordantRime or hasKingsJustice or hasDeathBlossom or hasPrimalRend or hasTrueFlight or hasBladeKamu or hasLeadenSalute) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Exenterator\"!")
                    player:setCharVar("hasExenteratorUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 31 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 slime juices and 10 infinity cores with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock one of: MandalicStab, PyrrhicKleos, MordantRime, KingsJustice, DeathBlossom, PrimalRend, TrueFlight, BladeKamu or LeadenSalute", 28)
                    return
        
                -- Requiescat
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[3][2], wsRequirements[3][3]}, {wsRequirements[3][4], wsRequirements[3][5]}})
                    and player:hasLearnedWeaponskill(hasAtonement or hasExpiacion or hasDeathBlossom or hasKingsJustice or hasInsurgency or hasTachiRana or hasLeadenSalute) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Requiescat\"!")
                    player:setCharVar("hasRequiescatUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 32 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 colossal skulls and 10 infinity cores with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock one of: Atonement, Expiacion, Insurgency, KingsJustice, DeathBlossom, TachiRana or LeadenSalute", 28)
                    return
        
                -- Resolution
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[4][2], wsRequirements[4][3]}, {wsRequirements[4][4], wsRequirements[4][5]}})
                    and player:hasLearnedWeaponskill(hasAtonement or hasInsurgency or hasKingsJustice) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Resolution\"!")
                    player:setCharVar("hasResolutionUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 33 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 goblin greases and 10 infinity cores with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock one of: Atonement, Insurgency or KingsJustice", 28)
                    return
        
                -- Ruinator
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[5][2], wsRequirements[5][3]}, {wsRequirements[5][4], wsRequirements[5][5]}})
                    and player:hasLearnedWeaponskill(hasPrimalRend or hasKingsJustice or hasInsurgency or hasTrueFlight) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Ruinator\"!")
                    player:setCharVar("hasRuinatorUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 34 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 griffon hides and 10 infinity cores with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock one of: PrimalRend, TrueFlight, Insurgency or KingsJustice", 28)
                    return
        
                -- Upheaval
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[6][2], wsRequirements[6][3]}, {wsRequirements[6][4], wsRequirements[6][5]}})
                    and player:hasLearnedWeaponskill(hasKingsJustice or hasInsurgency) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Upheaval\"!")
                    player:setCharVar("hasUpheavalUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 35 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 giant frozen heads and 10 infinity cores with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock one of: KingsJustice or Insurgency", 28)
                    return
        
                -- Entropy
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[7][2], wsRequirements[7][3]}, {wsRequirements[7][4], wsRequirements[7][5]}})
                    and player:hasLearnedWeaponskill(hasInsurgency or hasKingsJustice or hasPrimalRend) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Entropy\"!")
                    player:setCharVar("hasEntropyUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 36 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 relic irons and 10 infinity cores with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock one of: KingsJustice, Insurgency or PrimalRend", 28)
                    return
        
                -- Stardiver
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[8][2], wsRequirements[8][3]}, {wsRequirements[8][4], wsRequirements[8][5]}})
                    and player:hasLearnedWeaponskill(hasDrakesbane or hasTachiRana or hasKingsJustice) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Stardiver\"!")
                    player:setCharVar("hasStardiverUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 37 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 slime juices and 10 fresh orc livers with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock one of: Drakesbane, TachiRana or KingsJustice", 28)
                    return
        
                -- Blade: Shun
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[9][2], wsRequirements[9][3]}, {wsRequirements[9][4], wsRequirements[9][5]}})
                    and player:hasLearnedWeaponskill(hasBladeKamu) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Blade Shun\"!")
                    player:setCharVar("hasBladeShunUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 38 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 wootz ores and 10 infinity cores with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock: BladeKamu", 28)
                    return
        
                -- Tachi: Shoha
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[10][2], wsRequirements[10][3]}, {wsRequirements[10][4], wsRequirements[10][5]}})
                    and player:hasLearnedWeaponskill(hasTachiRana) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Tachi: Shoha\"!")
                    player:setCharVar("hasTachiShohaUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 39 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 sparkling stones and 10 infinity cores with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock: TachiRana", 28)
                    return
        
                -- Realmrazer
        --	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[11][2], wsRequirements[11][3]}, {wsRequirements[11][4], wsRequirements[11][5]}, {wsRequirements[11][6], wsRequirements[1][7]}}) then
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[11][2], wsRequirements[11][3]}, {wsRequirements[11][4], wsRequirements[11][5]}})
                    and player:hasLearnedWeaponskill(hasMysticBoon or hasAtonement or hasKingsJustice or hasVidohunir or hasGarlandOfBliss or hasOmniscience) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Realmrazer\"!")
                    player:setCharVar("hasRealmrazerUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 40 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 giant frozen heads and 10 colossal skulls with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock one of: MysticBoon, Atonement, Vidohunir, KingsJustice, GarlandOfBliss or Omniscience", 28)
                    return
        
                -- Shattersoul
        --	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[12][2], wsRequirements[12][3]}, {wsRequirements[12][4], wsRequirements[12][5]}, {wsRequirements[12][6], wsRequirements[12][7]}}) then
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[12][2], wsRequirements[12][3]}, {wsRequirements[12][4], wsRequirements[12][5]}})
                    and player:hasLearnedWeaponskill(hasKingsJustice or hasAsceticsFury or hasMysticBoon or hasVidohunir or hasAtonement or hasMordantRime or hasDrakesbane or hasGarlandOfBliss or hasOmniscience) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Shattersoul\"!")
                    player:setCharVar("hasShattersoulUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 41 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 griffon hides and 10 infinity cores with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock one of: MysticBoon, Atonement, Vidohunir, KingsJustice, AsceticsFury, MordantRime, Drakesbane, GarlandOfBliss or Omniscience", 28)
                    return
        
                -- Apex Arrow
        --	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[13][2], wsRequirements[13][3]}, {wsRequirements[13][4], wsRequirements[13][5]}, {wsRequirements[13][6], wsRequirements[13][7]}}) then
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[13][2], wsRequirements[13][3]}, {wsRequirements[13][4], wsRequirements[13][5]}})
                    and player:hasLearnedWeaponskill(hasTrueFlight or hasTachiRana) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Apex Arrow\"!")
                    player:setCharVar("hasApexArrowUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 42 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 griffon hides and 10 lancewood logs with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock: TrueFlight or TachiRana", 28)
                    return
        
                -- Last Stand
        --	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[14][2], wsRequirements[14][3]}, {wsRequirements[14][4], wsRequirements[14][5]}, {wsRequirements[14][6], wsRequirements[14][7]}}) then
        	    elseif npcUtil.tradeHasExactly(trade, {{wsRequirements[14][2], wsRequirements[14][3]}, {wsRequirements[14][4], wsRequirements[14][5]}})
                    and player:hasLearnedWeaponskill(hasMandalicStab or hasLeadenSalute or hasTrueFlight) then
                    player:tradeComplete()
        		    player:PrintToPlayer("Congratulations! You have unlocked \"Last Stand\"!")
                    player:setCharVar("hasLastStandUnlock", 1)
                    player:setCharVar("PaidForMeritWs", 0)
                    return
                elseif npcUtil.tradeHasExactly(trade, {{ 'gil', 43 }}) then
                    player:tradeComplete()
                    player:PrintToPlayer("Arturo: I require 10 goblin greases and 10 relic irons with one mythic weaponskill unlocked!", 0xD)
                    player:PrintToPlayer("Unlock one of: MandalicStab, LeadenSalute or TrueFlight", 28)
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
                    player:PrintToPlayer("Arturo: I've deducted your Windurst conquest points and progressed you to the next step.\nTalk to me again for next steps.", 0xD)
                elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and player:getNation() == xi.nation.WINDURST and (nationCp < pointsCost)) then
                    player:PrintToPlayer("Arturo: You will need more Windurst conquest points before you do that.", 0xD)
        
            -- BASTOK
        	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and player:getNation() == xi.nation.BASTOK and (nationCp > pointsCost)) then
        		    player:tradeComplete()
        		    player:delCurrency("bastok_cp", pointsCost)
        			player:setCharVar("PaidForMeritWs", 1)
                    player:PrintToPlayer("Arturo: I've deducted your Bastok conquest points and progressed you to the next step.\nTalk to me again for next steps.", 0xD)
                elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and player:getNation() == xi.nation.BASTOK and (nationCp < pointsCost)) then
                    player:PrintToPlayer("Arturo: You will need more Bastok conquest points before you do that.", 0xD)
        
            -- SANDORIA
        	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and player:getNation() == xi.nation.SANDORIA and (nationCp > pointsCost)) then
        			player:tradeComplete()
        		    player:delCurrency("sandoria_cp", pointsCost)
                    player:setCharVar("PaidForMeritWs", 1)
                    player:PrintToPlayer("Arturo: I've deducted your San d'Oria conquest points and progressed you to the next step.\nTalk to me again for next steps.", 0xD)
                elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and player:getNation() == xi.nation.SANDORIA and (nationCp < pointsCost)) then
                    player:PrintToPlayer("Arturo: You will need more San D'oria conquest points before you do that.", 0xD)
        
            -- player has chosen to use their imperial standing points
        	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 2 }}) and (player:getCurrency("imperial_standing") > pointsCost)) then
        			player:tradeComplete()
        		    player:delCurrency("imperial_standing", pointsCost)
                    player:setCharVar("PaidForMeritWs", 1)
                    player:PrintToPlayer("Arturo: I've deducted your imperial standing points and progressed you to the next step.\nTalk to me again for next steps.", 0xD)
                elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 2 }}) and (player:getCurrency("imperial_standing") < pointsCost)) then
                    player:PrintToPlayer("Arturo: You will need more imperial standing before you do that.", 0xD)
        
            -- player has chosen to use allied notes
        	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 3 }}) and player:getCurrency("allied_notes") > pointsCost) then
        			player:tradeComplete()
        		    player:delCurrency("allied_notes", pointsCost)
                    player:setCharVar("PaidForMeritWs", 1)
                    player:PrintToPlayer("Arturo: I've deducted your allied notes and progressed you to the next step.\nTalk to me again for next steps.", 0xD)
                elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 3 }}) and (player:getCurrency("allied_notes") < pointsCost)) then
                    player:PrintToPlayer("Arturo: You will need more allied notes before you do that.", 0xD)
        	end
        		
        end,

        onTrigger = function(player, npc)
            -- set default variables
            local nationCp = 0
            local imperialStanding = player:getCurrency("imperial_standing")
            local alliedNotes = player:getCurrency("allied_notes")
            local pointsRequired = 30000
        
            -- if we've deducted the player's points, move to phase two (trade items)
        	if player:getCharVar("PaidForMeritWs") == 1 then
                player:PrintToPlayer(string.format("Arturo: Phase two: Please bring the the requisite items for the aeonic weaponskill you'd like to unlock."), 0xD)
                player:PrintToPlayer("Arturo: You'll need to have the corresponding mythic weaponskill unlocked first! Check the wiki!", 0xD)
                player:PrintToPlayer("Arturo: Trade me the fixed amount of gil below, and I'll tell you which upgrade items are necessary...", 0xD)
                player:PrintToPlayer("Shijin Spiral: 30 gil, Exenterator: 31 gil, Requiescat: 32 gil, Resolution: 33 gil, Ruinator: 34 gil, Upheaval: 35 gil", 28)
                player:PrintToPlayer("Entropy: 36 gil, Stardiver: 37 gil, Blade Shun: 38 gil, Tachi: Shoha: 39 gil, Realmrazer: 40 gil, Shattersoul: 41 gil", 28)
                player:PrintToPlayer("Apex Arrow: 42 gil, Last Stand: 43 gil", 28)
        		return
        	else
        	    -- standard dialog
                player:PrintToPlayer("Arturo: Up for a challenge? How about a new weaponskill?", 0xD)
                player:PrintToPlayer("Arturo: First, you'll need 300,000 conquest points, imperial standing, or allied notes.", 0xD)
                player:PrintToPlayer("Arturo: You will also need a Mythic Weapon Skill unlocked but we can talk about that later...", 0xD)
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
                player:PrintToPlayer(string.format("Arturo: Return to me when you have atleast 300,000 conquest points, imperial standing or allied notes.", nationCp, imperialStanding, alliedNotes), 0xD)
        	else
        	    player:PrintToPlayer(string.format("Arturo: You've got %i conquest points, %i imperial standing and %i allied notes.", nationCp, imperialStanding, alliedNotes), 0xD)
        		player:PrintToPlayer(string.format("Arturo: Trade 1g to use your conquest points, 2g to use your imperial standing, or 3g to use your allied notes."), 0xD)
        	end		
        end,
    })
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getCurrentMission(COP) == xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG and
        player:getCharVar("PromathiaStatus") == 2
    then
        cs = 10047
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(1, 5) + 45
        player:setPos(position, 10, -73, 192)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
    local regionID = region:GetRegionID()

    if regionID == 1 then
        if
            player:getCurrentMission(COP) == xi.mission.id.cop.A_PLACE_TO_RETURN and
            player:getCharVar("PromathiaStatus") == 0
        then
            player:startEvent(10048)
        elseif
            player:getCurrentMission(COP) == xi.mission.id.cop.FLAMES_IN_THE_DARKNESS and
            player:getCharVar("PromathiaStatus") == 2
        then
            player:startEvent(10051)
        elseif player:getCurrentMission(COP) == xi.mission.id.cop.DAWN then
            if
                player:getCharVar("COP_3-taru_story") == 2 and
                player:getCharVar("COP_shikarees_story") == 1 and
                player:getCharVar("COP_louverance_story") == 3 and
                player:getCharVar("COP_tenzen_story") == 1 and
                player:getCharVar("COP_jabbos_story") == 1
            then
                player:startEvent(122)
            elseif player:getCharVar("PromathiaStatus") == 7 then
                if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_AVAILABLE then
                    player:startEvent(142)
                elseif
                    player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and
                    player:getCharVar('StormsOfFate') == 3
                then
                    player:startEvent(143)
                elseif
                    player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) and
                    player:getCurrentMission(ZILART) == xi.mission.id.zilart.AWAKENING and
                    player:getMissionStatus(xi.mission.log_id.ZILART) == 3 and
                    player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) == QUEST_AVAILABLE and
                    player:getCharVar("StormsOfFateWait") <= os.time()
                then
                    player:startEvent(161)
                elseif
                    player:hasKeyItem(xi.ki.PROMYVION_HOLLA_SLIVER) and
                    player:hasKeyItem(xi.ki.PROMYVION_MEA_SLIVER) and
                    player:hasKeyItem(xi.ki.PROMYVION_DEM_SLIVER)
                then
                    player:startEvent(162)
                elseif
                    player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) and
                    player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_AVAILABLE and
                    player:getLocalVar('ANZONE') == 0 and
                    player:getCharVar("ApocNighWait") <= os.time()
                then
                    player:startEvent(123)
                end
            end
        end
    end
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 10047 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_PLACE_TO_RETURN)
    elseif csid == 10048 then
        player:setCharVar("PromathiaStatus", 1)
    elseif csid == 10051 then
        player:setCharVar("PromathiaStatus", 3)
    elseif csid == 122 then
        player:setCharVar("PromathiaStatus", 4)
        player:setCharVar("COP_3-taru_story", 0)
        player:setCharVar("COP_shikarees_story", 0)
        player:setCharVar("COP_louverance_story", 0)
        player:setCharVar("COP_tenzen_story", 0)
        player:setCharVar("COP_jabbos_story", 0)
    elseif csid == 142 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)
    elseif csid == 143 then
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)
        player:setCharVar('StormsOfFate', 0)
        player:setCharVar("StormsOfFateWait", getVanaMidnight())
    elseif csid == 161 then
        npcUtil.giveKeyItem(player, xi.ki.NOTE_WRITTEN_BY_ESHANTARL)
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
        player:setCharVar("StormsOfFateWait", 0)
    elseif csid == 162 then
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
        player:delKeyItem(xi.ki.PROMYVION_HOLLA_SLIVER)
        player:delKeyItem(xi.ki.PROMYVION_DEM_SLIVER)
        player:delKeyItem(xi.ki.PROMYVION_MEA_SLIVER)
        player:messageSpecial(ID.text.YOU_HAND_THE_THREE_SLIVERS)
        player:setLocalVar('ANZONE', 1)
        player:setCharVar("ApocNighWait", getVanaMidnight())
    elseif csid == 123 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
        player:setCharVar('ApocalypseNigh', 1)
        player:setCharVar("ApocNighWait", 0)
    end
end

return zone_object
