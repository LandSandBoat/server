-----------------------------------
-- Area: Lebros Cavern
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/items")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local assaultFood =
{
    [1] = 5142, -- Serving of Bison Steak
    [2] = 5166, -- Coeurl Sub
    [3] = 5207, -- Strip of Bison Jerky
    [4] = 4416, -- Bowl of Pea Soup
    [5] = 4356, -- Loaf of White Bread
}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    local message_offset = ID.text.RATIONS
    local progress = instance:getProgress()

    if player:getLocalVar("foodGiven") == 0 then
        player:setLocalVar("foodGiven", math.random(1,5))
    end

    local food = assaultFood[player:getLocalVar("foodGiven")]

    if not player:hasItem(food, xi.inventoryLocation.TEMPITEMS) then
        player:addTempItem(food)
        player:messageText(npc, ID.text.DEPENDING_ON)
        player:timer(3000, function(player) player:messageSpecial(ID.text.TEMP_ITEM, food) end)
        if progress > 5 and progress < 9 then
            message_offset = message_offset + 1
        elseif progress > 8 and progress < 10 then
            message_offset = message_offset + 2
        elseif progress == 11 then
            message_offset = message_offset + 3
        end
        player:timer(6000, function(player) player:showText(npc, message_offset) end)
    else
        player:messageText(npc, ID.text.HAVE_RATIONS)
        player:timer(3000, function(player) player:showText(npc, message_offset) end)
    end
end

return entity
