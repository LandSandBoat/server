-----------------------------------
-- Area: Upper Jeuno
--  NPC: Mapitoto
-- Type: Full Speed Ahead Mount NPC
-- !pos -54.310 8.200 85.940 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/chocobo")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------

function onTrade(player,npc,trade)
    if npcUtil.tradeHasExactly(trade, 15533) then player:startEvent(10227, 15533, tpz.ki.TRAINERS_WHISTLE, tpz.mount.CHOCOBO) player:setCharVar("FullSpeedAheadReward", tpz.ki.CHOCOBO_COMPANION)

    elseif npcUtil.tradeHasExactly(trade, 10050) then player:startEvent(10227, 10050, tpz.ki.TRAINERS_WHISTLE, tpz.mount.TIGER - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.TIGER_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10051) then player:startEvent(10227, 10051, tpz.ki.TRAINERS_WHISTLE, tpz.mount.CRAB - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.CRAB_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10052) then player:startEvent(10227, 10052, tpz.ki.TRAINERS_WHISTLE, tpz.mount.RED_CRAB - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.RED_CRAB_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10053) then player:startEvent(10227, 10053, tpz.ki.TRAINERS_WHISTLE, tpz.mount.BOMB - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.BOMB_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10054) then player:startEvent(10227, 10054, tpz.ki.TRAINERS_WHISTLE, tpz.mount.RAM - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.RAM_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10055) then player:startEvent(10227, 10055, tpz.ki.TRAINERS_WHISTLE, tpz.mount.MORBOL - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.MORBOL_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10056) then player:startEvent(10227, 10056, tpz.ki.TRAINERS_WHISTLE, tpz.mount.CRAWLER - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.CRAWLER_COMPANION)

    -- Crash?
    -- elseif npcUtil.tradeHasExactly(trade, 10057) then player:startEvent(10227, 10057, tpz.ki.TRAINERS_WHISTLE, tpz.mount.FENRIR - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.FENRIR_COMPANION)

    elseif npcUtil.tradeHasExactly(trade, 10058) then player:startEvent(10227, 10058, tpz.ki.TRAINERS_WHISTLE, tpz.mount.BEETLE - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.BEETLE_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10059) then player:startEvent(10227, 10059, tpz.ki.TRAINERS_WHISTLE, tpz.mount.MOOGLE - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.MOOGLE_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10060) then player:startEvent(10227, 10060, tpz.ki.TRAINERS_WHISTLE, tpz.mount.MAGIC_POT - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.MAGIC_POT_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10061) then player:startEvent(10227, 10061, tpz.ki.TRAINERS_WHISTLE, tpz.mount.TULFAIRE - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.TULFAIRE_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10062) then player:startEvent(10227, 10062, tpz.ki.TRAINERS_WHISTLE, tpz.mount.WARMACHINE - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.WARMACHINE_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10063) then player:startEvent(10227, 10063, tpz.ki.TRAINERS_WHISTLE, tpz.mount.XZOMIT - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.XZOMIT_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10064) then player:startEvent(10227, 10064, tpz.ki.TRAINERS_WHISTLE, tpz.mount.HIPPOGRYPH - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.HIPPOGRYPH_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10065) then player:startEvent(10227, 10065, tpz.ki.TRAINERS_WHISTLE, tpz.mount.SPECTRAL_CHAIR - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.SPECTRAL_CHAIR_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10066) then player:startEvent(10227, 10066, tpz.ki.TRAINERS_WHISTLE, tpz.mount.SPHEROID - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.SPHEROID_COMPANION)

    -- Omega has own quest and cs (10229)
    -- elseif npcUtil.tradeHasExactly(trade, 10067) then player:startEvent(10227, 10067, tpz.ki.TRAINERS_WHISTLE, tpz.mount.OMEGA - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.OMEGA_COMPANION)

    elseif npcUtil.tradeHasExactly(trade, 10068) then player:startEvent(10227, 10068, tpz.ki.TRAINERS_WHISTLE, tpz.mount.COEURL - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.COEURL_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10069) then player:startEvent(10227, 10069, tpz.ki.TRAINERS_WHISTLE, tpz.mount.GOOBBUE - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.GOOBBUE_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10070) then player:startEvent(10227, 10070, tpz.ki.TRAINERS_WHISTLE, tpz.mount.RAAZ - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.RAAZ_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10071) then player:startEvent(10227, 10071, tpz.ki.TRAINERS_WHISTLE, tpz.mount.LEVITUS - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.LEVITUS_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10072) then player:startEvent(10227, 10072, tpz.ki.TRAINERS_WHISTLE, tpz.mount.ADAMANTOISE - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.ADAMANTOISE_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10073) then player:startEvent(10227, 10073, tpz.ki.TRAINERS_WHISTLE, tpz.mount.DHAMEL - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.DHAMEL_COMPANION)
    elseif npcUtil.tradeHasExactly(trade, 10074) then player:startEvent(10227, 10074, tpz.ki.TRAINERS_WHISTLE, tpz.mount.DOLL - 1) player:setCharVar("FullSpeedAheadReward", tpz.ki.DOLL_COMPANION)
    end
end

function onTrigger(player,npc)
    -- Minigame complete
    local fullSpeedAheadStatus = player:getCharVar("[QUEST]FullSpeedAhead")
    local hasTrainersWhistle = player:hasKeyItem(tpz.ki.TRAINERS_WHISTLE)

    if hasTrainersWhistle then
        player:startEvent(10226)
    elseif
      player:hasKeyItem(tpz.ki.CHOCOBO_LICENSE) and
      player:getMainLvl() >= 20 and
      player:hasKeyItem(tpz.ki.MAP_OF_THE_JEUNO_AREA)
    then
        player:startEvent(10223, 0, 0, 4)
    elseif fullSpeedAheadStatus == 1 then
        player:startEvent(10225, tpz.ki.TRAINERS_WHISTLE)
    else
        player:startEvent(10222)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 10223 and option == 1 then
        player:setPos(475, 8.8, -159, 128, 105)
    elseif csid == 10225 then
        -- Complete quest
        npcUtil.giveKeyItem(player, tpz.ki.TRAINERS_WHISTLE)
        npcUtil.giveKeyItem(player, tpz.ki.RAPTOR_COMPANION)
    elseif csid == 10227 then
        local rewardKI = player:getCharVar("FullSpeedAheadReward")
        if rewardKI ~= tpz.ki.CHOCOBO_COMPANION then
            player:confirmTrade()
        end
        player:setCharVar("FullSpeedAheadReward", 0)
        npcUtil.giveKeyItem(player, rewardKI)
    end
end
