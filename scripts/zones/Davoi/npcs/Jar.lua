-----------------------------------
-- Area: Davoi
--  NPC: Jar
-- Involved in Quest: Test my Mettle
-- Notes: Used to obtain Power Sandals
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

local move = function(npc)
    local positions =
    {
        { -119.202, 4, 44.765 },
        { -95.542, 3.297, -50.745 },
        { -128.66, 4, -237.566 },
        { -36.727, 3.7471, -218.116 },
        { 58.426, -9.1595, -132.309 },
        { 25.152, 1.1248, -107.308 },
        { 58.939, -9.0408, -160.195 },
        { 204.125, 3.7826, -126.883 },
        { 171.651, -2.6630, -111.846 },
        { 185.165, -0.2327, -189.646 },
        { 232.036, 4, -241.122 },
        { 275.811, 4, -204.266 },
    }
    local newPosition = npcUtil.pickNewPosition(npc:getID(), positions, true)
    npcUtil.queueMove(npc, newPosition)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local testMyMettle = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TEST_MY_METTLE)

    if
        testMyMettle ~= QUEST_ACCEPTED or
        player:hasItem(xi.items.POWER_SANDALS)
    then
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        return
    end

    if player:getFreeSlotsCount() == 0 then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.POWER_SANDALS)
    else
        player:addItem(xi.items.POWER_SANDALS)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.POWER_SANDALS)
        move(npc)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

entity.onTimeTrigger = function(npc, triggerID)
    if os.time() > npc:getLocalVar('MoveTime') then
        move(npc)
        npc:setLocalVar('MoveTime', os.time() + math.random(300, 10800))
    end
end

return entity
