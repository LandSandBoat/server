-----------------------------------
-- Area: Qufim Island
--  NPC: Trodden Snow
-- Mission: ASA - THAT_WHICH_CURDLES_BLOOD
-- Mission: ASA - SUGAR_COATED_DIRECTIVE
-- !pos -19 -17 104 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade Enfeebling Kit
    if player:getCurrentMission(ASA) == xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD then
        local item = 0
        local asaStatus = player:getCharVar("ASA_Status")

        -- TODO: Other Enfeebling Kits
        if asaStatus == 0 then
            item = 2779
        else
            printf("Error: Unknown ASA Status Encountered <%u>", asaStatus)
        end

        if npcUtil.tradeHas(trade, item) then
            player:startEvent(44)
        end
    end
end

entity.onTrigger = function(player, npc)
    --ASA 4 CS: Triggers With At Least 3 Counterseals.
    if player:getCurrentMission(ASA) == xi.mission.id.asa.SUGAR_COATED_DIRECTIVE then
        local completedSeals =
            (player:hasKeyItem(xi.ki.AMBER_COUNTERSEAL)    and 1 or 0) +
            (player:hasKeyItem(xi.ki.AZURE_COUNTERSEAL)    and 1 or 0) +
            (player:hasKeyItem(xi.ki.CERULEAN_COUNTERSEAL) and 1 or 0) +
            (player:hasKeyItem(xi.ki.EMERALD_COUNTERSEAL)  and 1 or 0) +
            (player:hasKeyItem(xi.ki.SCARLET_COUNTERSEAL)  and 1 or 0) +
            (player:hasKeyItem(xi.ki.VIOLET_COUNTERSEAL)   and 1 or 0)

        if completedSeals >= 3 then
            player:setCharVar("ASA_Status", completedSeals)
            player:startEvent(45)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 44 then
        npcUtil.giveKeyItem(player, {
            xi.ki.DOMINAS_SCARLET_SEAL,
            xi.ki.DOMINAS_CERULEAN_SEAL,
            xi.ki.DOMINAS_EMERALD_SEAL,
            xi.ki.DOMINAS_AMBER_SEAL,
            xi.ki.DOMINAS_VIOLET_SEAL,
            xi.ki.DOMINAS_AZURE_SEAL
        })

        player:completeMission(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_DIRECTIVE)

        player:setCharVar("ASA_Status", 0)
        player:setCharVar("ASA4_Amber", "0")
        player:setCharVar("ASA4_Azure", "0")
        player:setCharVar("ASA4_Cerulean", "0")
        player:setCharVar("ASA4_Emerald", "0")
        player:setCharVar("ASA4_Scarlet", "0")
        player:setCharVar("ASA4_Violet", "0")

        player:confirmTrade()
    elseif csid == 45 then
        local completedSeals = player:getCharVar("ASA_Status")

        -- Calculate Reward
        if completedSeals == 3 then
            player:addGil(xi.settings.GIL_RATE * 3000)
        elseif completedSeals == 4 then
            player:addGil(xi.settings.GIL_RATE * 10000)
        elseif completedSeals == 5 then
            player:addGil(xi.settings.GIL_RATE * 30000)
        elseif completedSeals == 6 then
            player:addGil(xi.settings.GIL_RATE * 50000)
        end

        -- Clean Up Remaining Key Items
        player:delKeyItem(xi.ki.DOMINAS_SCARLET_SEAL)
        player:delKeyItem(xi.ki.DOMINAS_CERULEAN_SEAL)
        player:delKeyItem(xi.ki.DOMINAS_EMERALD_SEAL)
        player:delKeyItem(xi.ki.DOMINAS_AMBER_SEAL)
        player:delKeyItem(xi.ki.DOMINAS_VIOLET_SEAL)
        player:delKeyItem(xi.ki.DOMINAS_AZURE_SEAL)

        player:delKeyItem(xi.ki.SCARLET_COUNTERSEAL)
        player:delKeyItem(xi.ki.CERULEAN_COUNTERSEAL)
        player:delKeyItem(xi.ki.EMERALD_COUNTERSEAL)
        player:delKeyItem(xi.ki.AMBER_COUNTERSEAL)
        player:delKeyItem(xi.ki.VIOLET_COUNTERSEAL)
        player:delKeyItem(xi.ki.AZURE_COUNTERSEAL)

        -- Advance Mission
        player:completeMission(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_DIRECTIVE)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_I)
        player:setCharVar("ASA_Status", 0)
    end
end

return entity
