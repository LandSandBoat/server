-----------------------------------
-- Module: HELM Adjustments
-- Desc: Removes items that were added to existing zone HELM rewards after the selected era
-- Source:
--  Eastern Ginger Root: https://www.bg-wiki.com/ffxi/June_2008_Version_Update_Changes#Other_Usable_Items
--  Dyer's Woad: https://www.bg-wiki.com/ffxi/September_2008_Version_Update_Changes#Other_Usable_Items
--  Aquilaria Log: https://www.bg-wiki.com/ffxi/September_2010_Version_Update_Changes#Usable_Items
--  Butterpear and Kapor Log: https://www.bg-wiki.com/ffxi/September_2011_Version_Update_Changes#Wings_of_the_Goddess_Quests
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_helm_adjustments')

local removalsByContent =
{
    ABYSSEA =
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
    },

    WOTG =
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

local applyRemovals = function(removals)
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
end

m:addOverrideByEra('xi.server.onServerStart', {
    [xi.expansion.ABYSSEA] = function()
        super()

        applyRemovals(removalsByContent.ABYSSEA)
    end,

    [xi.expansion.WOTG] = function()
        super()

        applyRemovals(removalsByContent.WOTG)
    end,
})
