-----------------------------------
-- Area: Norg
--  NPC: Oaken door (Gilgamesh's room)
-- !pos 97 -7 -12 252
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local ZilartMission = player:getCurrentMission(ZILART)
    local currentMission = player:getCurrentMission(BASTOK)
    local ZilartStatus = player:getCharVar("ZilartStatus")

    -- Checked here to be fair to new players
    local DMEarrings = 0
    for i=14739, 14743 do
        if (player:hasItem(i)) then
            DMEarrings = DMEarrings + 1
        end
    end

    if (ZilartMission == tpz.mission.id.zilart.WELCOME_TNORG) then
        player:startEvent(2) -- Zilart Missions 2
    elseif (ZilartMission == tpz.mission.id.zilart.ROMAEVE and player:getCharVar("ZilartStatus") <= 1) then
        player:startEvent(3) -- Zilart Missions 9
    elseif (ZilartMission == tpz.mission.id.zilart.THE_HALL_OF_THE_GODS) then
        player:startEvent(169) -- Zilart Missions 11
    elseif (currentMission == tpz.mission.id.bastok.THE_PIRATE_S_COVE and player:getCharVar("MissionStatus") == 1) then
        player:startEvent(98) -- Bastok Mission 6-2
    elseif (ZilartMission == tpz.mission.id.zilart.THE_SEALED_SHRINE and ZilartStatus == 0 and DMEarrings <= NUMBER_OF_DM_EARRINGS) then
        player:startEvent(172)
    else
        player:startEvent(5)
    end

    return 1

end

-- 175  5  2  3  169  172  206  235
-- 175  0  2  3  4  7  8  9  10  98  99  29  12  13
-- 146  158  164  169  170  171  172  173  176  177  232  233  234
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 2 and option == 0) then
        player:completeMission(ZILART, tpz.mission.id.zilart.WELCOME_TNORG)
        player:addMission(ZILART, tpz.mission.id.zilart.KAZAMS_CHIEFTAINESS)
    elseif (csid == 3 and option == 0) then
        player:setCharVar("ZilartStatus", 0)
        player:completeMission(ZILART, tpz.mission.id.zilart.ROMAEVE)
        player:addMission(ZILART, tpz.mission.id.zilart.THE_TEMPLE_OF_DESOLATION)
    elseif (csid == 169 and option == 0) then
        player:completeMission(ZILART, tpz.mission.id.zilart.THE_HALL_OF_THE_GODS)
        player:addMission(ZILART, tpz.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)
    elseif (csid == 98) then
        player:setCharVar("MissionStatus", 2)
    elseif (csid == 172 and bit.band(option, 0x40000000) == 0) then
        player:setCharVar("ZilartStatus", 1)
    end

end
