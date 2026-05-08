-----------------------------------
-- Module: HELM Adjustments (Abyssea Era)
-- Desc: Removes items that were added to existing zone HELM rewards during the Abyssea era
-- Source:
--  Aquilaria Log: https://www.bg-wiki.com/ffxi/September_2010_Version_Update_Changes#Usable_Items
--  Butterpear and Kapor Log: https://www.bg-wiki.com/ffxi/September_2011_Version_Update_Changes#Wings_of_the_Goddess_Quests
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('abyssea_helm_adjustments')

local removals =
{
    [xi.helmType.LOGGING] =
    {
        [xi.zone.YHOATOR_JUNGLE] =
        {
            xi.item.BUTTERPEAR,
            xi.item.AQUILARIA_LOG,
            xi.item.KAPOR_LOG,
        },

        [xi.zone.YUHTUNGA_JUNGLE] =
        {
            xi.item.AQUILARIA_LOG,
        },
    },
}

local removeItems = function(drops, itemsToRemove)
    local removeSet = {}
    for _, itemId in ipairs(itemsToRemove) do
        removeSet[itemId] = true
    end

    local filtered = {}
    for _, entry in ipairs(drops) do
        if not removeSet[entry[2]] then
            filtered[#filtered + 1] = entry
        end
    end

    return filtered
end

-- Apply removals to xi.helm.dataTable.
for helmType, zones in pairs(removals) do
    local helmData = xi.helm.dataTable[helmType]
    if helmData then
        for zoneId, itemsToRemove in pairs(zones) do
            local zoneData = helmData.zone[zoneId]
            if zoneData and zoneData.drops then
                zoneData.drops = removeItems(zoneData.drops, itemsToRemove)
            end
        end
    end
end

return m
