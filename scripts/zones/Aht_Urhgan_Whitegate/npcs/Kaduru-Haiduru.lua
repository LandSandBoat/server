-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kaduru-Haiduru
-- Teleport NPC
-----------------------------------
require("scripts/globals/zone")
-----------------------------------
local entity = {}

local function canUse_KaduruHaiduru_Service(player)
    local caughtUsingShihuDanhuDate = player:getCharVar("Kaduru_ShihuDanhu_date")
    local shihuDanhuEncounters = player:getCharVar("ShihuDanhu_Encounters")
    local shihuDanhuDate = player:getCharVar("ShihuDanhu_TP_date")

    -- Kaduru-Haiduru can be used unless the following are true.
    if (shihuDanhuEncounters > 1 and os.time() < shihuDanhuDate) or
        (os.time() < caughtUsingShihuDanhuDate) then
        return false
    end
    return true
end

entity.onTrigger = function(player, npc)
    local caughtUsingShihuDanhuDate = player:getCharVar("Kaduru_ShihuDanhu_date")
    local shihuDanhuDate = player:getCharVar("ShihuDanhu_TP_date")
    local timesUsed = player:getCharVar("Kaduru_TimesUsed")

    if canUse_KaduruHaiduru_Service(player) then
        player:startEvent(151, 0, 0, timesUsed, 0, 0, 0, 0, 0, 0)
    else
        if caughtUsingShihuDanhuDate == 0 then
            player:setCharVar("Kaduru_ShihuDanhu_date", getVanaMidnight())
            player:setCharVar("Kaduru_TimesUsed", 0)
        end
        player:startEvent(153, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
end

entity.onTrade = function(player, npc, trade)
    local caughtUsingShihuDanhuDate = player:getCharVar("Kaduru_ShihuDanhu_date")
    local shihuDanhuDate = player:getCharVar("ShihuDanhu_TP_date")
    local timesUsed = player:getCharVar("Kaduru_TimesUsed")

    if canUse_KaduruHaiduru_Service(player) and timesUsed == 3 then
        if trade:getItemCount() == 1 then
            if trade:hasItemQty(2185, 1) then
                player:startEvent(154, 0, player:getNation(), 0, 0, 0, 0, 0, 0, 0)
                player:setCharVar("ShihuDanhu_TP_date", 0)
                player:setCharVar("Kaduru_ShihuDanhu_date", 0)
            end
        end
    elseif canUse_KaduruHaiduru_Service(player) and timesUsed < 3 then
        if trade:getItemCount() == 1 then
            if trade:hasItemQty(2185, 1) then
                player:startEvent(152, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                player:setCharVar("ShihuDanhu_TP_date", 0)
                player:setCharVar("Kaduru_ShihuDanhu_date", 0)
            end
        end
    else
        if caughtUsingShihuDanhuDate == 0 then
            player:setCharVar("Kaduru_ShihuDanhu_date", getVanaMidnight())
            player:setCharVar("Kaduru_TimesUsed", 0)
        end
        player:startEvent(155, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local timesUsed = player:getCharVar("Kaduru_TimesUsed")
    if csid == 154 then        -- At this point we should already have used Kaduru-Haiduru 3 times.
        if option == 1 then       -- Duchy of Jeuno
            player:setPos(0, 3, -6, 190, 243)
        elseif option == 2 then   -- Nation of Allegiance
            local nationDestination =
            {
                [xi.nation.SANDORIA] = {110,   0,  -7, 175, 231},
                [xi.nation.BASTOK  ] = { 90,   0, -67, 248, 234},
                [xi.nation.WINDURST] = {192, -12, 218,  60, 240}
            }
            player:setPos(unpack(nationDestination[player:getNation()]))
        end
        player:tradeComplete()
    elseif csid == 152 then    -- Duchy of Jeuno only
        -- We have either not used Kaduru-Haiduru enough, or we were reset after using Shihu-Danhu.
        player:setPos(0, 3, -6, 190, 243)
        if timesUsed < 3 then
            player:setCharVar("Kaduru_TimesUsed", (timesUsed + 1))
        end
        player:tradeComplete()
    end
end

return entity
