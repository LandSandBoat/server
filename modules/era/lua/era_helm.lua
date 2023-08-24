-----------------------------------
--          Era HELM
-----------------------------------
require("scripts/globals/shop")
require("modules/module_utils")
require("scripts/globals/helm")

local m = Module:new("era_helm")

-- RotZ release:    17 April     2003
-- CoP release:     21 September 2004
-- ToAU release:    18 April     2006
-- WotG release:    20 November  2007
-- Abyssea release: 22 June      2010

-- Default items removed
local itemsRemoved =
{
    xi.items.DRAGON_FRUIT,        -- 24 November  2007 (WotG)
    xi.items.SPRIG_OF_DYERS_WOAD, -- 9 September  2008 (WotG)
    xi.items.AQUILARIA_LOG,       -- 22 September 2010 (Abyssea)
    xi.items.BUTTERPEAR,          -- 20 September 2011 (Abyssea)
    xi.items.KAPOR_LOG,           -- 21 December  2011 (Abyssea)
}

--[[
-----------------------------------
--       Override settings
-----------------------------------
    xi.settings.era_helm =
    {
        REMOVE =
        {
            5662, -- Dragon Fruit  (WotG)
            2713, -- Dyer's Woad   (WotG)
            731,  -- Aquilaria Log (Abyssea)
            5908, -- Butterpear    (Abyssea)
            732,  -- Kapor Log     (Abyssea)
        }
    }
]]

if xi.settings[m.name] and xi.settings[m.name].REMOVE then
    itemsRemoved = xi.settings[m.name].REMOVE
end

local function isRemoved(itemId)
    for i = 1, #itemsRemoved do
        if itemsRemoved[i] == itemId then
            return true
        end
    end

    return false
end

for _, helmType in pairs(xi.helm.helmInfo) do
    for _, zone in pairs(helmType.zone) do
        for k, item in pairs(zone.drops) do
            if isRemoved(item[2]) then
                table.remove(zone.drops, k)
            end
        end
    end
end

return m
