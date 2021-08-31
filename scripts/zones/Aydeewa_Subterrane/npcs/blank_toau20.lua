-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: Blank (TOAU-20 Cutscene, TOAU-27 Cutscene)
-- !pos -298 36 -38 68
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(TOAU) == xi.mission.id.toau.TEAHOUSE_TUMULT and player:getCharVar("AhtUrganStatus") == 1) then
        player:startEvent(11)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.MISPLACED_NOBILITY) then
        player:startEvent(12)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 11) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.TEAHOUSE_TUMULT)
        player:setCharVar("AhtUrganStatus", 0)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.FINDERS_KEEPERS)
    elseif (csid == 12) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.MISPLACED_NOBILITY)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.BASTION_OF_KNOWLEDGE)
    end
end

return entity
