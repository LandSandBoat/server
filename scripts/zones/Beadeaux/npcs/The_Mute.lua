-----------------------------------
-- Area: Beadeaux
--  NPC: ???
-- !pos -166.230 -1 -73.685 147
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local duration = math.random(600, 900)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_CURSE_COLLECTOR) == QUEST_ACCEPTED and player:getCharVar("cCollectSilence") == 0) then
        player:setCharVar("cCollectSilence", 1)
    end

    player:addStatusEffect(tpz.effect.SILENCE, 0, 0, duration)

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
