-----------------------------------
-- Area: Port Bastok
--  NPC: Raifa
-- Type: Quest NPC - Involved in Eco-Warrior (Bastok)
-- !pos -166.416 -8.48 7.153 236
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ecoStatus = player:getCharVar('EcoStatus')

    if
        ecoStatus == 0 and
        player:getFameLevel(xi.quest.fame_area.BASTOK) >= 1 and
        player:getCharVar('EcoReset') < os.time()
    then
        player:startEvent(278) -- Offer Eco-Warrior quest
    elseif ecoStatus == 101 then
        player:startEvent(280) -- Reminder dialogue to talk to Degga
    elseif ecoStatus == 103 and player:hasKeyItem(xi.ki.INDIGESTED_ORE) then
        player:startEvent(282) -- Complete quest
    elseif ecoStatus ~= 0 and (ecoStatus < 100 or ecoStatus > 200) then
        player:startEvent(283) -- Already on a different nation's Eco-Warrior
    else
        player:startEvent(281) -- Default dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 278 and option == 1 then
        if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.ECO_WARRIOR) == QUEST_AVAILABLE then
            player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.ECO_WARRIOR)
        end

        player:setCharVar('EcoStatus', 101) -- EcoStatus var:  1 to 3 for sandy // 101 to 103 for bastok // 201 to 203 for windurst
    elseif
        csid == 282 and
        npcUtil.completeQuest(player, xi.quest.log_id.BASTOK, xi.quest.id.bastok.ECO_WARRIOR, {
            gil = 5000,
            item = 4198,
            title = xi.title.CERULEAN_SOLDIER,
            fame = 80,
            var = 'EcoStatus'
        })
    then
        player:delKeyItem(xi.ki.INDIGESTED_ORE)
        player:setCharVar('EcoReset', getConquestTally())
    end
end

return entity
