-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------

m:addOverride("xi.zones.Port_San_dOria.npcs.Curio_Vendor_Moogle.onTrigger" = function(player, npc)
    if (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.CONFESSIONS_OF_ROYALTY) and not player:hasKeyItem(xi.keyItem.PSC_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.PSC_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.PSC_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.ASTRAL_WAVES) and not player:hasKeyItem(xi.keyItem.PFC_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.PFC_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.PFC_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_BLACK_COFFIN) and not player:hasKeyItem(xi.keyItem.SP_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.SP_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.SP_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.TEAHOUSE_TUMULT) and not player:hasKeyItem(xi.keyItem.LC_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.LC_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.LC_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.FOILED_AMBITION) and not player:hasKeyItem(xi.keyItem.C_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.C_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.C_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.BASTION_OF_KNOWLEDGE) and not player:hasKeyItem(xi.keyItem.S_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.S_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.S_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.IN_THE_BLOOD) and not player:hasKeyItem(xi.keyItem.SM_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.SM_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.SM_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.GAZE_OF_THE_SABOTEUR) and not player:hasKeyItem(xi.keyItem.CS_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.CS_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.CS_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.UNRAVELING_REASON) and not player:hasKeyItem(xi.keyItem.SL_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.SL_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.SL_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.NASHMEIRAS_PLEA) and not player:hasKeyItem(xi.keyItem.FL_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.FL_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.FL_WILDCAT_BADGE)
	elseif (player:getCurrentMission(xi.mission.log_id.TOAU, xi.mission.id.toau.ETERNAL_MERCENARY) and not player:hasKeyItem(xi.keyItem.CAPTAIN_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.CAPTAIN_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.CAPTAIN_WILDCAT_BADGE)
	end	
        player:startEvent(9601)
end)

m:addOverride("xi.zones.Port_Bastok.npcs.Curio_Vendor_Moogle.onTrigger" = function(player, npc)
    if (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.CONFESSIONS_OF_ROYALTY) and not player:hasKeyItem(xi.keyItem.PSC_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.PSC_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.PSC_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.ASTRAL_WAVES) and not player:hasKeyItem(xi.keyItem.PFC_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.PFC_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.PFC_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_BLACK_COFFIN) and not player:hasKeyItem(xi.keyItem.SP_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.SP_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.SP_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.TEAHOUSE_TUMULT) and not player:hasKeyItem(xi.keyItem.LC_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.LC_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.LC_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.FOILED_AMBITION) and not player:hasKeyItem(xi.keyItem.C_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.C_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.C_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.BASTION_OF_KNOWLEDGE) and not player:hasKeyItem(xi.keyItem.S_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.S_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.S_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.IN_THE_BLOOD) and not player:hasKeyItem(xi.keyItem.SM_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.SM_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.SM_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.GAZE_OF_THE_SABOTEUR) and not player:hasKeyItem(xi.keyItem.CS_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.CS_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.CS_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.UNRAVELING_REASON) and not player:hasKeyItem(xi.keyItem.SL_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.SL_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.SL_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.NASHMEIRAS_PLEA) and not player:hasKeyItem(xi.keyItem.FL_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.FL_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.FL_WILDCAT_BADGE)
	elseif (player:getCurrentMission(xi.mission.log_id.TOAU, xi.mission.id.toau.ETERNAL_MERCENARY) and not player:hasKeyItem(xi.keyItem.CAPTAIN_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.CAPTAIN_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.CAPTAIN_WILDCAT_BADGE)
	end	
        player:startEvent(9601)
end)

m:addOverride("xi.zones.Port_Windurst.npcs.Curio_Vendor_Moogle.onTrigger" = function(player, npc)
    if (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.CONFESSIONS_OF_ROYALTY) and not player:hasKeyItem(xi.keyItem.PSC_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.PSC_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.PSC_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.ASTRAL_WAVES) and not player:hasKeyItem(xi.keyItem.PFC_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.PFC_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.PFC_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_BLACK_COFFIN) and not player:hasKeyItem(xi.keyItem.SP_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.SP_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.SP_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.TEAHOUSE_TUMULT) and not player:hasKeyItem(xi.keyItem.LC_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.LC_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.LC_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.FOILED_AMBITION) and not player:hasKeyItem(xi.keyItem.C_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.C_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.C_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.BASTION_OF_KNOWLEDGE) and not player:hasKeyItem(xi.keyItem.S_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.S_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.S_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.IN_THE_BLOOD) and not player:hasKeyItem(xi.keyItem.SM_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.SM_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.SM_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.GAZE_OF_THE_SABOTEUR) and not player:hasKeyItem(xi.keyItem.CS_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.CS_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.CS_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.UNRAVELING_REASON) and not player:hasKeyItem(xi.keyItem.SL_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.SL_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.SL_WILDCAT_BADGE)
	elseif (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.NASHMEIRAS_PLEA) and not player:hasKeyItem(xi.keyItem.FL_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.FL_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.FL_WILDCAT_BADGE)
	elseif (player:getCurrentMission(xi.mission.log_id.TOAU, xi.mission.id.toau.ETERNAL_MERCENARY) and not player:hasKeyItem(xi.keyItem.CAPTAIN_WILDCAT_BADGE)) then
	    player:addKeyItem(xi.keyItem.CAPTAIN_WILDCAT_BADGE)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.CAPTAIN_WILDCAT_BADGE)
	end	
        player:startEvent(9601)
end)