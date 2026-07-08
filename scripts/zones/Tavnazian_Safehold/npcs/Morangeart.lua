-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Morangeart
-- Type: ENM Quest Activator
-- !pos -74.308 -24.782 -28.475 26
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local monarchBeardCD = player:getCharVar('[ENM]MonarchBeard')

    if player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.AN_ETERNAL_MELODY then
        if player:hasKeyItem(xi.ki.MONARCH_BEARD) then
            player:startEvent(520)
        else
            if monarchBeardCD < VanadielTime() then
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
    if csid == 521 then
        npcUtil.giveKeyItem(player, xi.ki.MONARCH_BEARD)
        player:setCharVar('[ENM]MonarchBeard', VanadielTime() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
    end
end

return entity
