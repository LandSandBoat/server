-----------------------------------
-- Area: Lower Jeuno
--  NPC: Nantoto
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/era_npc")
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.eraNpc.giveInstantWarpScroll(player, npc) then
        return
    end

    if player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.CAVERNOUS_MAWS) then
        player:printToPlayer("Trade me 1k gil to teleport to the Vunkerl Inlet (S) camp.", xi.msg.channel.SAY, "Nantoto")
    else
        player:printToPlayer("You have not time traveled yet, so I don't think you know how to get back...", xi.msg.channel.SAY, "Nantoto")
    end
end

entity.onTrade = function(player,npc,trade)
    if trade:getGil() == 1000 then
        if player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.CAVERNOUS_MAWS) then
            player:confirmTrade()
            player:setPos(-18, -40, 306, 122, xi.zone.VUNKERL_INLET_S)
        else
            player:printToPlayer("You have not time traveled yet, so I don't think you know how to get back...", xi.msg.channel.SAY, "Nantoto")
        end
    end
end

return entity
