-----------------------------------
-- Area: Port Jeuno
--  NPC: ???
-- Finish Quest: Borghertz's Hands (AF Hands, Many job)
-- !pos -51 8 -4 246
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local hasGauntlets = player:hasKeyItem(tpz.ki.OLD_GAUNTLETS)
    local hasShadowFlames = player:hasKeyItem(tpz.ki.SHADOW_FLAMES)
    local borghertzCS = player:getCharVar("BorghertzCS")

    if hasGauntlets and not hasShadowFlames and borghertzCS == 1 then
        player:startEvent(20)
    elseif hasGauntlets and not hasShadowFlames and borghertzCS == 2 then
        player:startEvent(49)
    elseif hasGauntlets and hasShadowFlames then
        player:startEvent(48)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 20 and option == 1 then
        player:setCharVar("BorghertzCS", 2)
    elseif csid == 48 then
        local questJob = player:getCharVar("BorghertzAlreadyActiveWithJob")
        local quest = tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS + questJob - 1
        local reward = 13960 + questJob

        if
            npcUtil.completeQuest(player, JEUNO, quest, {
                item = reward,
                var = {"BorghertzCS", "BorghertzAlreadyActiveWithJob"},
            })
        then
            player:delKeyItem(tpz.ki.OLD_GAUNTLETS)
            player:delKeyItem(tpz.ki.SHADOW_FLAMES)
        end
    end
end

return entity
