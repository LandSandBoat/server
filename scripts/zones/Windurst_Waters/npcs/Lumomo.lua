-----------------------------------
-- Area: Windurst Waters
--  NPC: Lumomo
-- !pos -55.770 -5.499 18.914 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local ecoStatus = player:getCharVar('EcoStatus')

    if
        ecoStatus == 0 and
        player:getFameLevel(xi.fameArea.WINDURST) >= 1 and
        player:getCharVar('EcoReset') == 0
    then
        player:startEvent(818) -- Offer Eco-Warrior quest
    elseif ecoStatus == 201 then
        player:startEvent(820) -- Reminder dialogue to talk to Ahko
    elseif ecoStatus == 203 and player:hasKeyItem(xi.ki.INDIGESTED_MEAT) then
        player:startEvent(822) -- Complete quest
    elseif ecoStatus ~= 0 and ecoStatus < 200 then
        player:startEvent(823) -- Already on a different nation's Eco-Warrior
    else
        player:startEvent(821) -- Default dialogue
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 818 and option == 1 then
        if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ECO_WARRIOR) == xi.questStatus.QUEST_AVAILABLE then
            player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.ECO_WARRIOR)
        end

        player:setCharVar('EcoStatus', 201) -- EcoStatus var:  1 to 3 for sandy // 101 to 103 for bastok // 201 to 203 for windurst
    elseif
        csid == 822 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.ECO_WARRIOR, {
            gil = 5000,
            item = 4198,
            title = xi.title.EMERALD_EXTERMINATOR,
            fame = 80,
            fameArea = xi.fameArea.WINDURST,
            var = 'EcoStatus'
        })
    then
        player:delKeyItem(xi.ki.INDIGESTED_MEAT)
        player:setCharVar('EcoReset', 1, NextConquestTally())
    end
end

return entity
