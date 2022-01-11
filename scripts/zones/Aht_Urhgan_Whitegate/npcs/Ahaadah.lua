-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ahaadah
-- !pos -70 -6 105 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
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
end

entity.onTrigger = function(player, npc)
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
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity