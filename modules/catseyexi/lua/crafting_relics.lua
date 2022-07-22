-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
require("modules/module_utils")

local m = Module:new("crafting_relics")

m:addOverride("xi.zones.Lower_Jeuno.npcs.Momiji.onTrade", function(player, npc, trade)
    local tradeHasSpharai =  npcUtil.tradeHasExactly(trade, xi.items.SPHARAI)
    local tradeHasGungnir = npcUtil.tradeHasExactly(trade, xi.items.GUNGNIR)
    local tradeHasGjallarhorn = npcUtil.tradeHasExactly(trade, xi.items.GJALLARHORN)
    local tradeHasApocalypse = npcUtil.tradeHasExactly(trade, xi.items.APOCALYPSE)
    local tradeHasMandau = npcUtil.tradeHasExactly(trade, xi.items.MANDAU)
    local tradeHasAegis = npcUtil.tradeHasExactly(trade, xi.items.AEGIS)
    local tradeHasExcalibur = npcUtil.tradeHasExactly(trade, xi.items.EXCALIBUR)
    local tradeHasYoichinoyumi = npcUtil.tradeHasExactly(trade, xi.items.YOICHINOYUMI)
    local tradeHasGuttler = npcUtil.tradeHasExactly(trade, xi.items.GUTTLER)
    local tradeHasRagnarok = npcUtil.tradeHasExactly(trade, xi.items.RAGNAROK)
    local tradeHasBravura = npcUtil.tradeHasExactly(trade, xi.items.BRAVURA)
    local tradeHasKikoku = npcUtil.tradeHasExactly(trade, xi.items.KIKOKU)
    local tradeHasAmanomurakumo = npcUtil.tradeHasExactly(trade, xi.items.AMANOMURAKUMO)
    local tradeHasMjollnir = npcUtil.tradeHasExactly(trade, xi.items.MJOLLNIR)
    local tradeHasClaustrum = npcUtil.tradeHasExactly(trade, xi.items.CLAUSTRUM)
    local tradeHasAnnihilator = npcUtil.tradeHasExactly(trade, xi.items.ANNIHILATOR)
    local hasFreeRelic = player:getCharVar("FreeRelic")

    if (hasFreeRelic == 1 and (tradeHasSpharai or tradeHasGungnir or tradeHasGjallarhorn or tradeHasApocalypse or tradeHasMandau or tradeHasAegis
        or tradeHasExcalibur or tradeHasYoichinoyumi or tradeHasGuttler or tradeHasBravura or tradeHasKikoku or tradeHasAmanomurakumo
        or tradeHasMjollnir or tradeHasClaustrum or tradeHasAnnihilator)) then 

        player:PrintToPlayer("Momiji: If you wish to exchange this weapon, you'll need to complete a quest. See the Wiki for details.", 0xD)
        return
    end

end)

m:addOverride("xi.zones.Lower_Jeuno.npcs.Momiji.onTrigger", function(player, npc)
    local playerName = player:getName()
    local woodworkingLevel = player:getCharSkillLevel(xi.skill.WOODWORKING)
    local smithingLevel = player:getCharSkillLevel(xi.skill.SMITHING)
    local goldsmithingLevel = player:getCharSkillLevel(xi.skill.GOLDSMITHING)
    local clothcraftLevel = player:getCharSkillLevel(xi.skill.CLOTHCRAFT)
    local leathercraftLevel = player:getCharSkillLevel(xi.skill.LEATHERCRAFT)
    local bonecraftLevel = player:getCharSkillLevel(xi.skill.BONECRAFT)
    local alchemyLevel = player:getCharSkillLevel(xi.skill.ALCHEMY)
    local cookingLevel = player:getCharSkillLevel(xi.skill.COOKING)
	local fishingLevel = player:getCharSkillLevel(xi.skill.FISHING)
	local hasFreeRelicVoucher = player:getCharVar("RelicWeaponVoucher")
    ---- xi.keyItem.RHAPSODY_IN_WHITE
    ---- xi.keyItem.RHAPSODY_IN_CRIMSON

    if player:getCharVar("FreeRelic") == 1 then
        player:PrintToPlayer("Momiji: Looks like you've already gotten your free relic, you can't have another.", 0xD)
        return
    end

    if hasFreeRelicVoucher == 1 then
	    player:PrintToPlayer("Momiji: Looks like you already have a voucher for a free relic, go pick one!.", 0xD)
		return
	end	
	
    if ((player:hasKeyItem(xi.keyItem.RHAPSODY_IN_WHITE) == false) and ((woodworkingLevel >= 0600) or (smithingLevel >= 0600) or
       (goldsmithingLevel >= 0600) or (clothcraftLevel >= 0600) or (leathercraftLevel >= 0600) or (bonecraftLevel >= 0600) or (alchemyLevel >= 0600) or (cookingLevel >= 0600) or (fishingLevel >= 0600))) then
        player:PrintToPlayer(string.format( "Momiji: You have earned this, congratulations!\n"))
        player:addKeyItem(xi.keyItem.RHAPSODY_IN_WHITE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.RHAPSODY_IN_WHITE)
        return
    end
    
	if ((player:hasKeyItem(xi.keyItem.RHAPSODY_IN_CRIMSON) == false) and ((woodworkingLevel >= 0800) or (smithingLevel >= 0800) or (goldsmithingLevel >= 0800) or (clothcraftLevel >= 0800) or
        (leathercraftLevel >= 0800) or (bonecraftLevel >= 0800) or (alchemyLevel >= 0800) or (cookingLevel >= 0800) or (fishingLevel >= 0800))) then
        player:PrintToPlayer(string.format( "Momiji: You have earned this, congratulations!\n"))
        player:addKeyItem(xi.keyItem.RHAPSODY_IN_CRIMSON)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.RHAPSODY_IN_CRIMSON)
        return
    end


    if (woodworkingLevel >= 0990 or smithingLevel >= 0990 or goldsmithingLevel >= 0990 or clothcraftLevel >= 0990 or leathercraftLevel >= 0990 or
        bonecraftLevel >= 0990 or alchemyLevel >= 0990 or cookingLevel >= 0990 or fishingLevel >= 0990) then
	    player:PrintToPlayer("Momiji: Congratulations Grand Master, here is your relic weapon voucher. Visit the corresponding ???", 0xD)
	    player:PrintToPlayer("to accept your new weapon!", 0xD)
		player:setCharVar("FreeRelic", 1)
	    player:setCharVar("RelicWeaponVoucher", 1)
		return
	end	

    player:PrintToPlayer("Momiji: Oh my! What a strapping young adventurer you are! ", 0xD)
    player:PrintToPlayer("Why, I may feel inclined to offer you an extra trust spot for reaching 60+ rank in any craft!", 0xD)
    player:PrintToPlayer("Why stop there? How about another bonus spot for 80+? ", 0xD)
    player:PrintToPlayer("My, I'm feeling so generous today!  Tell you what, if you reach level 100, ", 0xD)
    player:PrintToPlayer("I'll give you a VERY special reward!", 0xD)
    return
end)

return m