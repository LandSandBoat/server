-----------------------------------
-- Area: Lebros Cavern
-- npc: Imperial Stormer
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
local entity = {}
-----------------------------------

local rationsTable =
{
    {
        itemID = xi.item.SEAFOOD_STEWPOT, pointValue = 7
    },
    {
        itemID = xi.item.BISON_STEAK, pointValue = 5
    },
    {
        itemID = xi.item.COEURL_SUB, pointValue = 4
    },
    {
        itemID = xi.item.BISON_JERKY, pointValue = 3
    },
    {
        itemID = xi.item.BOWL_OF_PEA_SOUP, pointValue = 2
    },
    {
        itemID = xi.item.LOAF_OF_WHITE_BREAD, pointValue = 1
    },
}

local function foodPoints(player, npc)
    for _, rations in pairs(rationsTable) do
        if player:hasItem(rations.itemID, xi.inventoryLocation.TEMPITEMS) then
            npc:setLocalVar('foodEaten', npc:getLocalVar('foodEaten') + rations.pointValue)
            player:setLocalVar('foodGiven', 0)
            player:delItem(rations.itemID, 1, xi.inventoryLocation.TEMPITEMS)
            return rations.pointValue
        end
    end

    return 0
end

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    local points = foodPoints(player, npc)

    if points > 0 and points < 6 then
        if
            npc:getLocalVar('foodEaten') >= npc:getLocalVar('Hunger') and
            npc:getLocalVar('complete') == 0
        then
            instance:setProgress(instance:getProgress() + 1)
            npc:setLocalVar('complete', 1)
            player:showText(npc, ID.text.FULL_HUNGRY)
        elseif npc:getLocalVar('complete') == 1 then
            player:showText(npc, ID.text.FULL_FED)
        else
            player:showText(npc, ID.text.STILL_HUNGRY_FED)
        end
    elseif points == 7 then -- Seafood Stewpot (35' AoE)
        for i, npcID in ipairs(ID.npc.IMPERIAL_STORMER) do
            local stormer = GetNPCByID(npcID, instance)

            if stormer then
                if player:checkDistance(stormer) <= 35 then
                    if stormer:getID() ~= npc:getID() then
                        stormer:setLocalVar('foodEaten', stormer:getLocalVar('foodEaten') + 7)
                    end

                    if
                        stormer:getLocalVar('foodEaten') >= stormer:getLocalVar('Hunger') and
                        stormer:getLocalVar('complete') == 0
                    then
                        instance:setProgress(instance:getProgress() + 1)
                        stormer:setLocalVar('complete', 1)
                        player:showText(stormer, ID.text.FULL_HUNGRY)
                    elseif stormer:getLocalVar('complete') == 1 then
                        player:showText(stormer, ID.text.FULL_FED)
                    else
                        player:showText(stormer, ID.text.STILL_HUNGRY_FED)
                    end
                end
            end
        end
    else
        if npc:getLocalVar('foodEaten') >= npc:getLocalVar('Hunger') then
            player:showText(npc, ID.text.FULL_HUNGRY)
        else
            player:showText(npc, ID.text.STILL_HUNGRY_TRIGGER)
        end
    end
end

return entity
