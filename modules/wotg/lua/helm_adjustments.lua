-----------------------------------
-- Module: HELM Adjustments (Wings of the Goddess Era)
-- Desc: Removes items that were added to existing zone HELM rewards during the WotG era
-- Source:
--  Eastern Ginger Root: https://www.bg-wiki.com/ffxi/June_2008_Version_Update_Changes#Other_Usable_Items
--  Dyer's Woad: https://www.bg-wiki.com/ffxi/September_2008_Version_Update_Changes#Other_Usable_Items
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('wotg_helm_adjustments')

local removals =
{
    [xi.helmType.HARVESTING] =
    {
        [xi.zone.BHAFLAU_THICKETS] =
        {
            xi.item.EASTERN_GINGER_ROOT,
        },

        [xi.zone.GIDDEUS] =
        {
            xi.item.SPRIG_OF_DYERS_WOAD,
        },

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            xi.item.EASTERN_GINGER_ROOT,
        },

        [xi.zone.WEST_SARUTABARUTA] =
        {
            xi.item.SPRIG_OF_DYERS_WOAD,
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
