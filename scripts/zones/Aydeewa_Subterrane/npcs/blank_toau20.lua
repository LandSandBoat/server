-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: Blank (TOAU-20 Cutscene, TOAU-27 Cutscene)
-- !pos -298 36 -38 68
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.TEAHOUSE_TUMULT and player:getCharVar("AhtUrganStatus") == 1) then
        player:startEvent(11)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.MISPLACED_NOBILITY) then
        player:startEvent(12)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 11) then
        player:completeMission(TOAU, tpz.mission.id.toau.TEAHOUSE_TUMULT)
        player:setCharVar("AhtUrganStatus", 0)
        player:addMission(TOAU, tpz.mission.id.toau.FINDERS_KEEPERS)
    elseif (csid == 12) then
        player:completeMission(TOAU, tpz.mission.id.toau.MISPLACED_NOBILITY)
        player:addMission(TOAU, tpz.mission.id.toau.BASTION_OF_KNOWLEDGE)
    end
end
