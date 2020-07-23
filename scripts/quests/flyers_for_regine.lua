-----------------------------------
-- Flyers for Regine
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

quests = quests or {}
quests.flyers_for_regine = quests.flyers_for_regine or {}

-------------------------------------------------
-- local data
-------------------------------------------------

-- [ffr]deliveryMask stores delivered fliers as bits (0 = not delivered, 1 = delivered)
-- the key in this table relates to the bit in the mask
-- region is the region in the zone around the NPC, for trigging the approach message
-- offset is the message that plays when approaching the NPC (offset from FFR_LOOKS_CURIOUSLY_BASE)

local npcData =
{
    [tpz.zone.PORT_SAN_DORIA] =
    {
        [ 0] = {region = 1, x =   76.331, z = -128.655, offset = 0, npc = 'Answald'},
        [ 1] = {region = 2, x =  -13.768, z =  -95.857, offset = 1, npc = 'Prietta'},
        [ 2] = {region = 3, x =    0.750, z =  -81.438, offset = 2, npc = 'Miene'},
        [ 3] = {region = 4, x =  -21.999, z = -106.877, offset = 3, npc = 'Portaure'},
        [ 4] = {region = 5, x =  -37.821, z =   40.949, offset = 4, npc = 'Auvare'},
    },
    [tpz.zone.NORTHERN_SAN_DORIA] =
    {
        [ 5] = {region = 2, x =  146.420, z =  127.601, offset = 0, npc = 'Coullene'},
        [ 6] = {region = 3, x = -159.082, z =  253.794, offset = 1, npc = 'Guilberdrier'},
        [ 7] = {region = 4, x = -156.242, z =   49.184, offset = 2, npc = 'Boncort'},
        [ 8] = {region = 5, x = -127.355, z =  130.461, offset = 3, npc = 'Capiria'},
        [ 9] = {region = 6, x = -157.524, z =  263.818, offset = 4, npc = 'Villion'},
    },
    [tpz.zone.SOUTHERN_SAN_DORIA] =
    {
        [10] = {region = 2, x =   33.033, z =  -30.119, offset = 0, npc = 'Blendare'},
        [11] = {region = 3, x =   69.895, z =   41.073, offset = 1, npc = 'Rosel'},
        [12] = {region = 4, x =  105.147, z =  -16.735, offset = 3, npc = 'Maugie'},
        [13] = {region = 5, x =   80.378, z =  -24.644, offset = 5, npc = 'Adaunel'},
        [14] = {region = 6, x = -136.322, z =   21.958, offset = 7, npc = 'Leuveret'},
    },
}

-------------------------------------------------
-- public functions
-------------------------------------------------

quests.flyers_for_regine.initZone = function(zone)
    local data = npcData[zone:getID()]

    if data then
        for k, v in pairs(data) do
            zone:registerRegion(v.region, v.x, 10, v.z, 0, 0, 0)
        end
    end
end

quests.flyers_for_regine.onRegionEnter = function(player, region)
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED then
        local zoneId = player:getZoneID()
        local regionId = region:GetRegionID()
        local data = npcData[zoneId]

        if data then
            for k, v in pairs(data) do
                if v.region == regionId then
                    local mask = player:getCharVar('[ffr]deliveryMask')
                    local alreadyDelivered = bit.band(mask, 2^k) ~= 0

                    if not alreadyDelivered then
                        local ID = zones[zoneId]
                        player:messageSpecial(ID.text.FFR_LOOKS_CURIOUSLY_BASE + v.offset)
                    end

                    break
                end
            end
        end
    end
end

quests.flyers_for_regine.onTrade = function(player, npc, trade, ffrId)
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 532) then
        local zoneId = player:getZoneID()
        local ID = zones[zoneId]
        local mask = player:getCharVar('[ffr]deliveryMask')
        local alreadyDelivered = bit.band(mask, 2^ffrId) ~= 0

        if alreadyDelivered then
            player:messageSpecial(ID.text.FLYER_ALREADY)
        else
            local data = npcData[zoneId][ffrId]

            player:messageSpecial(ID.text.FLYER_ACCEPTED)
            player:showText(npc, ID.text['FFR_' .. string.upper(data.npc)])
            player:setCharVar('[ffr]deliveryMask', bit.bor(mask, 2^ffrId))
            player:confirmTrade()
        end
    end
end

-- shorthand
quests.ffr = quests.flyers_for_regine
