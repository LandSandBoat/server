-----------------------------------
--  NPC: ??? (QM5)
-- Type: Eggblix (dice roll game part 3)
-- !pos -462.436 2.456 -141.171 191
-- Involved in quest "As Thick As Thieves"
-----------------------------------
local ID = require("scripts/zones/Dangruf_Wadi/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)

    local thickAsThievesGamblingCS = player:getCharVar("thickAsThievesGamblingCS")

    if npcUtil.tradeHas(trade, 4362) then -- Trade 1x lizard egg
        if thickAsThievesGamblingCS == 4 then
            local rand1 = math.random(1, 999)
            local rand2 = math.random(1, 999)

            if (rand1 > rand2) then
                player:messageSpecial(ID.text.YOU_PLACE_ITEM, 0, 4362)
                player:startEvent(138, 1092, 0, rand1, rand2) -- complete 3/3 gamble mini quest
            else
                player:messageSpecial(ID.text.YOU_PLACE_ITEM, 0, 4362)
                player:startEvent(141, 0, 0, rand1, rand2) -- player looses
            end
        elseif thickAsThievesGamblingCS < 4 then -- trading out of order
            player:messageSpecial(ID.text.JUST_WONT_DO)
        elseif thickAsThievesGamblingCS > 4 then
            player:messageSpecial(ID.text.BEAT_EGGBLIX)
        end
    end

end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.BROKEN_EGGS)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 138 or csid == 141) and option == 2 then -- player gives up
        player:confirmTrade()
        player:messageSpecial(ID.text.YOU_GAVE_UP)
    elseif csid == 141 and option == 1 then -- player looses dice game
        player:confirmTrade()
        player:messageSpecial(ID.text.GOBLIN_BEAT_YOU)
    elseif csid == 138 and option == 0 then -- player wins dice game
        player:confirmTrade()
        player:messageSpecial(ID.text.YOU_BEAT_GOBLIN)
        player:setCharVar("thickAsThievesGamblingCS", 5)
    end

end
