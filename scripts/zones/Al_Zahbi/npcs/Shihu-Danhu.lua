-----------------------------------
-- Area: Al Zahbi
--  NPC: Shihu-Danhu
-- Warp NPC
-- !pos 62.768 -1.98 -51.299 48
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/besieged")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if tpz.besieged.getAstralCandescence() == 1 then
        player:startEvent(103)
    else
        player:messageSpecial(ID.text.NEED_CANDESCENCE_BACK) -- Missing the denied due to lack of Astral Candescence message.
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 103 and option == 1 then
        local shihuDanhuEncounters = player:getCharVar("ShihuDanhu_Encounters")
        -- If you use TP, you need to wait 1 real day for using Kaduru TP
        player:setCharVar("ShihuDanhu_TP_date", os.date("%j"))
        -- Update total number of Shihu-Danhu encounters.
        player:setCharVar("ShihuDanhu_Encounters", (shihuDanhuEncounters + 1))

        -- Random TP positions
        -- Coordinates marked {R} have been obtained by packet capture from retail. Don't change them.
        -- TODO: if we have astral candesence, then
        local warp = math.random(1, 5)
        if warp == 1 then
            player:setPos(-1.015, 8.999, -52.962, 192, 243)   -- Ru Lude Gardens (H-9)     {R}
        elseif warp == 2 then
            player:setPos(382.398, 7.314, -106.298, 160, 105) -- Batallia Downs (K-8)         {R}
        elseif warp == 3 then
            player:setPos(-327.238, 2.914, 438.421, 130, 120) -- Sauromugue Champaign        {R}
        elseif warp == 4 then
            player:setPos(213.785, 16.356, 419.961, 218, 110) -- Rolanberry Fields (J-6)   {R}
        elseif warp == 5 then
            player:setPos(167.093, 18.095, -213.352, 73, 126) -- Qufim Island (I-9)         {R}
        end

        -- TODO: elseif candesence is lost, then
        -- tele to bat downs, rolanberry, qufim, sauro. POSITIONS ARE DIFFERENT. need packet captures.
    end
end
