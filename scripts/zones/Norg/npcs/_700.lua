-----------------------------------
-- Area: Norg
--  NPC: Oaken door (Gilgamesh's room)
-- !pos 97 -7 -12 252
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/rhapsodies")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ZilartMission = player:getCurrentMission(ZILART)
    local currentMission = player:getCurrentMission(BASTOK)
    local ZilartStatus = player:getMissionStatus(xi.mission.log_id.ZILART)
    local PromathiaMission = player:getCurrentMission(COP)
    local RhapsodiesMission = player:getCurrentMission(ROV)

    -- On retail, ROV missions always take precedence over other missions
    if RhapsodiesMission == xi.mission.id.rov.THE_BEGINNING then
        player:startEvent(276)
    elseif RhapsodiesMission == xi.mission.id.rov.FLAMES_OF_PRAYER then
        player:startEvent(277)
    elseif RhapsodiesMission == xi.mission.id.rov.FATES_CALL and player:getRank(player:getNation()) > 5 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.FATES_CALL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_LIES_BEYOND)
        player:startEvent(278)
    elseif RhapsodiesMission == xi.mission.id.rov.WHAT_LIES_BEYOND then
        player:startEvent(278)
    elseif player:getCharVar("ZeidIICipher") == 1 then
        if npcUtil.giveItem(player, 10160) then -- Cipher: Zeid II
            player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.VOLTO_OSCURO)
            player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RING_MY_BELL)
            player:setCharVar("ZeidIICipher", 0)
        end
    elseif RhapsodiesMission == xi.mission.id.rov.VOLTO_OSCURO then
        player:startEvent(279)
    elseif RhapsodiesMission == xi.mission.id.rov.RING_MY_BELL and xi.rhapsodies.charactersAvailable(player) then
        -- Below params change depending on how well you know COP characters. The precise COP mission values are
        -- currently unknown. What's known from retail is that a character that has never started COP gets Tenzen
        -- and Prishe params of 0, while characters who have completed it get Tenzen value of 2 and Prishe value of 1.
        -- Currently chosen missions which assign Tenzen and Prishe values of 1 are guessed (first meeting in COP)
        local metPrishe = (PromathiaMission >= xi.mission.id.cop.DISTANT_BELIEFS) and 1 or 0
        local metTenzen = (PromathiaMission >= xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN) and 1 or 0
        if metTenzen == 1 then
            metTenzen = (PromathiaMission >= xi.mission.id.cop.DAWN) and 2 or 1
        end
        player:startEvent(284, metTenzen, metPrishe)
    elseif (currentMission == xi.mission.id.bastok.THE_PIRATE_S_COVE and player:getMissionStatus(player:getNation()) == 1) then
        player:startEvent(98) -- Bastok Mission 6-2
    elseif player:getCharVar('ApocalypseNigh') == 6 and os.time() < player:getCharVar("Apoc_Nigh_Reward") then
        player:startEvent(235)
    elseif RhapsodiesMission == xi.mission.id.rov.RING_MY_BELL then
        player:startEvent(283)
    else
        player:startEvent(5)
    end

    return 1
end

-- 175  5  2  3  169  172  206  235
-- 175  0  2  3  4  7  8  9  10  98  99  29  12  13
-- 146  158  164  169  170  171  172  173  176  177  232  233  234
entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 98) then
        player:setMissionStatus(player:getNation(), 2)
    elseif csid == 276 then
        -- Clear 1-3 flag
        player:setCharVar("RhapsodiesStatus", 0)
        npcUtil.giveKeyItem(player, xi.ki.REISENJIMA_SANCTORIUM_ORB)
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.THE_BEGINNING)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.FLAMES_OF_PRAYER)
    elseif csid == 277 then
        npcUtil.giveKeyItem(player, xi.ki.RHAPSODY_IN_WHITE)
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.FLAMES_OF_PRAYER)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.THE_PATH_UNTRAVELED)
    elseif csid == 278 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_LIES_BEYOND)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.THE_TIES_THAT_BIND)
    elseif csid == 279 then
        if npcUtil.giveItem(player, 10160) then -- Cipher: Zeid II
            player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.VOLTO_OSCURO)
            player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RING_MY_BELL)
        else
            player:setCharVar("ZeidIICipher", 1)
        end
    elseif csid == 284 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.RING_MY_BELL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.SPIRITS_AWOKEN)
    end
end

return entity
