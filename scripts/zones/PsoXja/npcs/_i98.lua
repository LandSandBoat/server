-----------------------------------
-- Area: Pso'Xja
--  NPC: Stone Gate
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR) or
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)
    then
        if player:getZPos() < 318 then
            player:startOptionalCutscene(69, { cs_option = 0, canSkip = true })
        else
            player:startOptionalCutscene(70, { cs_option = 0, canSkip = true })
        end
    else
        player:messageSpecial(ID.text.DOOR_LOCKED)
    end
end

return entity
