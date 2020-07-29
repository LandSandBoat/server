-----------------------------------
-- Area: La_Theine Plateau
--  NPC: Shattered Telepoint
-- !pos 334 19 -60 102
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(COP) == tpz.mission.id.cop.BELOW_THE_ARKS and player:getCharVar("PromathiaStatus") == 1) then
        player:startEvent(202, 0, 0, 1) -- first time in promy -> have you made your preparations cs
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_MOTHERCRYSTALS and (player:hasKeyItem(tpz.ki.LIGHT_OF_MEA) or player:hasKeyItem(tpz.ki.LIGHT_OF_DEM))) then
        if (player:getCharVar("cspromy2") == 1) then
            player:startEvent(201)  -- cs you get nearing second promyvion
        else
            player:startEvent(202)
        end
    elseif (player:getCurrentMission(COP) > tpz.mission.id.cop.THE_MOTHERCRYSTALS or player:hasCompletedMission(COP, tpz.mission.id.cop.THE_LAST_VERSE) or (player:getCurrentMission(COP) == tpz.mission.id.cop.BELOW_THE_ARKS and player:getCharVar("PromathiaStatus") > 1)) then
        player:startEvent(202) -- normal cs (third promyvion and each entrance after having that promyvion visited or mission completed)
    else
        player:messageSpecial(ID.text.TELEPOINT_HAS_BEEN_SHATTERED)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 201) then
        player:setCharVar("cspromy2", 0)
        player:setCharVar("cs2ndpromy", 1)
        player:setPos(92.033, 0, 80.380, 255, 16) -- To Promyvion Holla
    elseif (csid == 202 and option == 0) then
        player:setPos(-266.76, -0.635, 280.058, 0, 14) -- To Hall of Transference {R}
    end

end
