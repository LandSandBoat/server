-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Emeige A.M.A.N.
-- Type: Mentor Recruiter
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local var = 0
    if (player:getMentor() == false) then
        if (player:getMainLvl() >= 30 and player:getPlaytime() >= 648000) then
            var = 1
        end
    elseif (player:getMentor() == true) then
        var = 2
    end
    player:startEvent(739, var)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 739 and option == 0) then
        player:setMentor(true)
    end
end
