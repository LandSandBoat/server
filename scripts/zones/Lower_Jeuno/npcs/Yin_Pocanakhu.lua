-----------------------------------
-- Area: Lower Jeuno
--  NPC: Yin Pocanakhu
-- Involved in Quest: Borghertz's Hands (1st quest only)
-- !pos 35 4 -43 245
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("BorghertzHandsFirstTime") == 2 then
        player:startEvent(220)
    else
        player:startEvent(209)
    end
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 220 and player:delGil(1000) then
        player:setLocalVar("paidYin", 1)
        player:updateEvent(1)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 220 and player:getLocalVar("paidYin") == 1 then
        player:setLocalVar("paidYin", 0)
        player:setCharVar("BorghertzHandsFirstTime", 0)
        player:setCharVar("BorghertzCS", 1)
    end
end

return entity
