-----------------------------------
-- Unlock Mog Wardrobe slots as you complete missions
-----------------------------------
require('modules/module_utils')
require('scripts/globals/missions')
-----------------------------------
local m = Module:new('mission_wardrobe_unlocks')

local unlocks =
{
    [xi.mission.log_id.ZILART] =
    {
        [xi.mission.id.zilart.ARK_ANGELS] = { xi.inv.WARDROBE_3, 5 },
    },
}

local bagNames =
{
    [xi.inv.INVENTORY]   = 'Inventory',
    [xi.inv.MOG_SAFE]    = 'Mog Safe',
    [xi.inv.STORAGE]     = 'Storage',
    [xi.inv.TEMP_ITEMS]  = 'Temp. Items',
    [xi.inv.MOG_LOCKER]  = 'Mog Locker',
    [xi.inv.MOG_SATCHEL] = 'Mog Satchel',
    [xi.inv.MOG_SACK]    = 'Mog Sack',
    [xi.inv.MOG_CASE]    = 'Mog Case',
    [xi.inv.WARDROBE]    = 'Mog Wardrobe 1',
    [xi.inv.MOG_SAFE_2]  = 'Mog Safe 2',
    [xi.inv.WARDROBE_2]  = 'Mog Wardrobe 2',
    [xi.inv.WARDROBE_3]  = 'Mog Wardrobe 3',
    [xi.inv.WARDROBE_4]  = 'Mog Wardrobe 4',
    [xi.inv.WARDROBE_5]  = 'Mog Wardrobe 5',
    [xi.inv.WARDROBE_6]  = 'Mog Wardrobe 6',
    [xi.inv.WARDROBE_7]  = 'Mog Wardrobe 7',
    [xi.inv.WARDROBE_8]  = 'Mog Wardrobe 8',
    [xi.inv.RECYCLE_BIN] = 'Recycle Bin',
}

m:addOverride('xi.player.charCreate', function(player)
    super(player)

    -- NOTE: These will all be clamped between 0-80,
    --     : so using -80 is fine
    player:changeContainerSize(xi.inv.WARDROBE,  -80)
    player:changeContainerSize(xi.inv.WARDROBE_2, -80)
    player:changeContainerSize(xi.inv.WARDROBE_3, -80)
    player:changeContainerSize(xi.inv.WARDROBE_4, -80)
    player:changeContainerSize(xi.inv.WARDROBE_5, -80)
    player:changeContainerSize(xi.inv.WARDROBE_6, -80)
    player:changeContainerSize(xi.inv.WARDROBE_7, -80)
    player:changeContainerSize(xi.inv.WARDROBE_8, -80)
end)

m:addOverride('npcUtil.completeMission', function(player, logId, missionId, params)
    local result = super(player, logId, missionId, params)

    if result and unlocks[logId] and unlocks[logId][missionId] then
        local unlock = unlocks[logId][missionId]
        local bag = unlock[1]
        local bagName = bagNames[bag]
        local bagIncrease = unlock[2]

        local oldSize = player:getContainerSize(bag)
        player:changeContainerSize(bag, bagIncrease)
        local newSize = player:getContainerSize(bag)

        local str = string.format(
            '%s capacity has been increased by %i from %i to %i',
            bagName, bagIncrease, oldSize, newSize)

        player:printToPlayer(str, xi.msg.channel.SYSTEM_3, '')
    end

    return result
end)
