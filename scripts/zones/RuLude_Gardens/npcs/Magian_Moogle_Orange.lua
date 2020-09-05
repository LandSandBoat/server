-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Orange Bobble)
-- Type: Magian Trials NPC (Weapon/Empyrean Armor)
-- !pos -11 2.453 118 64
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/magiantrials")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1) then
        local ItemID = trade:getItemId()
        local TrialInfo = getTrialInfo(ItemID)
        local invalid = 0
        if (TrialInfo.t1 == 0 and TrialInfo.t2 == 0 and TrialInfo.t3 == 0 and TrialInfo.t4 == 0) then
            invalid = 1
        end
        player:startEvent(10124, TrialInfo.t1, TrialInfo.t2, TrialInfo.t3, TrialInfo.t4, 0, ItemID, 0, invalid)
    else
        -- placeholder for multi item trades such as geode etc.
    end
end

function onTrigger(player, npc)
    if (player:getMainLvl() < 75) then
        player:startEvent(10121)
    elseif (player:hasKeyItem(tpz.ki.MAGIAN_TRIAL_LOG) == false) then
        player:startEvent(10122)
    else
        player:startEvent(10123) -- parameters unknown
    end
end

function onEventUpdate(player, csid, option)
    if (csid == 10124) then
        local ItemID =0
        if (option == 4456449) then
            ItemID = 19327
        elseif (option == 4456449) then
            ItemID = 19327
        end
        magianOrangeEventUpdate(player, ItemID, csid, option)
    end
end

function onEventFinish(player, csid, option)
    if (csid == 10122 and option == 1) then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MAGIAN_TRIAL_LOG)
        player:addKeyItem(tpz.ki.MAGIAN_TRIAL_LOG)
    --elseif
        --
    end
end
