-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Blue Bobble)
-- Type: Magian Trials NPC (Relic Armor)
-- !pos -6.843 2.459 121.9 64
-----------------------------------
require("scripts/globals/magiantrials")
require("scripts/globals/status")
-----------------------------------
local entity = {}
local EVENT_IDS = {
    [2] = 10141,
    [3] = 10142
    [4] = 10143,
    [5] = 10144,
    [6] = 10148
}

entity.onTrade = function(player,npc,trade)
    if ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    tpz.magian.magianOnTrade(player,npc,trade,tpz.itemType.ARMOR,EVENT_IDS)
end

entity.onTrigger = function(player,npc)
    if ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    tpz.magian.magianOnTrigger(player,npc,EVENT_IDS)
end

entity.onEventUpdate = function(player,csid,option)
    tpz.magian.magianEventUpdate(player,itemId,csid,option,EVENT_IDS)
end

entity.onEventFinish = function(player,csid,option)
    tpz.magian.magianOnEventFinish(player,itemId,csid,option,EVENT_IDS)
end

return entity
