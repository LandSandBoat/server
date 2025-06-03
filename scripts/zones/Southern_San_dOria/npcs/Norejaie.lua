-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Norejaie
-- !pos 83.924 1 110.54 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local ecoStatus = player:getCharVar('EcoStatus')

    if
        ecoStatus == 0 and
        player:getFameLevel(xi.fameArea.SANDORIA) >= 1 and
        player:getCharVar('EcoReset') == 0
    then
        player:startEvent(677) -- Offer Eco-Warrior quest
    elseif ecoStatus == 1 then
        player:startEvent(679) -- Reminder dialogue to talk to Rojaireaut
    elseif ecoStatus == 3 and player:hasKeyItem(xi.ki.INDIGESTED_STALAGMITE) then
        player:startEvent(681) -- Complete quest
    elseif ecoStatus > 100 then
        player:startEvent(682) -- Already on a different nation's Eco-Warrior
    else
        player:startEvent(680) -- Default dialogue
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 677 and option == 1 then
        if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.ECO_WARRIOR) == xi.questStatus.QUEST_AVAILABLE then
            player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.ECO_WARRIOR)
        end

        player:setCharVar('EcoStatus', 1) -- EcoStatus var:  1 to 3 for sandy // 101 to 103 for bastok // 201 to 203 for windurst
    elseif
        csid == 681 and
        npcUtil.completeQuest(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.ECO_WARRIOR, {
            gil = 5000,
            item = 4198,
            title = xi.title.VERMILLION_VENTURER,
            fame = 80,
            var = 'EcoStatus'
        })
    then
        player:delKeyItem(xi.ki.INDIGESTED_STALAGMITE)
        player:setCharVar('EcoReset', 1, NextConquestTally())
    end
end

return entity
