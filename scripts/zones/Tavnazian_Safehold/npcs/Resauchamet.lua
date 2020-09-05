-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Resauchamet
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local kill=player:getCharVar("FOMOR_HATE")
    local n=0
    if (kill< 8) then n=0
    elseif (kill< 15) then n=1
    elseif (kill< 50) then n=2
    elseif (kill>= 50) then n=3
    end
    player:startEvent(355, n)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
