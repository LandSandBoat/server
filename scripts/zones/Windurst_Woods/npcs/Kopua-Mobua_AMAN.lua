-----------------------------------
-- Area: Windurst Woods
--  NPC: Kopua-Mobua A.M.A.N.
-- Type: Mentor Recruiter
-- !pos -23.134 1.749 -67.284 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local var = 0
    if player:getMentor() == false then
        if player:getMainLvl() >= 30 and player:getPlaytime() >= 648000 then
            var = 1
        end
    elseif player:getMentor() == true then
        var = 2
    end
    player:startEvent(10026, var)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10026 and option == 0 then
        player:setMentor(true)
    end
end

return entity
