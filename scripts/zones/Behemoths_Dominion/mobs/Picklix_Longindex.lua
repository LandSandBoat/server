-----------------------------------
-- Area: Behemoth's Dominion
--   NM: Picklix Longindex
-- Involved in Quest: The Talekeeper's Gift
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/quests")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    if player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_TALEKEEPER_S_GIFT) == QUEST_ACCEPTED then
        player:addCharVar("theTalekeepersGiftKilledNM", 1)
    end
end
