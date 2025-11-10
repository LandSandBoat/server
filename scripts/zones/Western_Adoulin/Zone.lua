-----------------------------------
-- Zone: Western Adoulin
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, 13, 0, 123.518, 28, 0, 173) -- Approaching Airship Docks
end

zoneObject.onZoneIn = function(player, prevZone)
    local heartwingsAndTheKindhearted = player:getCurrentMission(xi.mission.log_id.SOA) == xi.mission.id.soa.HEARTWINGS_AND_THE_KINDHEARTED

    if player:getCharVar('Raptor_Rapture_Status') == 2 then
        -- Resuming cutscene for Quest: 'Raptor Rapture', after Pagnelle warps you to Rala Waterways mid-CS, then back here.
        return 5056
    end

    if heartwingsAndTheKindhearted then
        return 2
    end

    return xi.moghouse.onMoghouseZoneEvent(player, prevZone)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 5056 then
        -- Successfully finished introduction CS event chain for Quest: 'Raptor Rapture'.
        player:setCharVar('Raptor_Rapture_Status', 3)

        if option == 1 then
            -- Starts Quest: 'Raptor Rapture'
            player:addQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.RAPTOR_RAPTURE)
            player:setCharVar('Raptor_Rapture_Status', 4)
        end
    elseif csid == 2 then
        player:completeMission(xi.mission.log_id.SOA, xi.mission.id.soa.HEARTWINGS_AND_THE_KINDHEARTED)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.PIONEER_REGISTRATION)
    end
end

return zoneObject
