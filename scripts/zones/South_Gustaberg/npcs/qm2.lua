-----------------------------------
-- Area: South Gustaberg
--  NPC: ???
-- Involved in Quest: Smoke on the Mountain
-- !pos 461 -21 -580 107
-----------------------------------
local ID = require("scripts/zones/South_Gustaberg/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if not player:needToZone() then
        player:setCharVar("SGusta_Sausage_Timer", 0)
    end
    if npcUtil.tradeHas(trade, 4372) then
        if player:getCharVar("SGusta_Sausage_Timer") == 0 then
            -- player puts sheep meat on the fire
            player:messageSpecial(ID.text.FIRE_PUT, 4372)
            player:confirmTrade()
            player:setCharVar("SGusta_Sausage_Timer", os.time() + 60) -- 1 minute earth time
            player:needToZone(true)
        else
            -- message given if sheep meat is already on the fire
            player:messageSpecial(ID.text.MEAT_ALREADY_PUT, 4372)
        end
    end
end

function onTrigger(player, npc)
    if not player:needToZone() then
        player:setCharVar("SGusta_Sausage_Timer", 0)
    end

    local sausageTimer = player:getCharVar("SGusta_Sausage_Timer")

    if player:getQuestStatus(BASTOK, tpz.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN) ~= QUEST_AVAILABLE then
        if sausageTimer == 0 then
            player:messageSpecial(ID.text.FIRE_GOOD)
        elseif os.time() < sausageTimer then
            player:messageSpecial(ID.text.FIRE_LONGER, 4372)
        elseif player:getFreeSlotsCount() < 1 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4395)
        else
            player:setCharVar("SGusta_Sausage_Timer", 0)
            player:messageSpecial(ID.text.FIRE_TAKE, 4395)
            player:addItem(4395)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
