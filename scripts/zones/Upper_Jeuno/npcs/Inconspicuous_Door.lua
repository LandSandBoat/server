-----------------------------------
-- Area: Upper Jeuno (244)
--  NPC: Inconspicuous Door
-- A Moogle Kupo d'Etat Mission NPC
-- !pos -15 1.300 68
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local jamInJeuno = player:getCurrentMission(AMK) == tpz.mission.id.amk.HASTEN_IN_A_JAM_IN_JEUNO
    local myDecrepitDomicile = player:getCurrentMission(AMK) == tpz.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE
    local theProfessorsPrice = player:getCurrentMission(AMK) == tpz.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE

    local hasMetalStrip = player:hasKeyItem(tpz.ki.STURDY_METAL_STRIP)
    local hasTreeBark = player:hasKeyItem(tpz.ki.PIECE_OF_RUGGED_TREE_BARK)
    local hasLambRoast = player:hasKeyItem(tpz.ki.SAVORY_LAMB_ROAST)

    if jamInJeuno then
        player:startEvent(10178)
    elseif myDecrepitDomicile and hasMetalStrip and player:getCharVar("AMK") == 1 then
        player:startEvent(10179) -- Metal Strip handed in
    elseif myDecrepitDomicile and player:getCharVar("AMK") == 1 then
        player:startEvent(10186) -- Metal Strip reminder
    elseif myDecrepitDomicile and hasTreeBark and player:getCharVar("AMK") == 2 then
        player:startEvent(10180) -- Tree Bark handed in
    elseif myDecrepitDomicile and player:getCharVar("AMK") == 2 then
        player:startEvent(10187) -- Tree Bark reminder
    elseif myDecrepitDomicile and hasLambRoast and player:getCharVar("AMK") == 3 then
        player:startEvent(10181) -- Lamb Roast handed in
    elseif myDecrepitDomicile and player:getCharVar("AMK") == 3 then
        player:startEvent(10188) -- Lamb Roast reminder
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10178 then
        player:setCharVar("AMK", 1)
        player:completeMission(AMK, tpz.mission.id.amk.HASTEN_IN_A_JAM_IN_JEUNO)
        player:addMission(AMK, tpz.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE)
    elseif csid == 10179 then
        player:setCharVar("AMK", 2)
        player:delKeyItem(tpz.ki.STURDY_METAL_STRIP)
    elseif csid == 10180 then
        player:setCharVar("AMK", 3)
        player:delKeyItem(tpz.ki.PIECE_OF_RUGGED_TREE_BARK)
    elseif csid == 10181 then
        player:setCharVar("AMK", 0)
        player:delKeyItem(tpz.ki.SAVORY_LAMB_ROAST)
        player:completeMission(AMK, tpz.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE)
        player:addMission(AMK, tpz.mission.id.amk.CURSES_A_HORRIFICALLY_HARROWING_HEX)
    end
end
