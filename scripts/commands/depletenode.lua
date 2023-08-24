-----------------------------------
-- func: depletenode
-- desc: depletes a HELM node and prints the results
-----------------------------------
require("scripts/globals/helm")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local target = player:getCursorTarget()
    local targetName = target:getName()
    local helmTypes =
    {
        ["Harvesting_Point"] = xi.helm.type.HARVESTING,
        ["Excavation_Point"] = xi.helm.type.EXCAVATION,
        ["Logging_Point"   ] = xi.helm.type.LOGGING,
        ["Mining_Point"    ] = xi.helm.type.MINING,
    }
    local helmType = helmTypes[targetName]
    if helmType == nil then
        player:PrintToPlayer("Invalid target.")
        return
    end

    local swings = 0
    local misses = 0
    local breaks = 0
    local items = {}
    local uniqueItems = 0

    while true do
        swings = swings + 1
        local item = xi.helm.pickItem(player, helmType)
        if item == 0 then
            misses = misses + 1
        elseif items[item] == nil then
            table.insert(items, item)
            items[item] = 1
            uniqueItems = uniqueItems + 1
        else
            items[item] = items[item] + 1
        end

        breaks = breaks + xi.helm.doesToolBreak(player, helmType)

        local uses = (target:getLocalVar("uses") - 1) % 4
        target:setLocalVar("uses", uses)
        if uses == 0 then
            xi.helm.movePoint(target, player:getZoneID(), helmType)
            break
        end
    end

    local printStr = string.format([[
Swings: %d
Misses: %d
Breaks: %d
-----------------------------
]], swings, misses, breaks)

    if uniqueItems ~= 0 then
        printStr = printStr.."Gathered the following items:"
        for i, item in ipairs(items) do
            printStr = printStr..string.format("\n%s x%d", GetItemNameByID(item):gsub("_", " "), items[item])
        end
    else
        printStr = printStr.."Gathered no items."
    end

    player:PrintToPlayer(printStr)
end
