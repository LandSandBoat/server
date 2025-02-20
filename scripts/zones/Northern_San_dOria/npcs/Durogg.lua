-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Durogg
-- Type: Past Event Watcher
-- !pos 15 0 -18 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Add-on Scenarios
    local addonScenarios = 0xFFFFFFFE
    if player:hasCompletedMission(xi.mission.log_id.AMK, xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP) then
        addonScenarios = addonScenarios - 2 -- Drenched! It Began with a Raindrop.
    end
-- *Need the correct csid
--    if player:hasCompletedMission(xi.mission.log_id.AMK, xi.mission.id.amk.HASTEN_IN_A_JAM_IN_JEUNO) then
--        addonScenarios = addonScenarios - 4 -- Hasten! In a Jam in Jeuno?
--    end

    -- Seekers of Adoulin
    local seekersOfAdoulin = 0xFFFFFFFE
-- *Need the correct csid
--    if player:hasCompletedMission(xi.mission.log_id.SOA, xi.mission.id.soa.RUMORS_FROM_THE_WEST) then
--        SeekersOfAdoulin = SeekersOfAdoulin - 2 -- Rumors from the West
--    end

    -- Determine if any cutscenes are available for the player.
    local gil = player:getGil()
    if
        addonScenarios == 0xFFFFFFFE and
        seekersOfAdoulin == 0xFFFFFFFE
    then -- Player has no cutscenes available to be viewed.
        gil = 0 -- Setting gil to a value less than 10(cost) will trigger the appropriate response from this npc.
    end

    player:startEvent(865, addonScenarios, seekersOfAdoulin, 0xFFFFFFFE, 0xFFFFFFFE, 0xFFFFFFFE, 0xFFFFFFFE, 10, gil) -- CSID, Missions, Fame, ?, ?, ?, ?, Cost, TotalGilPlayerHas
end

entity.onEventUpdate = function(player, csid, option, npc)
    if not player:delGil(10) then
        player:setLocalVar('Durogg_PlayCutscene', 2)  -- Cancel the cutscene.
        player:updateEvent(0)
    else
        player:setLocalVar('Durogg_PlayCutscene', 1)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if player:getLocalVar('Durogg_PlayCutscene') < 2 then
        if option == 1 then        -- Drenched! It Began with a Raindrop
            player:startEvent(30025, 0, 0, 0, 0, 0, 0, 231)
--        elseif option == 2 then        -- Hasten! In a Jam in Jeuno?
--            player:startEvent(CSID, 0, 0, 0, 0, 0, 0, 231)
--        elseif option == 33 then        -- Rumors from the West
--            player:startEvent(CSID)
        end
    end

    player:setLocalVar('Durogg_PlayCutscene', 0)
end

return entity
