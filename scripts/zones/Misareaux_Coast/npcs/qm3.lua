-----------------------------------
-- Area: Misareaux_Coast
-- NPC:  ??? (Spawn Ziphius)
-- !pos 102.5 -16 525 25
-----------------------------------

require("scripts/globals/npc_util")
local ID = require("scripts/zones/Misareaux_Coast/IDs")

function onTrade(player,npc,trade)
    local baited = npc:getLocalVar("[Ziphius]Bait Trap")

    -- Trade Slice of Carp
    if (npcUtil.tradeHas(trade, 16994) and baited == 0) then
        npc:setLocalVar("[Ziphius]Bait Trap", 1)
        player:confirmTrade()
        player:messageSpecial(ID.text.PUT_IN_TRAP, 16994)
    else
        player:messageSpecial(ID.text.NOTHING_HERE_YET)
    end
end
function onTrigger(player,npc)
    local baited = npc:getLocalVar("[Ziphius]Bait Trap")

    if VanadielHour() >= 22 or VanadielHour() < 4 then
        if (baited == 0) then
            player:messageSpecial(ID.text.APPEARS_TO_BE_TRAP)
        else
            player:messageSpecial(ID.text.NOTHING_HERE_YET)
        end
    elseif VanadielHour() >= 4 and VanadielHour() < 7 then
        if (baited == 1) then
            if (math.random(1,1000) <= 176) then
                SpawnMob(ID.mob.ZIPHIUS):updateClaim(player)
                GetMobByID(ID.mob.ZIPHIUS):setPos(npc:getXPos(),npc:getYPos(),npc:getZPos()-1)
                npc:setStatus(tpz.status.DISAPPEAR)
            else
                player:messageSpecial(ID.text.DID_NOT_CATCH_ANYTHING)
            end
            npc:setLocalVar("[Ziphius]Bait Trap", 0)
        else
            player:messageSpecial(ID.text.APPEARS_TO_BE_TRAP)
        end
    end
end

function onEventUpdate(player,csid,option)

end

function onEventFinish(player,csid,option)

end