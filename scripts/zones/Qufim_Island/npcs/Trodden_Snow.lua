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

function onTrade(player, npc, trade)
    -- Trade Enfeebling Kit
    if player:getCurrentMission(ASA) == tpz.mission.id.asa.THAT_WHICH_CURDLES_BLOOD then
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

function onTrigger(player, npc)
    --ASA 4 CS: Triggers With At Least 3 Counterseals.
    if player:getCurrentMission(ASA) == tpz.mission.id.asa.SUGAR_COATED_DIRECTIVE then
        local completedSeals =
            (player:hasKeyItem(tpz.ki.AMBER_COUNTERSEAL)    and 1 or 0) +
            (player:hasKeyItem(tpz.ki.AZURE_COUNTERSEAL)    and 1 or 0) +
            (player:hasKeyItem(tpz.ki.CERULEAN_COUNTERSEAL) and 1 or 0) +
            (player:hasKeyItem(tpz.ki.EMERALD_COUNTERSEAL)  and 1 or 0) +
            (player:hasKeyItem(tpz.ki.SCARLET_COUNTERSEAL)  and 1 or 0) +
            (player:hasKeyItem(tpz.ki.VIOLET_COUNTERSEAL)   and 1 or 0)

        if completedSeals >= 3 then
            player:setCharVar("ASA_Status", completedSeals)
            player:startEvent(45)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 44 then
        npcUtil.giveKeyItem(player, {
            tpz.ki.DOMINAS_SCARLET_SEAL,
            tpz.ki.DOMINAS_CERULEAN_SEAL,
            tpz.ki.DOMINAS_EMERALD_SEAL,
            tpz.ki.DOMINAS_AMBER_SEAL,
            tpz.ki.DOMINAS_VIOLET_SEAL,
            tpz.ki.DOMINAS_AZURE_SEAL
        })

        player:completeMission(tpz.mission.log_id.ASA, tpz.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
        player:addMission(tpz.mission.log_id.ASA, tpz.mission.id.asa.SUGAR_COATED_DIRECTIVE)

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
            player:addGil(GIL_RATE * 3000)
        elseif completedSeals == 4 then
            player:addGil(GIL_RATE * 10000)
        elseif completedSeals == 5 then
            player:addGil(GIL_RATE * 30000)
        elseif completedSeals == 6 then
            player:addGil(GIL_RATE * 50000)
        end

        -- Clean Up Remaining Key Items
        player:delKeyItem(tpz.ki.DOMINAS_SCARLET_SEAL)
        player:delKeyItem(tpz.ki.DOMINAS_CERULEAN_SEAL)
        player:delKeyItem(tpz.ki.DOMINAS_EMERALD_SEAL)
        player:delKeyItem(tpz.ki.DOMINAS_AMBER_SEAL)
        player:delKeyItem(tpz.ki.DOMINAS_VIOLET_SEAL)
        player:delKeyItem(tpz.ki.DOMINAS_AZURE_SEAL)

        player:delKeyItem(tpz.ki.SCARLET_COUNTERSEAL)
        player:delKeyItem(tpz.ki.CERULEAN_COUNTERSEAL)
        player:delKeyItem(tpz.ki.EMERALD_COUNTERSEAL)
        player:delKeyItem(tpz.ki.AMBER_COUNTERSEAL)
        player:delKeyItem(tpz.ki.VIOLET_COUNTERSEAL)
        player:delKeyItem(tpz.ki.AZURE_COUNTERSEAL)

        -- Advance Mission
        player:completeMission(tpz.mission.log_id.ASA, tpz.mission.id.asa.SUGAR_COATED_DIRECTIVE)
        player:addMission(tpz.mission.log_id.ASA, tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_I)
        player:setCharVar("ASA_Status", 0)
    end
end
