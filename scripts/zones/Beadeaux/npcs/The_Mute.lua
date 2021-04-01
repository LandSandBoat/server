-----------------------------------
-- Area: Beadeaux
--  NPC: ???
-- !pos -166.230 -1 -73.685 147
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local duration = math.random(600, 900)

    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_CURSE_COLLECTOR) == QUEST_ACCEPTED and player:getCharVar("cCollectSilence") == 0) then
        player:setCharVar("cCollectSilence", 1)
    end

    player:addStatusEffect(xi.effect.SILENCE, 0, 0, duration)

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
