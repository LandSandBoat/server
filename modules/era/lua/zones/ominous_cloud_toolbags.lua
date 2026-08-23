-----------------------------------
-- Ominous Cloud Toolbag Adjustment Module
-- Limits the toolbags Ominous Cloud makes to the original ninja tools.
-- Shared across Port_Bastok, Southern_San_dOria, and Windurst_Woods.
-- Source: https://forum.square-enix.com/ffxi/threads/44592-Oct-7-2014-%28JST%29-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_ominous_cloud_toolbags', xi.pre(xi.expansion.SOA))

local function checkEligibility(player, trade)
    local toolList =
    {
        [xi.item.HIRAISHIN      ] = true,
        [xi.item.JUSATSU        ] = true,
        [xi.item.KAGINAWA       ] = true,
        [xi.item.KAWAHORI_OGI   ] = true,
        [xi.item.KODOKU         ] = true,
        [xi.item.MAKIBISHI      ] = true,
        [xi.item.MIZU_DEPPO     ] = true,
        [xi.item.SAIRUI_RAN     ] = true,
        [xi.item.SANJAKU_TENUGUI] = true,
        [xi.item.SHIHEI         ] = true,
        [xi.item.SHINOBI_TABI   ] = true,
        [xi.item.TSURARA        ] = true,
        [xi.item.UCHITAKE       ] = true,
    }

    for i = 0, 8 do
        local itemId = trade:getItemId(i)

        if
            itemId > 0 and
            itemId ~= xi.item.WIJNRUIT and
            not toolList[itemId]
        then
            player:messageSpecial(zones[player:getZoneID()].text.CLOUD_BAD_ITEM)
            return true
        end
    end

    return false
end

for _, zoneName in ipairs({ 'Port_Bastok', 'Southern_San_dOria', 'Windurst_Woods' }) do
    m:addOverride('xi.zones.' .. zoneName .. '.npcs.Ominous_Cloud.onTrade', function(player, npc, trade)
        if checkEligibility(player, trade) then
            return
        end

        super(player, npc, trade)
    end)
end
