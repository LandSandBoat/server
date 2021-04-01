-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Ubume
-- Involved in Quest: Yomi Okuri
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI) == QUEST_ACCEPTED and player:getCharVar("yomiOkuriCS") <= 3 then
        player:setCharVar("yomiOkuriKilledNM", 1)
    end
end

return entity
