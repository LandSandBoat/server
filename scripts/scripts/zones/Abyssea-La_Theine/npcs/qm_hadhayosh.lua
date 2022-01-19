-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_hadhayosh (???)
-- Spawns Hadhayosh
-- !pos 434 24 41 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if player:hasKeyItem(xi.ki.MARBLED_MUTTON_CHOP) and  player:hasKeyItem(xi.ki.BLOODIED_SABER_TOOTH) and  player:hasKeyItem(xi.ki.BLOOD_SMEARED_GIGAS_HELM) and  player:hasKeyItem(xi.ki.GLITTERING_PIXIE_CHOKER) then
     player:delKeyItem(xi.ki.MARBLED_MUTTON_CHOP)
	 player:delKeyItem(xi.ki.BLOODIED_SABER_TOOTH)
	 player:delKeyItem(xi.ki.BLOOD_SMEARED_GIGAS_HELM)
	 player:delKeyItem(xi.ki.GLITTERING_PIXIE_CHOKER)
     SpawnMob(17318461):updateClaim(player)
	 else
	player:PrintToPlayer("I need a MARBLED MUTTON_CHOP, BLOODIED SABER TOOTH, BLOOD SMEARED GIGAS HELM.", 0xD)
	player:PrintToPlayer("and GLITTERING PIXIE CHOKER.", 0xD)
    
	end
	end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end


return entity