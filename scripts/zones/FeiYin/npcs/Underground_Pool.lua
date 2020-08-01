-----------------------------------
-- Area: FeiYin
--  NPC: Underground Pool
-- Involved In Quest: Scattered into Shadow
-- Offset 0 (H-5) !pos 7 0 247 204
-- Offset 1 (F-5) !pos -168 0 247 204
-- Offset 2 (H-8) !pos 7 0 32 204
-----------------------------------
local ID = require("scripts/zones/FeiYin/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local offset = npc:getID() - ID.npc.UNDERGROUND_POOL_OFFSET

    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SCATTERED_INTO_SHADOW) == QUEST_ACCEPTED then
        if offset == 0 and player:hasKeyItem(tpz.ki.AQUAFLORA2) then
            player:startEvent(20)
        elseif offset == 1 and player:getCharVar("DabotzKilled") == 1 then
            player:startEvent(18)
        elseif offset == 1 and player:hasKeyItem(tpz.ki.AQUAFLORA3) and not GetMobByID(ID.mob.DABOTZS_GHOST):isSpawned() then
            SpawnMob(ID.mob.DABOTZS_GHOST):updateClaim(player)
        elseif offset == 2 and player:hasKeyItem(tpz.ki.AQUAFLORA1) then
            player:startEvent(21)
        else
            player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 18 then
        player:delKeyItem(tpz.ki.AQUAFLORA3)
        player:setCharVar("DabotzKilled", 0)
    elseif csid == 21 then
        player:delKeyItem(tpz.ki.AQUAFLORA1)
    elseif csid == 20 then
        player:delKeyItem(tpz.ki.AQUAFLORA2)
    end
end
