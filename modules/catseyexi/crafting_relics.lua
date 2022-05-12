-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------

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
        player:tradeComplete()
        player:setCharVar("FreeRelic", 0)
        player:PrintToPlayer("Momiji: I'll make sure this relic gets discarded properly. Come back when you'd like another.", 0xD)
    else
        player:PrintToPlayer("Momiji: What?! I don't want this, go away!!", 0xD)
        return
    end
    
end)


m:addOverride("xi.zones.Lower_Jeuno.npcs.Momiji.onTrigger" = function(player, npc)
    local playerName = player:getName()
    local woodworkingLevel = player:getCharSkillLevel(xi.skill.WOODWORKING)
    local smithingLevel = player:getCharSkillLevel(xi.skill.SMITHING)
    local goldsmithingLevel = player:getCharSkillLevel(xi.skill.GOLDSMITHING)
    local clothcraftLevel = player:getCharSkillLevel(xi.skill.CLOTHCRAFT)
    local leathercraftLevel = player:getCharSkillLevel(xi.skill.LEATHERCRAFT)
    local bonecraftLevel = player:getCharSkillLevel(xi.skill.BONECRAFT)
    local alchemyLevel = player:getCharSkillLevel(xi.skill.ALCHEMY)
    local cookingLevel = player:getCharSkillLevel(xi.skill.COOKING)
    local hasFreeRelic = player:getCharVar("FreeRelic")
    ---- xi.keyItem.RHAPSODY_IN_WHITE
    ---- xi.keyItem.RHAPSODY_IN_CRIMSON
    if((player:hasKeyItem(xi.keyItem.RHAPSODY_IN_WHITE) == false) and (
       (woodworkingLevel >= 0600) or (smithingLevel >= 0600) or
       (goldsmithingLevel >= 0600) or (clothcraftLevel >= 0600) or
       (leathercraftLevel >= 0600) or (bonecraftLevel >= 0600) or
       (alchemyLevel >= 0600) or (cookingLevel >= 0600))) 
    then
        player:PrintToPlayer(string.format( "Momiji: You have earned this, congratulations!\n"))
        player:addKeyItem(xi.keyItem.RHAPSODY_IN_WHITE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.RHAPSODY_IN_WHITE)
        return
    end
    
    if((player:hasKeyItem(xi.keyItem.RHAPSODY_IN_CRIMSON) == false) and (
       (woodworkingLevel >= 0800) or (smithingLevel >= 0800) or
       (goldsmithingLevel >= 0800) or (clothcraftLevel >= 0800) or
       (leathercraftLevel >= 0800) or (bonecraftLevel >= 0800) or
       (alchemyLevel >= 0800) or (cookingLevel >= 0800))) 
    then
        player:PrintToPlayer(string.format( "Momiji: You have earned this, congratulations!\n"))
        player:addKeyItem(xi.keyItem.RHAPSODY_IN_CRIMSON)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.RHAPSODY_IN_CRIMSON)
        return
    end
   
    if hasFreeRelic == 1 then
        player:PrintToPlayer("Momiji: Looks like you've already gotten your free relic. You'll need to trade it back to me", 0xD)
        player:PrintToPlayer("Momiji: before obtaining another one.", 0xD)
        return
    end
   
    if(woodworkingLevel >= 0990 and player:hasItem(xi.items.SPHARAI) == false and player:getCharVar("FreeRelic") ~= 1) then
        player:PrintToPlayer("Momiji: Congratulations Grand Master Woodworker." )
        player:setCharVar("FreeRelic",1)
        player:addItem(xi.items.SPHARAI)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.SPHARAI)
        return
    end
    
    if(smithingLevel >= 0990 and player:hasItem(xi.items.GUNGNIR) == false and player:getCharVar("FreeRelic") ~= 1) then
        player:PrintToPlayer("Momiji: Congratulations Grand Master Smith." )
        player:setCharVar("FreeRelic",1)
        player:addItem(xi.items.GUNGNIR)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.GUNGNIR)
        return
    end
   
    if(goldsmithingLevel >= 0990 and player:hasItem(xi.items.GJALLARHORN) == false and player:getCharVar("FreeRelic") ~= 1) then
        player:PrintToPlayer("Momiji: Congratulations Grand Master Goldsmith." )
        player:setCharVar("FreeRelic",1)
        player:addItem(xi.items.GJALLARHORN)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.GJALLARHORN)
        return
    end
   
    if(clothcraftLevel >= 0990 and player:hasItem(xi.items.APOCALYPSE) == false and player:getCharVar("FreeRelic") ~= 1) then
        player:PrintToPlayer("Momiji: Congratulations Grand Master Clothcrafter." )
        player:setCharVar("FreeRelic",1)
        player:addItem(xi.items.APOCALYPSE)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.APOCALYPSE)
        return
    end
    
    if(leathercraftLevel >= 0990 and player:hasItem(xi.items.MANDAU) == false and player:getCharVar("FreeRelic") ~= 1) then
        player:PrintToPlayer("Momiji: Congratulations Grand Master Leathercrafter." )
        player:setCharVar("FreeRelic",1)
        player:addItem(xi.items.MANDAU)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.MANDAU)
        return
    end
    
    if(bonecraftLevel >= 0990 and player:hasItem(xi.items.AEGIS) == false and player:getCharVar("FreeRelic") ~= 1) then
        player:PrintToPlayer("Momiji: Congratulations Grand Master Bonecrafter." )
        player:setCharVar("FreeRelic",1)
        player:addItem(xi.items.AEGIS)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.AEGIS)
        return
    end
    
    if(alchemyLevel >= 0990 and player:hasItem(xi.items.EXCALIBUR) == false and player:getCharVar("FreeRelic") ~= 1) then
        player:PrintToPlayer("Momiji: Congratulations Grand Master Alchemist." )
        player:setCharVar("FreeRelic",1)
        player:addItem(xi.items.EXCALIBUR)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.EXCALIBUR)
        return
    end
    
    if(cookingLevel >= 0990 and player:hasItem(xi.items.YOICHINOYUMI) == false and player:getCharVar("FreeRelic") ~= 1) then
        player:PrintToPlayer("Momiji: Congratulations Grand Master Chef." )
        player:setCharVar("FreeRelic",1)
        player:addItem(xi.items.YOICHINOYUMI)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.YOICHINOYUMI)
        return
    end

    player:PrintToPlayer("Momiji: Oh my! What a strapping young adventurer you are! ", 0xD)
    player:PrintToPlayer("Why, I may feel inclined to offer you an extra trust spot for reaching 60+ rank in any craft!", 0xD)
    player:PrintToPlayer("Why stop there? How about another bonus spot for 80+? ", 0xD)
    player:PrintToPlayer("My, I'm feeling so generous today!  Tell you what, if you reach level 100, ", 0xD)
    player:PrintToPlayer("I'll give you a VERY special reward!", 0xD)
    player:PrintToPlayer(" ", 0xD)
    player:PrintToPlayer("Alchemy - Excalibur ", 0xD)
    player:PrintToPlayer("Bonecraft - Aegis ", 0xD)
    player:PrintToPlayer("Clothcraft - Apocalypse ", 0xD)
    player:PrintToPlayer("Cooking - Yoichinoyumi ", 0xD)
    player:PrintToPlayer("Goldsmithing - Gjallarhorn ", 0xD)
    player:PrintToPlayer("Leathercraft - Mandau ", 0xD)
    player:PrintToPlayer("Smithing - Gungnir ", 0xD)
    player:PrintToPlayer("Woodworking - Spharai ", 0xD)
    return
end)