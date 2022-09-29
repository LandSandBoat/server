-----------------------------------
-- Area: Throne Room
-- Name: Bastok Mission 9-2
-- !pos -111 -6 0 165
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------

local content = Battlefield:new({
    zoneId = xi.zone.THRONE_ROOM,
    battlefieldId = xi.battlefield.id.WHERE_TWO_PATHS_CONVERGE,
    menuBit = 1,
    entryNpc = "Throne_Room",
    exitNpc = "Throne_Room_Exit",
})

function content:onBattlefieldInitialise(battlefield)
    Battlefield.onBattlefieldInitialise(self, battlefield)
    battlefield:setLocalVar("phaseChange", 1)
end

function content:checkRequirements(player, npc, registrant, trade)
    local bastok       = player:getCurrentMission(xi.mission.log_id.BASTOK)
    local nationStatus = player:getMissionStatus(player:getNation())
    return bastok == xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE and nationStatus == 1
end

function content:checkSkipCutscene(player)
    local bastok       = player:getCurrentMission(xi.mission.log_id.BASTOK)
    local nationStatus = player:getMissionStatus(player:getNation())
    return player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) or
        (bastok == xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE and nationStatus > 4)
end

function content:onBattlefieldWin(player, battlefield)
    if player:getCurrentMission(xi.mission.log_id.BASTOK) == xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE then
        player:setLocalVar("battlefieldWin", battlefield:getID())
    end

    local _, clearTime, partySize = battlefield:getRecord()
    local canSkipCS = (player:getCurrentMission(xi.mission.log_id.BASTOK) ~= xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) and 1 or 0
    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), canSkipCS)
end

return content:register()
