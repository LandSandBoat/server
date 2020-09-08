-----------------------------------
-- Area: Leujaoam Sanctum
-----------------------------------
require("scripts/globals/besieged")
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local instance = npc:getInstance()

    if (instance:completed()) then
        player:startEvent(100, 0)
    end

    return 1

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local instance = player:getInstance()
    local chars = instance:getChars()
    local id = instance:getID()
    local points = 0
    local playerpoints = ((#chars -3)*100)

    if (csid == 100 and option == 1) then
        if (id == 1) then
            points = 1000 - math.max(0, playerpoints)
        end
        for i, v in pairs(chars) do
            v:messageSpecial(ID.text.ASSAULT_POINTS_OBTAINED, points)
            v:addAssaultPoint(LEUJAOAM_ASSAULT_POINT, points)
            v:setCharVar("AssaultComplete", 1)
            if (v:hasCompletedAssault(v:getCurrentAssault())) then
                v:addCharVar("AssaultPromotion", 1)
            else
                v:addCharVar("AssaultPromotion", 5)
            end
            v:startEvent(102)
        end
    end
    if (csid == 102) then
        player:setPos(0, 0, 0, 0, 79)
    end
end
