-----------------------------------
-- Area: Caedarva Mire
--   NM: Moshdahn
-- Note: Spawned during quest: "Not Meant to Be"
-----------------------------------
mixins = {require("scripts/mixins/families/qutrub")}
require("scripts/globals/quests")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    if player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.NOT_MEANT_TO_BE) == QUEST_ACCEPTED and player:getCharVar("notmeanttobeCS") == 3 and player:getCharVar("notmeanttobeMoshdahnKilled") < 1 then
        player:setCharVar("notmeanttobeMoshdahnKilled", 1)
    end
end
