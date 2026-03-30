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

-- Event CSIDs (from xi-tinkerer DAT decode + in-game verification)
-- 1024 = main menu ("What will you do?" with ops/questions/rewards)
--        param1 = nation (0=Sandy, 1=debug?, 2=Windurst, 3=debug?)
--        param2 = cruor
--        params 3-7 = TBD (voidstones, stratum data, etc.)
-- 1035 = dispatch/recruitment dialogue (no alarum)
-- 1036-1037 = jurisdiction-specific ops briefings
-- 1039-1043 = jurisdiction sub-menus
local csids =
{
    MAIN_MENU = 1024,
    DISPATCH  = 1035,
}

entity.onTrigger = function(player, npc)
    local hasAlarum = xi.voidwatch.hasAlarum(player)
    local cruor = player:getCurrency('cruor')
    local nation = player:getNation()

    printf('[VW_Officer] onTrigger: hasAlarum=%s nation=%d cruor=%d',
        tostring(hasAlarum), nation, cruor)

    if not hasAlarum then
        player:startEvent(csids.DISPATCH, 0, 0, 0, 0, 0, 0, 0)
    else
        -- param1: jurisdiction flag (6=Sandy/Crimson, 10=Bastok/Indigo, 14=Windurst/Jade)
        local jurisdictionFlag = 14
        player:startEvent(csids.MAIN_MENU, jurisdictionFlag, cruor, 0, 0, 0, 0, 0)
    end
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
