-----------------------------------
-- Area: Windurst Waters
--  NPC: Lumomo
-- Type: Quest NPC - Involved in Eco-Warrior (Windurst)
-- !pos -55.770 -5.499 18.914 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ecoStatus = player:getCharVar('EcoStatus')

    if
        ecoStatus == 0 and
        player:getFameLevel(xi.quest.fame_area.WINDURST) >= 1 and
        player:getCharVar('EcoReset') < os.time()
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

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 818 and option == 1 then
        if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ECO_WARRIOR) == QUEST_AVAILABLE then
            player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ECO_WARRIOR)
        end

        player:setCharVar('EcoStatus', 201) -- EcoStatus var:  1 to 3 for sandy // 101 to 103 for bastok // 201 to 203 for windurst
    elseif
        csid == 822 and
        npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.ECO_WARRIOR, {
            gil = 5000,
            item = 4198,
            title = xi.title.EMERALD_EXTERMINATOR,
            fame = 80,
            fameArea = xi.quest.fame_area.WINDURST,
            var = 'EcoStatus'
        })
    then
        player:delKeyItem(xi.ki.INDIGESTED_MEAT)
        player:setCharVar('EcoReset', getConquestTally())
    end
end

return entity
