-----------------------------------
-- Area: Windurst Waters
--  NPC: Voidwatch Officer
-- Voidwatch NPC — issues stratum abyssites, voidstones, sells periapts/cells for cruor
-- !pos -27.500 -5.396 225.500 238
-----------------------------------
require('scripts/globals/voidwatch')
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Event CSIDs for this zone (from xi-tinkerer DAT decode)
-- 1035 = main menu (present nation: What will you do?)
-- 1036 = main menu (past nation variant)
-- 1037 = ops briefing / stratum abyssite issuance
-- 1039-1043 = sub-menus (questions, ops details, voidstone, rewards, etc.)
-- 1024 = shared/atmacite related
local csids =
{
    MAIN_MENU        = 1035,
    MAIN_MENU_PAST   = 1036,
    OPS_BRIEFING     = 1037,
    SUB_MENU_1       = 1039,
    SUB_MENU_2       = 1040,
    SUB_MENU_3       = 1041,
    SUB_MENU_4       = 1042,
    SUB_MENU_5       = 1043,
    SHARED           = 1024,
}

entity.onTrigger = function(player, npc)
    local hasAlarum = xi.voidwatch.hasAlarum(player)
    local cruor = player:getCurrency('cruor')
    local voidstones = xi.voidwatch.getVoidstoneCount(player)
    local capacity = xi.voidwatch.getVoidstoneCapacity(player)

    local stratumBits = 0
    for path = 1, 8 do
        local tier = xi.voidwatch.getPathTier(player, path)
        if tier > 0 then
            stratumBits = bit.bor(stratumBits, bit.lshift(tier, (path - 1) * 4))
        end
    end

    printf('[VW_Officer] onTrigger: hasAlarum=%s cruor=%d voidstones=%d capacity=%d stratumBits=%d',
        tostring(hasAlarum), cruor, voidstones, capacity, stratumBits)

    player:startEvent(csids.MAIN_MENU, cruor, voidstones, capacity, stratumBits, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    printf('[VW_Officer] onEventUpdate: csid=%d option=%d (0x%08X)', csid, option, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    printf('[VW_Officer] onEventFinish: csid=%d option=%d (0x%08X)', csid, option, option)

    if option == 0 or option == 0xFFFFFFFF then
        return
    end

    local selection = bit.band(option, 0xFF)
    local subOption = bit.band(bit.rshift(option, 8), 0xFF)
    local param3 = bit.band(bit.rshift(option, 16), 0xFF)
    local param4 = bit.band(bit.rshift(option, 24), 0xFF)
    printf('[VW_Officer]   parsed: sel=%d sub=%d p3=%d p4=%d', selection, subOption, param3, param4)
end

return entity
