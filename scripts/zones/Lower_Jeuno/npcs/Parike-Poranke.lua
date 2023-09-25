-----------------------------------
-- Area: Lower Jeuno
--  NPC: Parike-Poranke
-- Type: Adventurer's Assistant, Food Remover, Brown Mage
-- !pos -33.161 -1 -61.303 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

--[[
    Notes:
    csid 10044 - the only CS initiated by this little guy
    param7 - controls which CS is played
        - 10000 - intro
        - 10001 - spiel about wanting to fix peoples food related issues
        - 10002 - traded greens with food on board
            - other params or update must drive the behavior of this CS
        - 10003 - traded with no food
]]

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, xi.items.BUNCH_OF_GYSAHL_GREENS) then
        player:confirmTrade()
        local param7 = 10003 -- controls what CS is shown to the player
        if
            player:hasStatusEffect(xi.effect.FOOD) or
            player:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
        then
            param7 = param7 - 1
        end

        player:startEvent(10044, 0, 0, 0, 0, 0, 0, 0, param7)
    end
end

entity.onTrigger = function(player, npc)
    local param7 = 10000 -- controls what CS is shown to the player
    if
        player:hasStatusEffect(xi.effect.FOOD) or
        player:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        param7 = param7 + 1
    end

    player:startEvent(10044, 0, 0, 0, 0, 0, 0, 0, param7)
end

entity.onEventUpdate = function(player, csid, option)
    -- an updateEvent with param0 set to 10007 will cause Parike-Poranke to stop the CS short and say:
        -- NPCSAY #9002 // Wait a minute...\x07My linkshell's ringing.\x07Let me get back to you after I take this call.<7F31>
        -- The situation where this should be triggered is currently unknown
        -- This causes the event CS to end and in the scneario where the player was diseased - they will not be cured.

    local param1 = 0 -- successes or failures

    if option == 10002 then -- Traded greens w/ food active
        param1 = GetServerVariable("Parike_DigestiveSkill") + 1
        SetServerVariable("Parike_DigestiveSkill", param1)
        player:delStatusEffect(xi.effect.FOOD)
        player:delStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    elseif option == 10003 then -- Traded greens w/o food active part 2
        param1 = GetServerVariable("Parike_ScienceSkill")
        player:delStatusEffect(xi.effect.DISEASE)
    elseif option == 10004 then -- Traded greens w/o food active part 1
        param1 = GetServerVariable("Parike_ScienceSkill") + 1
        SetServerVariable("Parike_ScienceSkill", param1)
        player:addStatusEffect(xi.effect.DISEASE, 1, 0, 300)
    end

    player:updateEvent(10006, param1)
end

entity.onEventFinish = function(player, csid, option)
    if option == 10008 then -- Title CS - Digestive
        player:addTitle(xi.title.BROWN_MAGE_GUINEA_PIG)
    elseif option == 10009 then -- Title CS - Science
        player:addTitle(xi.title.BROWN_MAGIC_BY_PRODUCT)
        -- The values on this flee effect is unknown - it is inferred from client text that a flee effect is bestowed
        player:addStatusEffect(xi.effect.FLEE, 100, 0, 180)
    end
end

return entity
