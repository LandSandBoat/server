-----------------------------------
-- Area: Lebros Cavern
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
local entity = {}
-----------------------------------

local rationsTable =
{
    xi.item.BISON_STEAK,
    xi.item.COEURL_SUB,
    xi.item.BISON_JERKY,
    xi.item.BOWL_OF_PEA_SOUP,
    xi.item.LOAF_OF_WHITE_BREAD,
    xi.item.SEAFOOD_STEWPOT,
}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    local messageOffset = ID.text.RATIONS
    local progress = instance:getProgress()

    if player:getLocalVar('foodGiven') == 0 then
        player:setLocalVar('foodGiven', math.random(1, 6))
    end

    local food = rationsTable[player:getLocalVar('foodGiven')]

    if not player:hasItem(food, xi.inventoryLocation.TEMPITEMS) then
        player:addTempItem(food)
        player:messageText(npc, ID.text.DEPENDING_ON)
        if food == xi.item.SEAFOOD_STEWPOT then
            player:timer(2 * 1000, function(playerArg)
                playerArg:showText(entity, ID.text.STEWPOT_TALK)
            end)
        end

        player:timer(3 * 1000, function(playerArg)
            player:messageSpecial(ID.text.TEMP_ITEM, food)
        end)

        if progress > 5 and progress < 9 then
            messageOffset = messageOffset + 1
        elseif progress > 8 and progress < 10 then
            messageOffset = messageOffset + 2
        elseif progress == 11 then
            messageOffset = messageOffset + 3
        end

        player:timer(6 * 1000, function(playerArg)
            player:showText(entity, messageOffset)
        end)
    else
        player:messageText(npc, ID.text.HAVE_RATIONS)
        player:timer(3 * 1000, function(playerArg)
            playerArg:showText(entity, messageOffset)
        end)
    end
end

return entity
