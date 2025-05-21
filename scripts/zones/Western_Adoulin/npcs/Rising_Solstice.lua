-----------------------------------
-- Area: Western Adoulin
--  NPC: Rising Solstice
-- Starts, Involved With, and Finishes Quest: 'A Certain Substitute Patrolman'
-- !pos -154 4 -29 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local adoulinMission = player:getCurrentMission(xi.mission.log_id.SOA)

    if
        adoulinMission >= xi.mission.id.soa.BEAUTY_AND_THE_BEAST and
        adoulinMission <= xi.mission.id.soa.SALVATION
    then
        -- Speech while Arciela is 'kidnapped'
        player:startEvent(150)
    end
end

return entity
