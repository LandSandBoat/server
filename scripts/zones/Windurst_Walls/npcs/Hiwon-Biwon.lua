-----------------------------------
-- Area: Windurst Walls
--  NPC: Hiwon-Biwon
-- Involved In Quest: Making Headlines, Curses, Foiled...Again!?
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local makingHeadlines = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_HEADLINES)
    local cursesFoiledAgain1 = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CURSES_FOILED_AGAIN_1)

    -- Making Headlines
    if makingHeadlines == QUEST_ACCEPTED then
        -- bitmask of progress: 0 = Kyume-Romeh, 1 = Yuyuju, 2 = Hiwom-Gomoi, 3 = Umumu, 4 = Mahogany Door
        local prog = player:getCharVar("QuestMakingHeadlines_var")

        if not utils.mask.getBit(prog, 2) then
            if cursesFoiledAgain1 == QUEST_ACCEPTED then
                if math.random(1, 2) == 1 then
                    player:startEvent(283) -- Give scoop while sick
                else
                    player:startEvent(284) -- Give scoop while sick
                end
            else
                player:startEvent(281) -- Give scoop
            end
        else
            player:startEvent(282) -- "Getting back to the maater at hand-wand..."
        end

    -- default dialog
    else
        local rand = math.random(1, 5)

        if rand == 1 then
            player:startEvent(305)
        elseif rand == 2 then
            player:startEvent(306)
        elseif rand == 3 then
            player:startEvent(168)
        elseif rand == 4 then
            player:startEvent(170)
        elseif rand == 5 then
            player:startEvent(169)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- Making Headlines
    if csid == 281 or csid == 283 or csid == 284 then
        npcUtil.giveKeyItem(player, xi.ki.WINDURST_WALLS_SCOOP)
        player:setCharVar("QuestMakingHeadlines_var", utils.mask.setBit(player:getCharVar("QuestMakingHeadlines_var"), 2, true))
    end
end

return entity
