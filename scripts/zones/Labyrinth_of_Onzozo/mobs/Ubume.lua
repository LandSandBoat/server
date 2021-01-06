-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Ubume
-- Involved in Quest: Yomi Okuri
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    if player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.YOMI_OKURI) == QUEST_ACCEPTED and player:getCharVar("yomiOkuriCS") <= 3 then
        player:setCharVar("yomiOkuriKilledNM", 1)
    end
end

return entity
