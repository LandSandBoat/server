-----------------------------------
-- Area: The Boyahda Tree
-- NPC: qm2 (???)
-- Involved in Quest: Searching for the Right Words
-- !pos 34.651 -20.183 -61.647 153
-----------------------------------
local ID = require("scripts/zones/The_Boyahda_Tree/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Notes: does ??? depop when Agas is spawned?
    -- current implementation: when Agas is active, triggering ??? will result in detarget

    local zoneHour = VanadielHour()
    local zoneMinute = VanadielMinute()
    local correctTime = zoneHour >= 19 or zoneHour < 4 or (zoneHour == 4 and zoneMinute == 0)

    if not GetMobByID(ID.mob.AGAS):isSpawned() then
        if player:hasKeyItem(tpz.ki.MOONDROP) then
            player:messageSpecial(ID.text.CAN_SEE_SKY)

        elseif player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS) == QUEST_ACCEPTED then

            if IsMoonNew() or not correctTime then
                player:messageSpecial(ID.text.CANNOT_SEE_MOON)

            elseif player:getCharVar("Searching_AgasKilled") == 1 then
                player:startEvent(14)

            else
                player:messageSpecial(ID.text.SOMETHING_NOT_RIGHT)
                SpawnMob(ID.mob.AGAS):updateClaim(player) -- missing repop timer for Agas due to errors with SpawnMob
            end

        else
            player:messageSpecial(ID.text.CAN_SEE_SKY)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 14 then
        player:addKeyItem(tpz.ki.MOONDROP)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MOONDROP)
        player:setCharVar("Searching_AgasKilled", 0)
    end
end
