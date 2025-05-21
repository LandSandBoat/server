-----------------------------------
-- Area: Qufim Island
--  NPC: ??? (qm3)
-- Mission: ACP - The Echo Awakens
-- !pos -120.342 -19.471 306.661 126
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade Seedspall's Lux, Luna, Astrum
    if
        player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.THE_ECHO_AWAKENS and
        npcUtil.tradeHas(trade, { 2740, 2741, 2742 })
    then
        player:startEvent(31)
    end
end

entity.onTrigger = function(player, npc)
    local missionACP        = player:getCurrentMission(xi.mission.log_id.ACP)
    local seedspallRosem    = player:hasKeyItem(xi.ki.SEEDSPALL_ROSEUM)
    local seedspallCaerulum = player:hasKeyItem(xi.ki.SEEDSPALL_CAERULUM)
    local seedspallViridis  = player:hasKeyItem(xi.ki.SEEDSPALL_VIRIDIS)
    -- local amberKey = player:hasKeyItem(xi.ki.AMBER_KEY)
    -- local lastAmber = player:getCharVar('LastAmberKey') -- When last Amber key was obtained
    local lastViridian = player:getCharVar('LastViridianKey') -- When last Viridian key was obtained

    if
        xi.settings.main.ENABLE_ACP == 1 and
        not player:hasKeyItem(xi.ki.AMBER_KEY)
    then
        if
            missionACP == xi.mission.id.acp.GATHERER_OF_LIGHT_I and
            seedspallRosem and
            seedspallCaerulum and
            seedspallViridis and
            os.time() > lastViridian
        then
            player:startEvent(32)
        elseif
            missionACP == xi.mission.id.acp.GATHERER_OF_LIGHT_II and
            player:getCharVar('SEED_MANDY') == 0
        then
            -- Spawn Seed mandragora's
            player:setCharVar('SEED_MANDY', 1) -- This will need moved into Seed mandies onDeath script later.
            player:printToPlayer('Confrontation Battles are not working yet.')
            -- xi.effect.CONFRONTATION for 30 min
        elseif
            missionACP == xi.mission.id.acp.GATHERER_OF_LIGHT_II and
            player:getCharVar('SEED_MANDY') == 1
        then
            -- change SEED_MANDY var number later when battle actually works (intended purpose is to track number of slain mandies).
            player:setCharVar('SEED_MANDY', 0)
            player:startEvent(34)
        -- elseif missionACP >= xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_I and not amberKey and os.time() > lastAmber and os.time() > lastViridian and SR and SC and SV and player:getCharVar('SEED_MANDY') == 0) then
            -- This is for repeats to get amber keys.
            -- Spawn Seed mandragora's with xi.effect.CONFRONTATION for 30 min
        -- elseif SR and SC and SV and missionACP >= xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_I and player:getCharVar('SEED_MANDY') == 1 then
            -- npcUtil.giveKeyItem(player, xi.ki.AMBER_KEY)
            -- player:setCharVar('LastAmberKey', getMidnight())
            -- player:setCharVar('SEED_MANDY', 0)
            -- player:delKeyItem(xi.ki.SEEDSPALL_ROSEUM)
            -- player:delKeyItem(xi.ki.SEEDSPALL_CAERULUM)
            -- player:delKeyItem(xi.ki.SEEDSPALL_VIRIDIS)
        else
            -- Todo: find retail message (if any) and text its ID
        end
    else
        -- Todo: find retail message (if any) and text its ID
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 31 then
        player:completeMission(xi.mission.log_id.ACP, xi.mission.id.acp.THE_ECHO_AWAKENS)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.GATHERER_OF_LIGHT_I)
        player:confirmTrade()
    elseif csid == 32 then
        player:completeMission(xi.mission.log_id.ACP, xi.mission.id.acp.GATHERER_OF_LIGHT_I)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.GATHERER_OF_LIGHT_II)
        player:delKeyItem(xi.ki.SEEDSPALL_ROSEUM)
        player:delKeyItem(xi.ki.SEEDSPALL_CAERULUM)
        player:delKeyItem(xi.ki.SEEDSPALL_VIRIDIS)
    elseif csid == 34 then
        player:completeMission(xi.mission.log_id.ACP, xi.mission.id.acp.GATHERER_OF_LIGHT_II)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_I)
    end
end

return entity
