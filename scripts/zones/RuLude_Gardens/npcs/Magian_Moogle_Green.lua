-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Green Bobble)
-- Type: Magian Trials NPC (Job Emotes)
-- !pos -4.558 2.451 111.305 64
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/magiantrials")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.settings.main.ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    --[[ TODO
    if trade:getItemCount() == 1 then
        local itemID = trade:getItemId()
        local trialInfo = getEmoteTrialInfo(itemID)
        local invalid = 0
        if trialInfo.t1 == 0 and trialInfo.t2 == 0 and trialInfo.t3 == 0 and trialInfo.t4 == 0 then
            invalid = 1
        end
        player:startEvent(10153, trialInfo.t1, trialInfo.t2, trialInfo.t3, trialInfo.t4, 0, itemID, 0, invalid)
    else
        -- placeholder for torque+other required item trade.
    end
    ]]
end

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    if player:getMainLvl() < 30 then
        player:startEvent(10151)
    elseif
        player:getCharVar("MetGreenMagianMog") == 0 and
        not player:hasKeyItem(xi.ki.MAGIAN_LEARNERS_LOG)
    then
        if not player:hasKeyItem(xi.ki.MAGIAN_TRIAL_LOG) then
            player:startEvent(10160, 0)
        else
            player:startEvent(10160, 1)
        end
    else
        player:startEvent(10152) -- parameters unknown
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10160 and option == 1 then
        if not player:hasKeyItem(xi.ki.MAGIAN_TRIAL_LOG) then
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAGIAN_LEARNERS_LOG)
            player:addKeyItem(xi.ki.MAGIAN_LEARNERS_LOG)
        end

        player:setCharVar("MetGreenMagianMog", 1)
    end
end

return entity
