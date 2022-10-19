-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Torino-Samarino
-- Involved in Quests: Tuning Out
-- !pos 105 -20 140 111
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local tuningOutProgress = player:getCharVar("TuningOut_Progress")

    -- QUEST: TUNING OUT
    if tuningOutProgress == 7 then
        player:startEvent(207) -- Ildy meets up with Rhinostery peers
    elseif tuningOutProgress == 8 then
        player:startEvent(208) -- Talks about Ildy being passionate about his work
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 207 then
        npcUtil.giveCurrency(player, "gil", 6000)
        player:setCharVar("TuningOut_Progress", 8)
    end
end

return entity
