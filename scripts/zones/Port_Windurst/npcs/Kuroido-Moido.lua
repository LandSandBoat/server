-----------------------------------
-- Area: Port Windurst (240)
--  NPC: Kuriodo-Moido
-- Involved In Quest: Making Amends, Wonder Wands,
-- Starts and Finishes: Making Amens!, Orastery Woes
-- !pos -112.5 -4.2 102.9 240
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local makingAmends = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_AMENDS) --First quest in series
    local makingAmens = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_AMENS) --Second quest in series
    local wonderWands = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.WONDER_WANDS) --Third and final quest in series
    local pfame = player:getFameLevel(xi.fameArea.WINDURST)
    local needToZone = player:needToZone()

    if makingAmends == xi.questStatus.QUEST_ACCEPTED then -- MAKING AMENDS: During Quest
        player:startEvent(276)
    elseif
        makingAmends == xi.questStatus.QUEST_COMPLETED and
        makingAmens ~= xi.questStatus.QUEST_COMPLETED and
        wonderWands ~= xi.questStatus.QUEST_COMPLETED and
        needToZone
    then
        -- MAKING AMENDS: After Quest
        player:startEvent(279)
    elseif
        makingAmends == xi.questStatus.QUEST_COMPLETED and
        makingAmens == xi.questStatus.QUEST_AVAILABLE and
        (pfame >= 4 or
        needToZone)
    then
        player:startEvent(279) -- MAKING AMENDS: After Quest
    elseif makingAmens == xi.questStatus.QUEST_COMPLETED then
        if wonderWands == xi.questStatus.QUEST_ACCEPTED then -- During Wonder Wands dialogue
            player:startEvent(261)
        elseif wonderWands == xi.questStatus.QUEST_COMPLETED then -- Post Wonder Wands dialogue
            player:startEvent(266)
        end
    else
        local rand = math.random(1, 2)
        if rand == 1 then
            player:startEvent(225)   -- Standard Conversation
        else
            player:startEvent(226)   -- Standard Conversation
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
