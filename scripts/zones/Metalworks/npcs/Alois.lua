-----------------------------------
-- Area: Metalworks
--  NPC: Alois
-- Involved in Missions: Wading Beasts
-- !pos 96 -20 14 237
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("FadedPromises") == 4 then
        player:startEvent(805)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 805 then
        if
            npcUtil.completeQuest(
                player,
                xi.quest.log_id.BASTOK,
                xi.quest.id.bastok.FADED_PROMISES,
                { item = 17775, xi.title.ASSASSIN_REJECT, var = { "FadedPromises" }, fame = 10 }
            )
        then
            player:delKeyItem(xi.ki.DIARY_OF_MUKUNDA)
        end
    end
end

return entity
