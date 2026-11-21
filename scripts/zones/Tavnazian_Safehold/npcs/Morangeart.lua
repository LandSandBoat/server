-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Morangeart
-- Type: ENM Quest Activator
-- !pos -74.308 -24.782 -28.475 26
-----------------------------------
require('scripts/globals/enm')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local monarchBeardCD = player:getCharVar(xi.enm.monarchBeardCooldownVar)

    if player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.AN_ETERNAL_MELODY then
        if player:hasKeyItem(xi.keyItem.MONARCH_BEARD) then
            player:startEvent(520)
        else
            if monarchBeardCD <= VanadielTime() then
                player:startEvent(521)
            else
                player:startEvent(522, monarchBeardCD)
            end
        end
    else
        player:startEvent(523)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 521 and
        player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.AN_ETERNAL_MELODY and
        not player:hasKeyItem(xi.keyItem.MONARCH_BEARD) and
        player:getCharVar(xi.enm.monarchBeardCooldownVar) <= VanadielTime()
    then
        npcUtil.giveKeyItem(player, xi.keyItem.MONARCH_BEARD)
    end
end

return entity
