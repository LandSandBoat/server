-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: Wooden Ladder
-- !pos 101.9 -1.5 -101.9
-- !pos 101.948 -1.5 -18.016
-- !pos -61.888 -1.5 -18.079
-- !pos -218.109 -1.499 18.081
-- !pos -61.903 -1.5 138.099
-- !pos 21.901 -1.5 138.096
-- !pos 101.902 -1.5 181.902
-- !pos  -159.32 -2.5 60
-- !pos -159.38 -22.559 60
-- !pos 199.317 -2.5 60
-- !pos 199.38 -22.559 60
-- !pos -200.679 -8.57 60
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local X = player:getXPos()
    local Y = player:getYPos()
    local Z = player:getZPos()

    if ((X <= 107.9 and X >= 95.9) and (Y >= -1 and Y <= 1) and (Z >= -108.9 and Z <= -98)) then
        player:startEvent(21)
    elseif ((X <= 107.9 and X >= 95.9) and (Y >= -1 and Y <= 1) and (Z >= -24 and Z <= -12)) then
        player:startEvent(22)
    elseif ((X <= -55.888 and X >= -67.888) and (Y >= -1 and Y <= 1) and (Z >= -24 and Z <= -12)) then
        player:startEvent(23)
    elseif ((X <= -212.1 and X >= -224.1) and (Y >= -1 and Y <= 1) and (Z >= 12 and Z <= 24)) then
        player:startEvent(24)
    elseif ((X <= -55.9 and X >= -67.9) and (Y >= -1 and Y <= 1) and (Z >= 132 and Z <= 144)) then
        player:startEvent(25)
    elseif ((X <= 27.9 and X >= 15.9) and (Y >= -1 and Y <= 1) and (Z >= 132 and Z <= 144)) then
        player:startEvent(26)
    elseif ((X <= 107.9 and X >= 95.9) and (Y >= -1 and Y <= 1) and (Z >= 175.9 and Z <= 187.9)) then
        player:startEvent(27)
    elseif ((X <= -153.3 and X >= -168.3) and (Y >= -2 and Y <= 0) and (Z >= 54 and Z <= 66)) then
        if (player:getCurrentMission(COP) == tpz.mission.id.cop.DISTANT_BELIEFS and player:getCharVar("PromathiaStatus") == 1) then
            player:setCharVar("PromathiaStatus", 2)
            player:startEvent(35)
        else
            player:startEvent(28)
        end
    elseif ((X <= -153.3 and X >= -168.3) and (Y >= -24 and Y <= -22) and (Z >= 54 and Z <= 66)) then
        player:startEvent(29)
    elseif ((X <= 205.3 and X >= 193.3) and (Y >= -2 and Y <= 0) and (Z >= 54 and Z <= 66)) then
        player:startEvent(30)
    elseif ((X <= 205.3 and X >= 193.3) and (Y >= -24 and Y <= -22) and (Z >= 54 and Z <= 66)) then
        player:startEvent(31)
    elseif ((X <= -194.6 and X >= -206.6) and (Y >= -8 and Y <= -6) and (Z >= 54 and Z <= 66)) then
        player:messageSpecial(ID.text.DOOR_SEALED_SHUT)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
