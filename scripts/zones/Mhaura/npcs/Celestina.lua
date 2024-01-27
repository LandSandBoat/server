-----------------------------------
-- Area: Mhaura
--  NPC: Celestina
-- Finish Quest: The Sand Charm
-- Involved in Quest: Riding on the Clouds
-- Guild Merchant NPC: Goldsmithing Guild
-- !pos -37.624 -16.050 75.681 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM) == QUEST_ACCEPTED then
        if npcUtil.tradeHasExactly(trade, xi.item.SAND_CHARM) then
            player:startEvent(127, 0, xi.item.SAND_CHARM) -- Finish quest 'The Sand Charm'
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('theSandCharmVar') == 3 then
        player:startEvent(126, xi.item.SAND_CHARM) -- During quest 'The Sand Charm' - 3rd dialog
    else
        local guildSkillId = xi.skill.GOLDSMITHING
        local stock = xi.shop.generalGuildStock[guildSkillId]
        xi.shop.generalGuild(player, stock, guildSkillId)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 126 and option == 70 then
        player:setCharVar('theSandCharmVar', 4)
    elseif csid == 127 then
        player:confirmTrade()
        npcUtil.completeQuest(player, xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM, {
            ki = xi.ki.MAP_OF_BOSTAUNIEUX_OUBLIETTE,
            fameArea = xi.quest.fame_area.WINDURST,
            var = 'theSandCharmVar'
        })
        player:setCharVar('SmallDialogByBlandine', 1)
    end
end

return entity
