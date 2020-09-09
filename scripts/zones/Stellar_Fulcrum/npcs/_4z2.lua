-----------------------------------
-- Area: Stellar Fulcrum
--  NPC: Qe'Lov Gate
-------------------------------------
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(32003)
    return 1
end

function onEventUpdate(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)
end

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    local pZone = player:getZoneID()

    if (csid == 32003 and option == 4) then
        if (player:getCharVar(tostring(pZone) .. "_Fight") == 100) then
            player:setCharVar("BCNM_Killed", 0)
            player:setCharVar("BCNM_Timer", 0)
        end
        player:setCharVar(tostring(pZone) .. "_Runaway", 1)
        player:delStatusEffect(tpz.effect.BATTLEFIELD)
        player:setCharVar(tostring(pZone) .. "_Runaway", 0)
    end

end
