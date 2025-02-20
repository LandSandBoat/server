-----------------------------------
-- Area: Caedarva Mire
--  NPC: qm9
-- Involved in quest: The Wayward Automaton
-- !pos  129 1.396 -631 79
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local theWaywardAutomaton = player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATON)
    local theWaywardAutomatonProgress = player:getCharVar('TheWaywardAutomatonProgress')

    if
        theWaywardAutomaton == xi.questStatus.QUEST_ACCEPTED and
        theWaywardAutomatonProgress == 2
    then
        if player:getCharVar('TheWaywardAutomatonNM') >= 1 then
            player:startEvent(14)-- Event ID 14 for CS after toad
        elseif not GetMobByID(ID.mob.CAEDARVA_TOAD):isSpawned() then
            SpawnMob(ID.mob.CAEDARVA_TOAD):updateClaim(player) --Caedarva toad
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 14 then
        player:setCharVar('TheWaywardAutomatonProgress', 3)
        player:setCharVar('TheWaywardAutomatonNM', 0)
    end
end

return entity
