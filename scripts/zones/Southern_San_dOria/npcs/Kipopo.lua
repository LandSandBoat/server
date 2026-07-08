-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Kipopo
-- Type: Leathercraft Synthesis Image Support
-- !pos -191.050 -2.15 12.285 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:hasKeyItem(xi.ki.TORN_PATCHES_OF_LEATHER) and
        player:getCharVar('sayItWithAHandbagCS') == 2 and
        npcUtil.tradeHasExactly(trade, { 2012, 850, 816 })
    then
        player:startEvent(910)
    end
end

entity.onTrigger = function(player, npc)
    local sayItWithAHandbagCS = player:getCharVar('sayItWithAHandbagCS')

    if
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.SAY_IT_WITH_A_HANDBAG) == xi.questStatus.QUEST_COMPLETED and
        player:getCharVar('sayItWithAHandbagBonusCS') == 1
    then
        player:startEvent(914)

    elseif
        player:hasKeyItem(xi.ki.REPAIRED_HANDBAG) and
        sayItWithAHandbagCS == 4
    then
        player:startEvent(913)

    elseif sayItWithAHandbagCS == 3 then
        if player:needToZone() then
            player:startEvent(911)
        else
            player:startEvent(912)
        end

    elseif sayItWithAHandbagCS == 2 then
        player:startEvent(909)

    elseif
        player:hasKeyItem(xi.ki.TORN_PATCHES_OF_LEATHER) and
        sayItWithAHandbagCS == 1
    then
        player:startEvent(908)

    else
        xi.crafting.oldImageSupportOnTrigger(player, npc)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 914 then
        player:setCharVar('sayItWithAHandbagBonusCS', 0)
    elseif csid == 912 then
        npcUtil.giveKeyItem(player, xi.ki.REPAIRED_HANDBAG)
        player:setCharVar('sayItWithAHandbagCS', 4)
    elseif csid == 910 then
        player:delKeyItem(xi.ki.TORN_PATCHES_OF_LEATHER)
        player:setCharVar('sayItWithAHandbagCS', 3)
        player:needToZone(true)
        player:confirmTrade()
    elseif csid == 908 and option == 1 then
        player:setCharVar('sayItWithAHandbagCS', 2)
    else
        xi.crafting.oldImageSupportOnEventFinish(player, csid, option, npc)
    end
end

return entity
