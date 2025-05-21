-----------------------------------
-- Area: Windurst Woods
--  NPC: Rakoh Buuma
-- Starts Windurst Missions
-- !pos 106 -5 -23 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getNation() ~= xi.nation.WINDURST then
        player:startEvent(105) -- for other nation
    else
        local currentMission = player:getCurrentMission(xi.mission.log_id.WINDURST)

        if currentMission ~= xi.mission.id.windurst.NONE then
            player:startEvent(112) -- Have mission already activated
        else
            -- NPC dialog changes when starting 3-2 according to whether it's the first time or being repeated
            local param3 = player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.WRITTEN_IN_THE_STARS) and 1 or 0
            local flagMission, repeatMission = xi.mission.getMissionMask(player)

            player:startEvent(114, flagMission, 0, param3, 0, xi.ki.STAR_CRESTED_SUMMONS_1, repeatMission)
        end
    end
end

return entity
