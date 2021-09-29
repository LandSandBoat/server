-----------------------------------
-- Area: Davoi
--  Mob: Bilopdop
-- Involved in Quest: The First Meeting
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    local theFirstMeeting = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING)
    local martialArtsScroll = player:hasKeyItem(xi.ki.SAN_DORIAN_MARTIAL_ARTS_SCROLL)

    if (theFirstMeeting == QUEST_ACCEPTED and martialArtsScroll == false) then
        player:addCharVar("theFirstMeetingKilledNM", 1)
    end
end

return entity
