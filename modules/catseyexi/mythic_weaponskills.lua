-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Ahaadah.onTrade" = function(player, npc, trade)
	local gil = trade:getGil()
    local count = trade:getItemCount()
	local tradeMerits = player:getMeritCount()
	
	-- Initialize the CharVar
	if (player:getCharVar("[CXI]MythicMeritCounter") == nil) then
		player:setCharVar("[CXI]MythicMeritCounter", -1)
	end
	
	local storedMerits = player:getCharVar("[CXI]MythicMeritCounter") 
	
	if (tradeMerits < 1 and player:getCharVar("[CXI]MythicMeritCounter") ~= 200) then
		player:PrintToPlayer("Ahaadah: You have no merit points to deposit.", 0xD)
	elseif (player:getCharVar("[CXI]MythicMeritCounter") >= 200 and trade:hasItemQty(2956, 10)) then
		player:setCharVar("[CXI]MythicCrestCounter", 10)
		player:tradeComplete()
		player:PrintToPlayer("Ahaadah: Looks like all 10 High Kindred Crests are here... Come back later for further instruction.", 0xD)
	elseif (player:getCharVar("[CXI]MythicMeritCounter") >= 200) then
		player:PrintToPlayer("Ahaadah: You've already turned in enough merit points.", 0xD)
	elseif gil == 1000 then 
		player:setCharVar("[CXI]MythicMeritCounter", tradeMerits + storedMerits)
		player:setMerits(0)
		player:tradeComplete()
		if (player:getCharVar("[CXI]MythicMeritCounter") < 200) then
			player:PrintToPlayer(string.format("Ahaadah: That's a total of %i of 200 Merits stored, keep 'em comin!", player:getCharVar("[CXI]MythicMeritCounter")), 0xD)
		else
			player:PrintToPlayer("Ahaadah: Good job! That's all 200 of 'em. Talk to me again to continue.", 0xD)	
		end
	end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Ahaadah.onTrigger" = function(player, npc)
	-- check to see if player has successfully completed any of the Trial Weapon quests
	local BladeKuStatus = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.BUGI_SODEN)
	local SavageBladeStatus = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.OLD_WOUNDS)
	local GroundStrikeStatus = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.INHERITANCE)
	local DetonatorStatus = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SHOOT_FIRST_ASK_QUESTIONS_LATER)
	local AsuranFistsStatus = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WALLS_OF_YOUR_MIND)
	local SteelCycleStatus = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WEIGHT_OF_YOUR_LIMITS)
	local DecimationStatus = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.AXE_THE_COMPETITION)
	local EviscerationStatus = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.CLOAK_AND_DAGGER) 
	local TachiKashaStatus = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_POTENTIAL_WITHIN)
	local ImpulseDriveStatus = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.METHODS_CREATE_MADNESS) 
	local SpiralHellStatus = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SOULS_IN_SHADOW)
	local RetributionStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLOOD_AND_GLORY)
	local EmpyrealArrowStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FROM_SAPLINGS_GROW)
	local BlackHaloStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ORASTERY_WOES)
	
	-- If the player has deposited 200 merits, 10 H. Kindred Crests, and has completed any of the Trial Weapon quests, give them reward.
	if (player:getCharVar("[CXI]MythicMeritCounter") >= 200 and player:getCharVar("[CXI]MythicCrestCounter") == 10 and not (
	 (BladeKuStatus == QUEST_COMPLETED) or (SavageBladeStatus == QUEST_COMPLETED) or (GroundStrikeStatus == QUEST_COMPLETED) or
	 (DetonatorStatus == QUEST_COMPLETED) or (AsuranFistsStatus == QUEST_COMPLETED) or (SteelCycleStatus == QUEST_COMPLETED) or
	 (DecimationStatus == QUEST_COMPLETED) or (EviscerationStatus == QUEST_COMPLETED) or (TachiKashaStatus == QUEST_COMPLETED) or
	 (ImpulseDriveStatus == QUEST_COMPLETED) or (SpiralHellStatus == QUEST_COMPLETED) or (RetributionStatus == QUEST_COMPLETED) or
	 (EmpyrealArrowStatus == QUEST_COMPLETED) or (BlackHaloStatus == QUEST_COMPLETED))) then
		player:PrintToPlayer("Ahaadah: Hmm... It doesn't appear you've completed any weapon trials yet...", 0xD)
	elseif (player:getCharVar("[CXI]MythicMeritCounter") >= 200 and player:getCharVar("[CXI]MythicCrestCounter") == 10 and (
	 (BladeKuStatus == QUEST_COMPLETED) or (SavageBladeStatus == QUEST_COMPLETED) or (GroundStrikeStatus == QUEST_COMPLETED) or
	 (DetonatorStatus == QUEST_COMPLETED) or (AsuranFistsStatus == QUEST_COMPLETED) or (SteelCycleStatus == QUEST_COMPLETED) or
	 (DecimationStatus == QUEST_COMPLETED) or (EviscerationStatus == QUEST_COMPLETED) or (TachiKashaStatus == QUEST_COMPLETED) or
	 (ImpulseDriveStatus == QUEST_COMPLETED) or (SpiralHellStatus == QUEST_COMPLETED) or (RetributionStatus == QUEST_COMPLETED) or
	 (EmpyrealArrowStatus == QUEST_COMPLETED) or (BlackHaloStatus == QUEST_COMPLETED))) then
		player:PrintToPlayer("Ahaadah: Well, looks like everything's in order... I need you to report your success to Falreze", 0xD)
		player:PrintToPlayer("at the Archduke's house in Ru'Lude Gardens... He'll know what to do next...", 0xD)
		player:setCharVar("[CXI]MythicWsQuestPart1", 1)
	elseif (player:getCharVar("[CXI]MythicMeritCounter") >= 200) then
		player:PrintToPlayer("Ahaadah: Wow! 200 merits already?! Your next objective is to bring me 10 H. Kindred Crests.", 0xD)
	else	
		player:PrintToPlayer("Ahaadah: Hey, you. Looking for that \"Extra Edge\" out on the battlefield? Stock up on merit points", 0xD)
		player:PrintToPlayer("and bring them to me. I'll deposit them for you for a small fee of 1000 gil. Once you reach 200 I'll", 0xD)
		player:PrintToPlayer("tell you what to do next.", 0xD)
	end
end)

m:addOverride("xi.zones.RuLude_Gardens.npcs.Falreze.onTrade" = function(player, npc, trade)
	local KingsJusticeWeapon = npcUtil.tradeHas(trade, 20865)
	local AsceticsFuryWeapon = npcUtil.tradeHas(trade, 27882)
	local MysticBoonWeapon = npcUtil.tradeHas(trade, 21119)
	local VidohunirWeapon = npcUtil.tradeHas(trade, 21182)
	local DeathBlossomWeapon = npcUtil.tradeHas(trade, 20766)
	local MandalicStabWeapon = npcUtil.tradeHas(trade, 21251)
	local AtonementWeapon = npcUtil.tradeHas(trade, 28656)
	local InsurgencyWeapon = npcUtil.tradeHas(trade, 20908)
	local PrimalRendWeapon = npcUtil.tradeHas(trade, 20817)
	local MordantRimeWeapon = npcUtil.tradeHas(trade, 20624)
	local TrueflightWeapon = npcUtil.tradeHas(trade, 21231)
	local TachiRanaWeapon = npcUtil.tradeHas(trade, 21044)
	local BladeKamuWeapon = npcUtil.tradeHas(trade, 20998)
	local DrakesbaneWeapon = npcUtil.tradeHas(trade, 20954)
	local GarlandOfBlissWeapon = npcUtil.tradeHas(trade, 21183)
	local ExpiacionWeapon = npcUtil.tradeHas(trade, 20726)
	local LeadenSaluteWeapon = npcUtil.tradeHas(trade, 21281)
	local StringingPummelWeapon = npcUtil.tradeHas(trade, 21453)
	local PyrrhicKleosWeapon = npcUtil.tradeHas(trade, 20540)
	local OmniscienceWeapon	 = npcUtil.tradeHas(trade, 27883)
	local doneDeal = false
	
	if (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and KingsJusticeWeapon) then
		player:PrintToPlayer("You have unlocked \"King's Justice\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.KINGS_JUSTICE)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and AsceticsFuryWeapon) then
		player:PrintToPlayer("You have unlocked \"Ascetic's Fury\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.ASCETICS_FURY)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and MysticBoonWeapon) then
		player:PrintToPlayer("You have unlocked \"Mystic Boon\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.MYSTIC_BOON)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and VidohunirWeapon) then
		player:PrintToPlayer("You have unlocked \"Vidohunir\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.VIDOHUNIR)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and DeathBlossomWeapon) then
		player:PrintToPlayer("You have unlocked \"Death Blossom\"!")
		player:addLearnedWeaponskill(xi.ws_unlock.DEATH_BLOSSOM)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and MandalicStabWeapon) then
		player:PrintToPlayer("You have unlocked \"Mandalic Stab\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.MANDALIC_STAB)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and AtonementWeapon) then
		player:PrintToPlayer("You have unlocked \"Atonement\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.ATONEMENT)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and InsurgencyWeapon) then
		player:PrintToPlayer("You have unlocked \"Insurgency\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.INSURGENCY)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and PrimalRendWeapon) then
		player:PrintToPlayer("You have unlocked \"Primal Rend\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.PRIMAL_REND)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and MordantRimeWeapon) then
		player:PrintToPlayer("You have unlocked \"Mordant Rime\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.MORDANT_RIME)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and TrueflightWeapon) then
		player:PrintToPlayer("You have unlocked \"True Flight\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.TRUEFLIGHT)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and TachiRanaWeapon) then
		player:PrintToPlayer("You have unlocked \"Tachi: Rana\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.TACHI_RANA)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and BladeKamuWeapon) then
		player:PrintToPlayer("You have unlocked \"Blade: Kamu\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.BLADE_KAMU)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and DrakesbaneWeapon) then
		player:PrintToPlayer("You have unlocked \"Drakesbane\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.DRAKESBANE)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and GarlandOfBlissWeapon) then
		player:PrintToPlayer("You have unlocked \"Garland of Bliss\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.GARLAND_OF_BLISS)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and ExpiacionWeapon) then
		player:PrintToPlayer("You have unlocked \"Expiacion\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.EXPIACION)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and LeadenSaluteWeapon) then
		player:PrintToPlayer("You have unlocked \"Leaden Salute\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.LEADEN_SALUTE)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and StringingPummelWeapon) then
		player:PrintToPlayer("You have unlocked \"Stringing Pummel\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.STRINGING_PUMMEL)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and PyrrhicKleosWeapon) then
		player:PrintToPlayer("You have unlocked \"Pyrrhic Kleos\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.PYRRHIC_KLEOS)
		doneDeal = true
	elseif (player:getCharVar("[CXI]MythicWsQuestPart2") == 1 and OmniscienceWeapon) then
		player:PrintToPlayer("You have unlocked \"Omniscience\"!", 0xD)
		player:addLearnedWeaponskill(xi.ws_unlock.OMNISCIENCE)
		doneDeal = true
	else 
		player:PrintToPlayer("Falreze: I don't have time for this nonsense!", 0xD)
	end	
	
	if (doneDeal) then
		player:tradeComplete()
		player:PrintToPlayer("Falreze: Congratulations, now get out of my hair!", 0xD)
		player:setCharVar("[CXI]MythicWsQuestPart1", 0)
		player:setCharVar("[CXI]MythicWsQuestPart2", 0)
		player:setCharVar("[CXI]MythicMeritCounter", 0)
		player:setCharVar("[CXI]MythicCrestCounter", 0)
		player:delQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.BUGI_SODEN)
		player:delQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.OLD_WOUNDS)
		player:delQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.INHERITANCE)
		player:delQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SHOOT_FIRST_ASK_QUESTIONS_LATER)
		player:delQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WALLS_OF_YOUR_MIND)
		player:delQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WEIGHT_OF_YOUR_LIMITS)
		player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.AXE_THE_COMPETITION)
		player:delQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.CLOAK_AND_DAGGER)
		player:delQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_POTENTIAL_WITHIN)
		player:delQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.METHODS_CREATE_MADNESS)
		player:delQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SOULS_IN_SHADOW)
		player:delQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLOOD_AND_GLORY)
		player:delQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FROM_SAPLINGS_GROW)
		player:delQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ORASTERY_WOES)
	end
end)

m:addOverride("xi.zones.RuLude_Gardens.npcs.Falreze.onTrigger" = function(player, npc)
	if (player:hasKeyItem(xi.ki.HYDRA_CORPS_COMMAND_SCEPTER) and player:hasKeyItem(xi.ki.HYDRA_CORPS_EYEGLASS) and
		player:hasKeyItem(xi.ki.HYDRA_CORPS_LANTERN) and player:hasKeyItem(xi.ki.HYDRA_CORPS_TACTICAL_MAP) and 
		player:getCharVar("[CXI]MythicWsQuestPart1") == 1) then 
			player:setCharVar("[CXI]MythicWsQuestPart2", 1)
			player:PrintToPlayer("Falreze: Wow! I never thought you'd actually follow through with this... ", 0xD)
			player:PrintToPlayer("Falreze: Very well, a deal is a deal. Bring me the corresponding records of eminence", 0xD)
			player:PrintToPlayer("weapon for your weaponskill, and I'll embue forge it's power into your soul.", 0xD)
	elseif player:getCharVar("[CXI]MythicWsQuestPart1") == 1 then
		player:PrintToPlayer("Falreze: What?! Ahaadah is at it again, eh?! Giving away all of our top secret weaponskills!", 0xD)
		player:PrintToPlayer("Falreze: Very well, if you return with all four dynamis city wins, I'll give you something very special!", 0xD)
	else
		player:startEvent(121)
	end
end)
