-----------------------------------
-- Area: Davoi
--  NPC: ??? (qm2)
-- Involved in Quest: Tea with a Tonberry
-- !pos 189.201 1.2553 -383.921 149
-----------------------------------
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCharVar('TEA_WITH_A_TONBERRY_PROG') == 3 then
        if npcUtil.tradeHas(trade, 1682) and not GetMobByID(ID.mob.HEMATIC_CYST):isSpawned() then
            -- Treasury Gold spawns Hematic Cyst
            SpawnMob(ID.mob.HEMATIC_CYST):updateClaim(player)
            player:confirmTrade()
            player:messageText(npc, ID.text.UNDER_ATTACK, false)
        end
    end
end

entity.onTrigger = function(player, npc)
    local teaProg = player:getCharVar('TEA_WITH_A_TONBERRY_PROG')

    if teaProg == 3 then
        player:messageSpecial(ID.text.WHERE_THE_TONBERRY_TOLD_YOU, 0, 1682)
    elseif teaProg == 4 then
        player:startEvent(126, 149, 1682)
    elseif teaProg == 5 then
        player:messageText(npc, ID.text.NOTHING_TO_DO, false)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 126 then
        player:setCharVar('TEA_WITH_A_TONBERRY_PROG', 5)
    end
end

return entity
