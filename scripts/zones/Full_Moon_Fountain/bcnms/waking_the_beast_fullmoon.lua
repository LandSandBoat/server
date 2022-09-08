-----------------------------------
-- Area: Full Moon Fountain
-- BCNM: Waking the Beast
-----------------------------------
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/items")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local battlefield_object = {}

local loot =
{
    xi.items.CARBUNCLES_CUFFS,
    xi.items.IFRITS_BOW,
    xi.items.SHIVAS_SHOTEL,
    xi.items.TITANS_BASELARDE,
    xi.items.GARUDAS_SICKLE,
    xi.items.LEVIATHANS_COUSE,
    xi.items.RAMUHS_MACE,
}

battlefield_object.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("carbuncleHP", 20000)
    battlefield:setLocalVar("phase", 1)
end

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:hasCompletedQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)) and 1 or 0
        local lootChance = 25

        if battlefield:getLocalVar("loot") == 0 then
            battlefield:setLocalVar("loot", 1)
            for i = 1, 3 do
                if math.random(1,100) < lootChance then
                    player:addTreasure(loot[math.random(1,7)])
                    lootChance = lootChance - 10
                end
            end
        end
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:delKeyItem(xi.ki.EYE_OF_FLAMES)
        player:delKeyItem(xi.ki.EYE_OF_FROST)
        player:delKeyItem(xi.ki.EYE_OF_GALES)
        player:delKeyItem(xi.ki.EYE_OF_STORMS)
        player:delKeyItem(xi.ki.EYE_OF_TIDES)
        player:delKeyItem(xi.ki.EYE_OF_TREMORS)
        player:delKeyItem(xi.ki.RAINBOW_RESONATOR)

        player:addKeyItem(xi.ki.FADED_RUBY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.FADED_RUBY)

        if option == 0 then
            player:setCharVar("WTB_TITLE", 1)
        else
            player:setCharVar("WTB_TITLE", 0)
        end
    end
end

return battlefield_object
