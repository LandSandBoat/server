-----------------------------------
-- Area: Lower Jeuno
--  NPC: Parike-Poranke
-- Type: Adventurer's Assistant, Food Remover, Brown Mage
-- !pos -33.161 -1 -61.303 245
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- 10002 - Traded greens with food on board.
    -- 10003 - Traded with no food.

    if npcUtil.tradeHasExactly(trade, xi.item.BUNCH_OF_GYSAHL_GREENS) then
        player:confirmTrade()

        local param7 = player:hasStatusEffect(xi.effect.FOOD) and 10002 or 10003

        player:startEvent(10044, 0, 0, 0, 0, 0, 0, 0, param7)
    end
end

entity.onTrigger = function(player, npc)
    -- 10000: Intro.
    -- 10001: Spiel about wanting to fix peoples food related issues.

    local param7 = player:hasStatusEffect(xi.effect.FOOD) and 10001 or 10000

    player:startEvent(10044, 0, 0, 0, 0, 0, 0, 0, param7)
end

entity.onEventUpdate = function(player, csid, option)
    -- An updateEvent with param1 set to 10007 will cause Parike-Poranke to stop the CS short and say: "Wait a minute...My linkshell's ringing.Let me get back to you after I take this call."
    -- This causes the event CS to end and in the scneario where the player was diseased - they will not be cured. The situation where this should be triggered is currently unknown.
    -- Does not appear to be related to Parike-Poranke's invlvement with LB 7 and LB 8.
    -- Does not appear to be related to spam trading Parike-Poranke.
    -- Otherwise, all updates provide param1 as 10006

    local npc = player:getEventTarget()
    if not npc then
        return
    end

    local param1 = 10006
    local param2 = 0 -- Total successes or failures

    -- Traded greens w/ food active
    if option == 10002 then
        param2 = npc:getLocalVar('Parike_DigestiveSkill') + 1
        npc:setLocalVar('Parike_DigestiveSkill', param2)
        player:delStatusEffect(xi.effect.FOOD)

    -- Traded greens w/o food active part 2
    elseif option == 10003 then
        param2 = npc:getLocalVar('Parike_ScienceSkill')
        player:delStatusEffect(xi.effect.DISEASE)

    -- Traded greens w/o food active part 1
    elseif option == 10004 then
        param2 = npc:getLocalVar('Parike_ScienceSkill') + 1
        npc:setLocalVar('Parike_ScienceSkill', param2)
        player:addStatusEffect(xi.effect.DISEASE, { power = 1, duration = 300, origin = player })
    end

    player:updateEvent(param1, param2)
end

entity.onEventFinish = function(player, csid, option)
    -- Note: These options occur at every 10,000 trades for each track.

    -- Title CS - Digestive
    if option == 10008 then
        player:addTitle(xi.title.BROWN_MAGE_GUINEA_PIG)
        player:addStatusEffect(xi.effect.RERAISE, { power = 3, duration = 3600, origin = player }) -- https://wiki.ffo.jp/html/12891.html claim a RR3 effect is bestowed.

    -- Title CS - Science
    elseif option == 10009 then
        player:addTitle(xi.title.BROWN_MAGIC_BY_PRODUCT)
        player:addStatusEffect(xi.effect.FLEE, { power = 10000, duration = 60, origin = player }) -- https://wiki.ffo.jp/html/16849.html claims 60s and faster than JA Flee.
    end
end

return entity
